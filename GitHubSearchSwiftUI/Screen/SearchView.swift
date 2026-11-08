//
//  SearchView.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/08
//  
//

import SwiftUI

struct SearchView: View {
    @State private var model = SearchViewModel()
    @State private var query = ""
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 24) {
                Text("GitHubSearch SwiftUI")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                TextField("検索キーワードを入力", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.search)
                    .onSubmit {
                        Task { await model.search(query: query) }
                    }
            }
            ZStack {
                switch model.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.2)
                case .success(let items):
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(items, id: \.url) { item in
                                ContentsView(model: item)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                case .failure(let message):
                    Text(message)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    SearchView()
}
