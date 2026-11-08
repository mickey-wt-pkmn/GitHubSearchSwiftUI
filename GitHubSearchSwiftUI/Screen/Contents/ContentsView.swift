//
//  ContentsView.swift
//  GitHubSearchSwiftUI
//  
//  Created by mickey-wp on 2026/11/08
//  
//

import SwiftUI

struct ContentsView: View {
    
    let model: ContentsDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: model.iconImageUrl) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .overlay(Circle().stroke(.gray, lineWidth: 2))
            .shadow(color: .gray, radius: 1, x: 0, y: 0)
        
            Text(model.title)
                .foregroundStyle(.black)
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                Text(model.language ?? "")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "star")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                    Text(String(model.star))
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
            
            Text(model.description ?? "")
                .foregroundStyle(.black)
                .lineLimit(nil)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 1)
        )
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let input: ContentsDetail = .init(
        iconImageUrl: URL(string: "https://avatars.githubusercontent.com/u/9919?v=4")!,
        title: "SwiftUI",
        language: "Swift",
        star: 1000,
        description: "Declare the user interface and behavior for your app on every platform.",
        url: "https://github.com/")
    ContentsView(model: input)
}
