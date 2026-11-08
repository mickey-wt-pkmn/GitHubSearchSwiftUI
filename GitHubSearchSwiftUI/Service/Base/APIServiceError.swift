//
//  APIServiceError.swift
//  GitHubSearchSwiftUI
//
//  Created by mickey-wp on 2026/11/07.
//

import Foundation

enum APIServiceError: Error {
    case invalidURL
    case responseError
    case parseError(Error)
}

extension APIServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL エラー"
        case .responseError:
            return "レスポンスエラー"
        case .parseError:
            return "パースエラー"
        }
    }
}
