//
//  OnboardingSignUpStore.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct OnboardingSignUpStore: Reducer {
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case signIn(code: String, idToken: String)
        
        case appleLoginRequest(code: String, idToken: String)
        case appleLoginResponse(Result<AuthEntity, D3NAPIError>)

        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case signIn
        }
    }
    
    @Dependency(\.authClient) var authClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .signIn(code: code, idToken: idToken):
                return .send(.appleLoginRequest(code: code, idToken: idToken))
                
            case let .appleLoginRequest(code: code, idToken: idToken):
                return .run { send in
                    let response = await authClient.appleLogin(code, idToken)
                    await send(.appleLoginResponse(response))
                }
                
            case .appleLoginResponse(.success):
                return .send(.delegate(.signIn))
                
            default:
                return .none
            }
        }
    }
}
