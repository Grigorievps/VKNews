//
//  NetworkDataFetcher.swift
//  VKNews
//
//  Created by Павел Григорьев on 12/07/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getNews(response: @escaping (NewsResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    func getNews(response: @escaping (NewsResponse?) -> Void) {
        let params = ["filters": "post, photo"]
        networking.request(path: API.newsFeed) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decoderJSON(type: NewsResponseWrapped.self
                , from: data)
            response(decoded?.response)
        }
    }
    
    private func decoderJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
