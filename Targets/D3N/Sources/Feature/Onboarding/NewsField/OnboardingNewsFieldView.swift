//
//  OnboardingNewsFieldView.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

struct OnboardingNewsFieldView: View {
    let store: StoreOf<OnboardingNewsFieldStore>
    
    init(store: StoreOf<OnboardingNewsFieldStore>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    Text("관심있는 뉴스를 선택해주세요.")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(.bottom, 40)
                
                newsFieldView(viewStore: viewStore)
                
                Spacer()
                
                D3NSubmitButton(
                    activeTitle: "이제 끝이에요!",
                    inactiveTitle: "선택해주세요",
                    isActive: !viewStore.state.newsFields.isEmpty
                ) { _ in
                    viewStore.send(.submitButtonTapped)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
    
    private func newsFieldView(viewStore: ViewStoreOf<OnboardingNewsFieldStore>) -> some View {
        LazyVGrid(columns: .init(repeating: .init(), count: 3)) {
            ForEach(NewsField.allCases, id: \.self) { newsField in
                D3NRadioButton(title: newsField.title, isSelected: viewStore.newsFields.contains(newsField)) {
                    viewStore.send(.selectNewsField(newsField))
                }
            }
        }
    }
}
