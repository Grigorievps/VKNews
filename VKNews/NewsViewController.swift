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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.request(path: API.newsFeed) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
            }
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print("json: \(json)")
        }

   }
    

}
