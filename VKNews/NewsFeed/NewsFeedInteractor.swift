//
//  NewsFeedInteractor.swift
//  VKNews
//
//  Created by Павел Григорьев on 12/07/2019.
//  Copyright (c) 2019 GP. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {
    
    case .getNewsFeed:
        fetcher.getNews { [weak self] (feedResponse) in
            
            guard let feedResponse = feedResponse else { return }
            self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse))
        }
   
    }
  }
  
}
