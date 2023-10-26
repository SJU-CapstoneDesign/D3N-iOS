//
//  OnboardingSignUpView.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct OnboardingSignUpView: View {
    let store: StoreOf<OnboardingSignUpStore>
    
    public init(store: StoreOf<OnboardingSignUpStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("")
            }
        }
    }
}
