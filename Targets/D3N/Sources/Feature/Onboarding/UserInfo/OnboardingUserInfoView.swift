//
//  OnboardingUserInfoView.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct OnboardingUserInfoView: View {
    let store: StoreOf<OnboardingUserInfoStore>
    
    init(store: StoreOf<OnboardingUserInfoStore>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                Text("닉네임을 입력해주세요.")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .padding()
            .padding(.vertical, 40)
        }
    }
}
