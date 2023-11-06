//
//  OnboardingNavigationStackStore.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import ComposableArchitecture

/// isOnboardNeeded 가 false이거나 한번도 업데이트 되지 않았을때 실행되는 Flow 입니다.
/// 엑세스토큰과 리프레시 토큰을 체크하고 없다면 signUp Flow를 타고, 서드파티 로그인을 탑니다.
/// 로그인 이후 온보딩 필요여부를 체크하고 온보딩이 필요하다면, 온보딩을 진행하고 그렇지 않다면 메인 탭뷰로 이동합니다.
public struct OnboardingNavigationStackStore: Reducer {
    public struct State: Equatable {
        var signUp: OnboardingSignUpStore.State = .init()
        
        var path: StackState<Path.State> = .init()
        
        init() {
            path.append(.newsField(.init()))
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case signUp(OnboardingSignUpStore.Action)
        case path(StackAction<Path.State, Path.Action>)
        
        case userOnboardNeededRequest
        case userOnboardNeededResponse(Result<Bool, D3NAPIError>)
        
        case delegate(Delegate)
        
        public enum Delegate {
            case complete
        }
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case nickname(OnboardingNicknameStore.State)
            case gender(OnboardingGenderStore.State)
            case birth(OnboardingBirthStore.State)
            case newsField(OnboardingNewsFieldStore.State)
        }
        
        public enum Action: Equatable {
            case nickname(OnboardingNicknameStore.Action)
            case gender(OnboardingGenderStore.Action)
            case birth(OnboardingBirthStore.Action)
            case newsField(OnboardingNewsFieldStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.nickname, action: /Action.nickname) {
                OnboardingNicknameStore()
            }
            Scope(state: /State.gender, action: /Action.gender) {
                OnboardingGenderStore()
            }
            Scope(state: /State.birth, action: /Action.birth) {
                OnboardingBirthStore()
            }
            Scope(state: /State.newsField, action: /Action.newsField) {
                OnboardingNewsFieldStore()
            }
        }
    }
    
    @Dependency(\.userClient) var userClient
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .signUp(.delegate(action)):
                switch action {
                case .signIn:
                    return .send(.userOnboardNeededRequest)
                }
                
            case let .path(.element(id: _, action: .nickname(.delegate(action)))):
                switch action {
                case .confirm:
                    state.path.append(.gender(.init()))
                    return .none
                }
                
            case .userOnboardNeededRequest:
                return .run { send in
                    await send(.userOnboardNeededResponse(await userClient.onboardNeeded()))
                }
                
            case let .userOnboardNeededResponse(.success(isNeededOnboard)):
                if isNeededOnboard {
                    state.path.append(.nickname(.init()))
                } else {
                    return .send(.delegate(.complete))
                }
                return .none
                
            default:
                return .none
            }
        }
        Scope(state: \.signUp, action: /Action.signUp) {
            OnboardingSignUpStore()
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
