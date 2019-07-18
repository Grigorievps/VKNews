//
//  NewsFeedPresenter.swift
//  VKNews
//
//  Created by Павел Григорьев on 12/07/2019.
//  Copyright (c) 2019 GP. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
  weak var viewController: NewsFeedDisplayLogic?
    
    var cellLayoutcalculator: NewsFeedCellLayoutcalculatorProtocol = NewsFeedCellLayoutcalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
    switch response {
    case .presentNewsFeed(let feed):
        
        let cells = feed.items.map { (feedItem) in
            cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
        }
        
        let feedViewModel = FeedViewModel(cells: cells)
        viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
    }
  }
  
    private func cellViewModel(from feedItem: NewsItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let photoAttachnent = self.photoAttachment(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let sizes = cellLayoutcalculator.sizes(postText: feedItem.text, photoAttachment: photoAttachnent)
        
        return FeedViewModel.Cell.init(sizes: sizes,
                                       photoAttachment: photoAttachnent,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: countFormatter(counter: feedItem.likes?.count),
                                       cooments: countFormatter(counter: feedItem.comments?.count),
                                       shares: countFormatter(counter: feedItem.reposts?.count),
                                       views: countFormatter(counter: feedItem.views?.count),
                                       iconURLString: profile.photo)
    }
    
    private func countFormatter(counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        var counterString = String(counter)
        if counterString.count > 3, counterString.count <= 6 {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6) + "M")
        }
        return counterString
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        let profilesOrGroups : [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    
    private func photoAttachment(feedItem: NewsItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachment.init(photoURLString: firstPhoto.srcBIG,
                                                          width: firstPhoto.width,
                                                          height: firstPhoto.height)
    }
}
