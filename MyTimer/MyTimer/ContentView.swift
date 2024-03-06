//
//  ContentView.swift
//  MyTimer
//
//  Created by 河田佳之 on 2024/03/06.
//

import SwiftUI

struct ContentView: View {
    // タイマー変数を作成
    @State var timerHandler: Timer?
    // カウント（経過時間）の変数を作成
    @State var count = 0
    // 永続化する秒数設定（初期値は10）
    @AppStorage("timer_value") var timerValue = 10
    
    var body: some View {
        NavigationView {
            // 奥から手前方向にレイアウト
            ZStack {
                // 背景画像
                Image("backgroundTimer")
                    // リサイズする
                    .resizable()
                    // セーフエリアを超えて画面全体に配置します
                    .ignoresSafeArea()
                    // アスペクト比（縦横比）を維持して短辺基準に収まるようにする
                    .aspectRatio(contentMode: .fill)
                // 垂直にレイアウト（縦方向にレイアウト）
                // View（部品）間の間隔を３０にする
                VStack(spacing: 30.0) {
                    // テキストを表示する
                    Text("残り10秒")
                        // 文字サイズを指定
                        .font(.largeTitle)
                    // 水平にレイアウト（横方向にレイアウト）
                    HStack {
                        // スタートボタン
                        Button(action: {
                            
                        }, label: {
                            Text("スタート")
                                // 文字サイズを指定
                                .font(.title)
                                // 文字色を白に指定
                                .foregroundColor(Color.white)
                                // 幅高さを140に指定
                                .frame(width: 140, height: 140)
                                // 背景を指定
                                .background(Color("startColor"))
                                // 円型に切り抜く
                                .clipShape(Circle())
                        })
                        
                        // ストップボタン
                        Button(action: {
                            
                        }, label: {
                            Text("ストップ")
                                // 文字サイズを指定
                                .font(.title)
                                // 文字色を白に指定
                                .foregroundColor(Color.white)
                                // 幅高さを140に指定
                                .frame(width: 140, height: 140)
                                // 背景を指定
                                .background(Color("stopColor"))
                                // 円型に切り抜く
                                .clipShape(Circle())
                        })
                    }
                }
            }
            // ナビゲーションにボタンを追加
            .toolbar {
                // ナビゲーションバーの右にボタンを追加
                ToolbarItem(placement: .navigationBarTrailing) {
                    // ナビゲーション遷移
                    NavigationLink(destination: SettingView()) {
                        // テキストを表示
                        Text("秒数設定")
                    }
                }
            }
        }
        // iPadへ対応
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
