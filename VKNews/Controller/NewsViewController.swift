//
//  NewsViewController.swift
//  VKNews
//
//  Created by Павел Григорьев on 11/07/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    private let networkService: Networking = NetworkService()
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetcher.getNews { (newsResponse) in
            guard let newsResponse = newsResponse else { return }
            newsResponse.items.map({ (newsItem) in
                print(newsItem.date)
            })
        }
   }
    

}
