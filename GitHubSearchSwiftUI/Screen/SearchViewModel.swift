//
//  SearchViewModel.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/08
//  
//

import Foundation
import Observation

@MainActor
@Observable
final class SearchViewModel {
    
    private let searchRepositoryService: SearchRepositoryServiceContract
    private(set) var state: State = .idle
    
    private var searchTask: Task<Void, Never>?
    
    enum State: Equatable {
        case idle
        case loading
        case success([ContentsDetail])
        case failure(String)
    }
    
    init(searchRepositoryService: SearchRepositoryServiceContract? = nil) {
        self.searchRepositoryService = searchRepositoryService ?? SearchRepositoryService()
    }
    
    /// 検索
    ///
    /// 通信は searchTask の中で続ける。この関数は通信が終わる前に戻る(Task の中で state を変更し反映される)。
    /// 次の search では、前の searchTask をキャンセルする。
    func search(query: String) async {
        let query = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return }
        
        searchTask?.cancel()
        searchTask = Task {
            state = .loading
            let result = await searchRepositoryService.searchRepository(query: query)
            guard !Task.isCancelled else {
                return
            }
            
            switch result {
            case .success(let response):
                let items = response.items.compactMap { repo -> ContentsDetail? in
                    guard let url = URL(string: repo.owner.avatarUrl) else {
                        return nil
                    }
                    return ContentsDetail(
                        iconImageUrl: url,
                        title: repo.name,
                        language: repo.language,
                        star: repo.stargazersCount,
                        description: repo.description,
                        url: repo.htmlUrl)
                }
                state = .success(items)
            case .failure(let error):
                state = .failure(error.localizedDescription)
            }
        }
    }
}
