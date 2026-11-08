//
//  Repository.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/07
//  
//

import Foundation

struct Repository: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let language: String?
    let htmlUrl: String
    let owner: Owner
}
