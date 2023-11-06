//
//  OnboardingNavigationStackStore.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

/// isOnboardNeeded 가 false이거나 한번도 업데이트 되지 않았을때 실행되는 Flow 입니다.
/// 엑세스토큰과 리프레시 토큰을 체크하고 없다면 signUp Flow를 타고, 서드파티 로그인을 탑니다.
/// 로그인 이후 온보딩 필요여부를 체크하고 온보딩이 필요하다면, 온보딩을 진행하고 그렇지 않다면 메인 탭뷰로 이동합니다.
public struct OnboardingNavigationStackStore: Reducer {
    public struct State: Equatable {
        var signUp: OnboardingSignUpStore.State = .init()
        
        var path: StackState<Path.State> = .init()
        var nickname: String?
        var gender: Gender?
        var birthDate: Date?
        var newsFields: [NewsField]
        
        init(
            nickname: String? = nil,
            gender: Gender? = nil,
            birthDate: Date? = nil,
            newsFields: [NewsField] = []
        ) {
            self.nickname = nickname
            self.gender = gender
            self.birthDate = birthDate
            self.newsFields = newsFields
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case signUp(OnboardingSignUpStore.Action)
        case path(StackAction<Path.State, Path.Action>)
        
        case userOnboardNeededRequest
        case userOnboardNeededResponse(Result<Bool, D3NAPIError>)
        case userOnboardRequest
        case userOnboardResponse(Result<UserEntity, D3NAPIError>)
        
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
                case let .submit(nickname):
                    state.nickname = nickname
                    state.path.append(.gender(.init()))
                    return .none
                }
                
            case let .path(.element(id: _, action: .gender(.delegate(action)))):
                switch action {
                case let .submit(gender):
                    state.gender = gender
                    state.path.append(.birth(.init()))
                    return .none
                }
                
            case let .path(.element(id: _, action: .birth(.delegate(action)))):
                switch action {
                case let .submit(birthDate):
                    state.birthDate = birthDate
                    state.path.append(.newsField(.init()))
                    return .none
                }
                
            case let .path(.element(id: _, action: .newsField(.delegate(action)))):
                switch action {
                case let .submit(newsFields):
                    state.newsFields = newsFields
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
                
            case .userOnboardRequest:
                return .run { [
                    nickname = state.nickname,
                    gender = state.gender,
                    birthDay = state.birthDate,
                    newsFields = state.newsFields
                ] send in
                    guard 
                        let nickname = nickname,
                        let gender = gender,
                        let birthDay = birthDay
                    else { return }
                    let response = await userClient.onboard(nickname, gender, birthDay, newsFields)
                    await send(.userOnboardResponse(response))
                }
                
            case let .userOnboardResponse(.success(user)):
                return .send(.delegate(.complete))
                
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
