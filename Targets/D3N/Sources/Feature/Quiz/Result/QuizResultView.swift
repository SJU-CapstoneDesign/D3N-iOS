////
////  QuizResultView.swift
////  D3N
////
////  Created by 송영모 on 10/15/23.
////  Copyright © 2023 sju. All rights reserved.
////
//
//import Foundation
//import SwiftUI
//
//import ComposableArchitecture
//
//public struct QuizResultView: View {
//    let store: StoreOf<QuizResultStore>
//    
//    public var body: some View {
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            GeometryReader { proxy in
//                ScrollView {
//                    VStack(alignment: .leading) {
//                        titleView(collect: viewStore.state.collectCount, whole: viewStore.state.quizEntityList.count)
//                            .padding(.horizontal)
//                        
//                        quizResultItemsView()
//                        
//                        Spacer()
//                        
//                        MinimalButton(
//                            title: "처음으로",
//                            action: {
//                                viewStore.send(.firstButtonTapped)
//                            }
//                        )
//                        .padding()
//                    }
//                    .frame(minHeight: proxy.size.height)
//                }
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden()
//            .toolbar(.hidden, for: .tabBar)
//        }
//    }
//    
//    private func titleView(collect: Int, whole: Int) -> some View {
//        HStack(spacing: .zero) {
//            Text("\(whole)문제 중 ")
//                .fontWeight(.semibold)
//                .font(.title)
//            
//            Text("\(collect)")
//                .font(.title)
//                .fontWeight(.semibold)
//                .foregroundStyle(.mint)
//            
//            Text("문제를 맞췄습니다.")
//                .fontWeight(.semibold)
//                .font(.title)
//        }
//    }
//    
//    private func quizResultItemsView() -> some View {
//        VStack(spacing: 20) {
//            ForEachStore(self.store.scope(state: \.quizResultItems, action: QuizResultStore.Action.quizResultItems(id:action:))) {
//                QuizResultItemCellView(store: $0)
//            }
//        }
//    }
//}
