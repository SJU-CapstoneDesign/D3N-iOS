////
////  QuizResultItemCellView.swift
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
//public struct QuizResultItemCellView: View {
//    let store: StoreOf<QuizResultItemCellStore>
//    
//    public var body: some View {
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            VStack {
//                VStack {
//                    titleView(viewStore: viewStore)
//                    
//                    quizResultListView(viewStore: viewStore)
//                }
//                .minimalBackgroundStyle()
//                
//                reasoneView(viewStore: viewStore)
//                    .minimalBackgroundStyle()
//            }
//            .padding(.horizontal)
//        }
//    }
//    private func titleView(viewStore: ViewStoreOf<QuizResultItemCellStore>) -> some View {
//        HStack {
//            Text(viewStore.state.quizEntity.question)
//                .font(.title3)
//                .fontWeight(.semibold)
//                .lineLimit(nil)
//                .fixedSize(horizontal: false, vertical: true)
//            
//            Spacer()
//        }
//    }
//    
//    private func quizResultListView(viewStore: ViewStoreOf<QuizResultItemCellStore>) -> some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Spacer()
//            }
//            ForEach(Array(viewStore.state.quizEntity.choiceList.enumerated()), id: \.offset) { index, choice in
//                Label(title: {
//                    Text(choice)
//                }, icon: {
//                    quizResultItemImage(
//                        current: index,
//                        answer: viewStore.state.quizEntity.answer,
//                        userAnswer: viewStore.state.quizEntity.selectedAnswer ?? 0
//                    )
//                })
//                .font(.subheadline)
//            }
//        }
//    }
//    
//    private func reasoneView(viewStore: ViewStoreOf<QuizResultItemCellStore>) -> some View {
//        HStack {
//            Text(viewStore.state.quizEntity.reason)
//                .font(.subheadline)
//                .lineLimit(nil)
//                .fixedSize(horizontal: false, vertical: true)
//            
//            Spacer()
//        }
//    }
//    
//    private func quizResultItemImage(current: Int, answer: Int, userAnswer: Int) -> some View {
//        VStack {
//            if current == answer && current == userAnswer {
//                return Image(systemName: "checkmark.circle.fill")
//                    .foregroundStyle(.mint)
//            } else if current == answer {
//                return Image(systemName: "checkmark.circle.fill")
//                    .foregroundStyle(.pink)
//            } else if current == userAnswer {
//                return Image(systemName: "circle.fill")
//                    .foregroundStyle(.foreground)
//            } else {
//                return Image(systemName: "circle")
//                    .foregroundStyle(.foreground)
//            }
//        }
//    }
//}
