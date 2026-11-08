//
//  SearchViewModelTests.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/08
//  
//

import XCTest
@testable import GitHubSearchSwiftUI

@MainActor
final class SearchViewModelTests: XCTestCase {
    
    /// 空文字テスト
    func testBlankQueryDoesNotSearch() async {
        let service = StubSearchRepositoryService()
        
        let model = SearchViewModel(searchRepositoryService: service)
        await model.search(query: "   ")
        
        XCTAssertEqual(service.callCount, 0)
        XCTAssertEqual(model.state, .idle)
    }
    
    /// 成功テスト
    func testSuccessUpdatesState() async {
        let service = StubSearchRepositoryService()
        service.result = .success(SearchRepositoryResponse(items: [sampleRepository]))
        
        let model = SearchViewModel(searchRepositoryService: service)
        await model.search(query: "swift")
        
        await waitForResult(model)
        XCTAssertEqual(service.callCount, 1)
        guard case .success(let items) = model.state else {
            return XCTFail("success ではない")
        }
        XCTAssertEqual(items.map(\.title), ["swift"])
    }
    
    // 失敗テスト
    func testFailureUpdatesState() async {
        let service = StubSearchRepositoryService()
        service.result = .failure(.responseError)
        
        let model = SearchViewModel(searchRepositoryService: service)
        await model.search(query: "swift")
        
        await waitForResult(model)
        XCTAssertEqual(service.callCount, 1)
        XCTAssertEqual(model.state, .failure("レスポンスエラー"))
    }
    
    private func waitForResult(_ model: SearchViewModel) async {
        let deadline = ContinuousClock().now.advanced(by: .seconds(1))
        while ContinuousClock().now < deadline {
            switch model.state {
            case .success, .failure:
                return
            case .idle, .loading:
                try? await Task.sleep(for: .milliseconds(10))
            }
        }
    }
}


// MARK: SampleRepository & StubService

private let sampleRepository = Repository(
    id: 1,
    name: "swift",
    description: "desc",
    stargazersCount: 10,
    language: "Swift",
    htmlUrl: "https://github.com/apple/swift",
    owner: Owner(id: 11, avatarUrl: "https://avatars.githubusercontent.com/u/9919?v=4")
)

private final class StubSearchRepositoryService: SearchRepositoryServiceContract {
    var result: Result<SearchRepositoryResponse, APIServiceError> = .failure(.responseError)
    private(set) var callCount = 0
    func searchRepository(query: String) async -> Result<SearchRepositoryResponse, APIServiceError> {
        callCount += 1
        return result
    }
}
