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
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
    switch response {
    
    case .some:
        print("some presenter")
    case .presentNewsFeed:
        print("presentNewsFeed presenter")
        viewController?.displayData(viewModel: .displayNewsFeed)
    }
  }
  
}
