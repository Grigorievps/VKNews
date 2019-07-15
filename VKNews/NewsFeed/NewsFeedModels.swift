//
//  NewsFeedModels.swift
//  VKNews
//
//  Created by Павел Григорьев on 12/07/2019.
//  Copyright (c) 2019 GP. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: NewsResponse)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel: FeedViewModel)
      }
    }
  }
  
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var cooments: String?
        var shares: String?
        var views: String?
        var iconURLString: String
    }
    let cells: [Cell]
}
