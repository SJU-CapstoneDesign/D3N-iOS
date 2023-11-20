//
//  MyPageMainStore.swift
//  D3N
//
//  Created by 송영모 on 10/15/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct MyPageMainStore: Reducer {
    public struct State: Equatable {
        @PresentationState var alert: AlertState<Action.Alert>?
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case unlinkButtonTapped
        
        case appleUnlinkRequest
        case appleUnlinkResponse(Result<Bool, D3NAPIError>)
        
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        
        public enum Delegate {
            case unlinked
        }
        
        public enum Alert: Equatable {
            case confirmUnlink
            case cancle
        }
    }
    
    @Dependency(\.authClient) var authClient
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .unlinkButtonTapped:
                state.alert = AlertState {
                    TextState("회원탈퇴는 되돌릴 수 없습니다.")
                } actions: {
                    ButtonState(role: .cancel, action: .cancle) {
                        TextState("취소")
                    }
                    ButtonState(role: .destructive, action: .confirmUnlink) {
                        TextState("탈퇴하기")
                    }
                }
                return .none
                
            case .appleUnlinkRequest:
                return .run { send in
                    await send(.appleUnlinkResponse(await authClient.appleUnlink()))
                }
                
            case .appleUnlinkResponse(.success), .appleUnlinkResponse(.failure):
                return .send(.delegate(.unlinked))
                
            case let .alert(.presented(alert)):
                switch alert {
                case .confirmUnlink:
                    return .send(.appleUnlinkRequest)
                case .cancle:
                    state.alert = nil
                    return .none
                }
                
            default:
                return .none
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
}
