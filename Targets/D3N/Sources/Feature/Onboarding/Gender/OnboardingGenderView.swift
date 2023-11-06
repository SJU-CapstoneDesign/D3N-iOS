//
//  OnboardingGenderView.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

struct OnboardingGenderView: View {
    let store: StoreOf<OnboardingGenderStore>
    
    init(store: StoreOf<OnboardingGenderStore>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 40) {
                Text("성별을 선택해주세요.")
                    .font(.title)
                    .fontWeight(.bold)
                
                genderRadioButtonView(viewStore: viewStore)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
        
    }
    
    private func genderRadioButtonView(viewStore: ViewStoreOf<OnboardingGenderStore>) -> some View {
        HStack {
            ForEach(Gender.allCases, id: \.self) { gender in
                D3NRadioButton(title: gender.title, isSelected: gender == viewStore.state.gender) {
                    viewStore.send(.genderButtonTapped(gender))
                }
            }
        }
    }
}
