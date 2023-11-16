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
    @FocusState var focus: OnboardingNicknameStore.State.Field?
    
    init(store: StoreOf<OnboardingNicknameStore>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                Text("닉네임을 입력해주세요.")
                    .font(.title)
                    .fontWeight(.bold)
                
                TextField("닉네임", text: viewStore.$nickname)
                    .focused(
                        self.$focus,
                        equals: .nickname
                    )
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            HStack {
                                Spacer()
                                
                                Button("완료") {
                                    viewStore.send(.confirmButtonTapped)
                                }
                            }
                        }
                    }
                    .onAppear {
                        viewStore.send(.onAppear)
                    }
                
                Spacer()
                
                D3NSubmitButton(
                    activeTitle: "다음으로",
                    inactiveTitle: "닉네임을 입력해주세요",
                    isActive: viewStore.state.isConfirmButtonActive,
                    action: { isActive in
                        if isActive {
                            viewStore.send(.confirmButtonTapped)
                        }
                    }
                )
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .padding(.vertical, 40)
            .bind(viewStore.$focus, to: self.$focus)
        }
    }
}
