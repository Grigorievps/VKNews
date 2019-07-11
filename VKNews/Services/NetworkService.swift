//
//  NetworkService.swift
//  VKNews
//
//  Created by Павел Григорьев on 11/07/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import Foundation

final class NetworkService {
    
    private let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService = AppDelegate.shared().authenticationService) {
        self.authenticationService = authenticationService
    }
    
    private func url(from path: String) -> URL {
        let token = authenticationService.token
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = [URLQueryItem(name: "filters", value: "post,photo"),
                                URLQueryItem(name: "access_token", value: token),
                                URLQueryItem(name: "v", value: API.version),]
        
        return components.url!
    }
    
}
    // MARK: Networking implementation

extension NetworkService: Networking {
    func request(path: String, completion: @escaping (Data?, Error?) -> Void) {
        
//
//        let allParams = ["filters": "post,photo",
//                         "access_token": token,
//                         "v": API.version]
        let url = self.url(from: path)
        let session = URLSession.init(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
        print(url)
    }
    
    
}

    // MARK: Networking protocol

protocol Networking {
    func request(path: String, completion: @escaping (Data?, Error?) -> Void)
}
