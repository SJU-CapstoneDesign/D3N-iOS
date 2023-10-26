//
//  OnboardingNicknameView.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct OnboardingNicknameView: View {
    let store: StoreOf<OnboardingNicknameStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("닉네임을 입력해주세요.")
                    .font(.largeTitle)
            }
        }
    }
}
