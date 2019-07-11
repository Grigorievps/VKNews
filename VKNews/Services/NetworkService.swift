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
    
    func getNews() {
        var components = URLComponents()
        
        guard let token = authenticationService.token else { return }
        
        var allParams = ["filters": "post,photo"]
        allParams["access_token"] = token
        allParams["v"] = API.version
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = allParams.map {URLQueryItem(name: $0, value: $1)}
        
        let url = components.url!
        print(url)
    }
}
