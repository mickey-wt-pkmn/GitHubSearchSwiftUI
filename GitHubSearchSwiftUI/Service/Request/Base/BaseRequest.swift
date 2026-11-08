//
//  BaseRequest.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/07
//  
//

import Foundation

protocol BaseRequest: APIRequestType {}

extension BaseRequest {
    
    var baseURLString: String {
        return Environment.shared.baseURL
    }
}
