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
    // アラート表示の有無
    @State var isShowAlert = false
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
                    Text("残り\(timerValue - count)秒")
                        // 文字サイズを指定
                        .font(.largeTitle)
                    // 水平にレイアウト（横方向にレイアウト）
                    HStack {
                        // スタートボタン
                        Button(action: {
                            // タイマーのカウントダウン開始
                            startTimer()
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
                            // タイマーのカウントダウン停止
                            // timerHandlerをアンラップしてunwrapedTimeHandlerに代入
                            if let unwrapedTimerHandler = timerHandler {
                                // タイマーが実行中の場合、スタートしない
                                if unwrapedTimerHandler.isValid == true {
                                    // タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
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
            .onAppear {
                // カウント（経過時間）の変数を初期化
                count = 0
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
            // 状態変数isShowAlertがtrueになった時に実行される
            .alert(isPresented: $isShowAlert) {
                // アラート表示のレイアウト
                // アラート表示
                Alert(title: Text("終了"),
                      message: Text("タイマー終了時間です"),
                      dismissButton: .default(Text("OK"))
                )
            }
        }
        // iPadへ対応
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // 1秒毎に実行されてカウントダウンする
    func countDownTimer() {
        // count（経過時間）に+1していく
        count += 1
        
        // 残り時間が0以下のとき、タイマーを止める
        if timerValue - count <= 0 {
            // タイマー停止
            timerHandler?.invalidate()
            // アラート表示
            isShowAlert = true
        }
    }
    
    // タイマーをカウントダウン開始
    func startTimer() {
        // timerHandlerをアンラップしてunwrapedTimeHandlerに代入
        if let unwrapedTimerHandler = timerHandler {
            // タイマーが実行中の場合、スタートしない
            if unwrapedTimerHandler.isValid == true {
                return
            }
        }
        
        // 残り時間が0以下のとき、count（経過時間）を0に初期化する
        if timerValue - count <= 0 {
            // count（経過時間）を0に初期化する
            count = 0
        }
        
        // タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1,
                                            repeats: true) { _ in
            // タイマー実行時に呼び出される
            // 1秒毎に実行
            countDownTimer()
        }
    }
}

#Preview {
    ContentView()
}
