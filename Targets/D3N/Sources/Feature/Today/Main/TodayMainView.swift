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
    
    public func toggleIsPressing() {
        withAnimation(.easeOut(duration: 0.3)){
            isPressing.toggle()
        }
    }
    
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
            .task {
                viewStore.send(.onAppear, animation: .default)
            }
            .navigationTitle("Today")
        }
    }
    
    private func todayNewsView(viewStore: ViewStoreOf<TodayMainStore>) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            VStack(alignment: .leading){
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
                    }
                    )
                }
            }
            .padding([.horizontal, .top])
            .onTapGesture {
                viewStore.send(.allNewsButtonTapped)
                isPressing = false
            }
            
            VStack(alignment: .leading, spacing: .zero) {
                ForEachStore(self.store.scope(state: \.todayListItems, action: TodayMainStore.Action.todayListItems(id:action:))) {
                    TodayListItemCellView(store: $0)
                }
            }
            .padding(.bottom, 10)
        }
        .background(Color.background)
        .cornerRadius(20)
        .clipped()
        .shadow(color: .systemGray5, radius: 20)
    }
}
