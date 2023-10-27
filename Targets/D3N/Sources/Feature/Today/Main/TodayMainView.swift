//
//  TodayMainView.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TodayMainView: View {
    let store: StoreOf<TodayMainStore>
    @State private var isPressing = false
    
    public init(store: StoreOf<TodayMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack {
                    todayNewsView(viewStore: viewStore)
                        .padding()
                }
            }
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
            }
            .navigationTitle("Today")
        }
    }
    
    private func todayNewsView(viewStore: ViewStoreOf<TodayMainStore>) -> some View {
        VStack(alignment: .leading) {
            Text("최신 뉴스를 가져왔어요")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .fontWeight(.semibold)
            
            HStack {
                Text("오늘의 뉴스 3 문제")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("전체보기", action: {
                    viewStore.send(.allNewsButtonTapped)
                })
            }
            
            ForEachStore(self.store.scope(state: \.newsListItems, action: TodayMainStore.Action.newsListItems(id:action:))) {
                NewsListItemCellView(store: $0)
                    .padding(.vertical, 5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .clipped()
        .shadow(color: Color(uiColor: .systemGray5), radius: 20)
        .blur(radius: isPressing ? 3 : 0)
        .scaleEffect(isPressing ? 1.05 : 1.0)
        .gesture(
            LongPressGesture(minimumDuration: 0.01)
                .onChanged { _ in
                    withAnimation (.easeInOut(duration: 0.5)){
                        isPressing = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation (.easeInOut(duration: 0.2)){
                            isPressing = false
                    }
                }
            }
        )
    }
}
