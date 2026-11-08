//
//  APIRequestType.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/07
//  
//

import Foundation

protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var baseURLString: String { get }
    var requestURL: URL { get }
}

extension APIRequestType {
    
    var requestURL: URL {
        guard let url = URL(string: path, relativeTo: URL(string: baseURLString)) else {
            preconditionFailure("can't create url.")
        }
        return url
    }
}
