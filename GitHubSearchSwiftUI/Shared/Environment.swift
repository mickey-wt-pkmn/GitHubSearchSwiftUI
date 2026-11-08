//
//  Environment.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/07
//  
//

import Foundation

final class Environment {
    /// インスタンス
    static let shared = Environment()
    /// 外部からの初期化を防ぐため private で init
    private init() {}
    
    var baseURL: String {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: Const.baseURLKey) as? String else {
            preconditionFailure()
        }
        return baseURL
    }
}
