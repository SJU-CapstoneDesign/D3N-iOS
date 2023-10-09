//
//  QuestionListView.swift
//  D3N
//
//  Created by 송영모 on 10/7/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct QuestionListView: View {
    let store: StoreOf<QuestionListStore>
    
    public init(store: StoreOf<QuestionListStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView {
                //                ForEach(viewModel.newsList, id: \.self) { news in
                //TODO: newsList 들어오면 연동하기
                GeometryReader { proxy in
                    VStack{
                        HStack {
                            Button(action: {}, label: {
                                Label("뉴스", systemImage: "chevron.down")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding()
                            })
                            Spacer()
                        }
                        .padding(.horizontal)
                        VStack {
                            Button(action: {}
                                   , label:{
                                Text("#주제")
                                    .multilineTextAlignment(.trailing)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.systemIndigo))
                                    .padding()
                            })
                            Spacer()
                            //TODO: 카테고리별 모든 뉴스 화면과 연결하기

                                Text("뉴스 제목")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .padding()
                                Spacer()
                                Text("뉴스 요약")
                                    .padding()
                                
                                //TODO: 아래에 넣을 추가 정보 혹은 디테일 구상
                            }
                        .frame(width: 300, height: 600)
                        .background(RoundedRectangle(
                            cornerRadius: 25, style: .continuous
                        )
                            .fill(Color(.systemIndigo))
                            .shadow(radius: 5, x: 5, y: 5)
                            .opacity(0.2)
                        ).padding()
                        
                        Button("next") {
                            viewStore.send(.nextButtonTapped)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    QuestionListView(store: .init(initialState: .init()) {
        QuestionListStore()
    })
}
