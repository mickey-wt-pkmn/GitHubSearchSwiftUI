//
//  SearchRepositoryRequest.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/07
//  
//

import Foundation

struct SearchRepositoryRequest: BaseRequest {
    typealias Response = SearchRepositoryResponse
    
    var path: String {
        return "/search/repositories"
    }
    
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "q", value: query),
            .init(name: "sort", value: "stars"),
            .init(name: "order", value: "desc")
        ]
    }
    
    private let query: String
    
    init(query: String) {
        self.query = query
    }
}
