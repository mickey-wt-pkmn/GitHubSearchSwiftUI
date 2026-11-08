//
//  Environment.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/07
//  
//

import Foundation

final public class Environment {
    /// インスタンス
    public static let shared = Environment()
    /// 外部からの初期化を防ぐため private で init
    private init() {}
    
    public var baseURL: String {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: Const.baseURLKey) as? String else {
            preconditionFailure()
        }
        return baseURL
    }
}
