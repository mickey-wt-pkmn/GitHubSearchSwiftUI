//
//  APIService.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/07
//  
//

import Foundation

final class APIService: APIServiceContract {
    
    func request<Request>(with request: Request) async -> Result<Request.Response, APIServiceError> where Request: APIRequestType {
        guard var urlComponents = URLComponents(url: request.requestURL, resolvingAgainstBaseURL: true) else {
            return .failure(.invalidURL)
        }
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(Const.acceptValue, forHTTPHeaderField: Const.acceptHeader)
        urlRequest.addValue(Const.userAgentValue, forHTTPHeaderField: Const.userAgentHeader)
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            guard let httpStatus = urlResponse as? HTTPURLResponse else {
                return .failure(.responseError)
            }
            guard 200 ..< 300 ~= httpStatus.statusCode else {
                return .failure(.responseError)
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let responseData = try decoder.decode(Request.Response.self, from: data)
                return .success(responseData)
            } catch {
                return .failure(.parseError(error))
            }
        } catch {
            if let error = error as? APIServiceError {
                return .failure(error)
            } else {
                return .failure(APIServiceError.responseError)
            }
        }
    }
}
