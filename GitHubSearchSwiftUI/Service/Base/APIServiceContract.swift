//
//  APIServiceContract.swift
//  GitHubSearchSwiftUI
//
//  Created by mickey-wp on 2026/11/07.
//

protocol APIServiceContract: Sendable {
    /// リクエスト
    func request<Request>(with request: Request) async -> Result<Request.Response, APIServiceError> where Request: APIRequestType
}
