//
//  SearchRepositoryResponse.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/07
//  
//

import Foundation

struct SearchRepositoryResponse: Decodable {
    let items: [Repository]
}
