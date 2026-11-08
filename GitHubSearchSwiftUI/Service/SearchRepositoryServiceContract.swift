//
//  SearchRepositoryServiceContract.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/07
//  
//

protocol SearchRepositoryServiceContract {
    /// 検索(Async)
    func searchRepository(query: String) async -> Result<SearchRepositoryResponse, APIServiceError>
}
