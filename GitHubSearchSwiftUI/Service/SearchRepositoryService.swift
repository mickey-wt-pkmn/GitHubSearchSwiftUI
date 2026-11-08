//
//  SearchRepositoryService.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/07
//  
//

final class SearchRepositoryService: SearchRepositoryServiceContract {
    
    private let apiService: APIServiceContract
    
    init() {
        self.apiService = APIService()
    }
    
    func searchRepository(query: String) async -> Result<SearchRepositoryResponse, APIServiceError> {
        let request = SearchRepositoryRequest(query: query)
        return await apiService.request(with: request)
    }
}
