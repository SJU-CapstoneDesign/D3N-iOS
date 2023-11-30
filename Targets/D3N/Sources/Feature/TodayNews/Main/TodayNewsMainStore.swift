//
//  TodayMainStore.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct TodayNewsMainStore: Reducer {
    public struct State: Equatable {
        var todayNewses: [TodayNewsEntity] = [] {
            didSet {
                self.todayNewsListItems = makeTodayNewsListItems(from: todayNewses)
            }
        }
        
        var todayNewsListItems: IdentifiedArrayOf<TodayNewsListItemCellStore.State> = []
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case allNewsButtonTapped
        
        case fetchTodayNewsListRequest
        case fetchTodayNewsListResponse(Result<[TodayNewsEntity], D3NAPIError>)
        
        case todayNewsListItems(id: TodayNewsListItemCellStore.State.ID, action: TodayNewsListItemCellStore.Action)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case select(NewsEntity)
            case allNewsButtonTapped
        }
    }
    
    @Dependency(\.newsClient) var newsClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.fetchTodayNewsListRequest)
                
            case .allNewsButtonTapped:
                return .send(.delegate(.allNewsButtonTapped))
                
            case .fetchTodayNewsListRequest:
                return .run { send in
                    let response = await newsClient.fetchToday()
                    await send(.fetchTodayNewsListResponse(response))
                }
                
            case let .fetchTodayNewsListResponse(.success(todayNewses)):
                state.todayNewses = todayNewses
                return .none
                
            case let .todayNewsListItems(id: _, action: .delegate(action)):
                switch action {
                case let .select(news):
                    return .send(.delegate(.select(news)))
                }
                
            default:
                return .none
            }
        }
        .forEach(\.todayNewsListItems, action: /Action.todayNewsListItems(id: action:)) {
            TodayNewsListItemCellStore()
        }
    }
}

public extension TodayNewsMainStore.State {
    func makeTodayNewsListItems(from todayNewses: [TodayNewsEntity]) -> IdentifiedArrayOf<TodayNewsListItemCellStore.State> {
        return .init(
            uniqueElements: todayNewses.map { todayNews in
                .init(todayNews: todayNews)
            }
        )
    }
}
