//
//  OnboardingBirthView.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

struct OnboardingBirthView: View {
    let store: StoreOf<OnboardingBirthStore>
    
    init(store: StoreOf<OnboardingBirthStore>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                HStack {
                    Text("생일을 선택해주세요.")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
                DatePicker("", selection: viewStore.binding(get: { $0.birthDate ?? .now }, send: OnboardingBirthStore.Action.setBirthDate), displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                
                Spacer()
                
                D3NSubmitButton(activeTitle: "선택 완료", inactiveTitle: "생일을 선택해주세요", isActive: viewStore.birthDate != nil) { _ in
                    viewStore.send(.comfirmButtonTapped)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
        
    }
}
