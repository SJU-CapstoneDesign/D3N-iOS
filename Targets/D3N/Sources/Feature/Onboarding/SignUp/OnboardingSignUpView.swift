//
//  OnboardingSignUpView.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI
import AuthenticationServices

import ComposableArchitecture

public struct OnboardingSignUpView: View {
    let store: StoreOf<OnboardingSignUpStore>
    
    
    public init(store: StoreOf<OnboardingSignUpStore>) {
        self.store = store
    }
    
    @State private var rotateIn3D = false
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(22)
                    .foregroundColor(.white)
                    .shadow(color: Color(uiColor: .systemGray5), radius: 20)
                    .rotation3DEffect(
                        .degrees(rotateIn3D ? 12 : -12),
                        axis: (x: rotateIn3D ? 90 : -45, y: rotateIn3D ? -45 : -90, z: 0)
                    )
                    .task {
                        withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                            rotateIn3D.toggle()
                        }
                    }
                
                Spacer()
                
                Text("매일 3개의 뉴스를 읽고 독해력을 기르세요.")
                    .font(.caption2)
                
                SignInWithAppleButton(onRequest: {_ in }, onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        switch authResults.credential{
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            let idToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) ?? ""
                            let code = String(data: appleIDCredential.authorizationCode!, encoding: .utf8) ?? ""
                            
                            viewStore.send(.signIn(code: code, idToken: idToken))
                        default:
                            break
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
                .frame(height: 50, alignment: .center)
                .padding()
            }
        }
    }
}
