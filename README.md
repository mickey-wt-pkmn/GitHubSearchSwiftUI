# GitHubSearchSwiftUI

同じ GitHub 検索仕様を **UIKit + Combine** と **SwiftUI + Observation** で書き分けた、アーキテクチャ比較・検証用のサンプルです。  
(UIKit 版はこちら: [GitHubSearchUIKit](https://github.com/mickey-wt-pkmn/GitHubSearchUIKit))

画面の状態管理は `@Observable`(Observation)、通信は async / await で実装しています。  
UIKit 版の Input / Output パターンにはあえて揃えず、SwiftUI の標準的な MVVM で構成しました。

## 動作
検索欄で文字を入力し、キーボードの検索ボタンで検索します。入力のたびには検索しません。

## 構成
- `SearchViewModel` は `@Observable` です
- 画面は `state`(`idle` / `loading` / `success` / `failure`)を読んで表示を切り替えます
- 検索は `search(query:)` を呼び出し、再検索時は直前の `Task` をキャンセルします
- `SearchViewModelTests` で空文字・成功・失敗のテストを実装しています
- GitHub の未認証 Search API には回数制限(1分あたり10回)があります

## 動作環境
- Xcode 27.2 / iOS 27.2