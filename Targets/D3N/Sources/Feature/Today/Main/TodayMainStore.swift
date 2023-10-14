//
//  TodayMainStore.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct TodayMainStore: Reducer {
    public struct State: Equatable {
        var todayItems: IdentifiedArrayOf<TodayItemCellStore.State> = []
        
        public init() { }
        
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case fetchTodayNewsListRequest
        case fetchTodayNewsListResponse(TaskResult<[NewsEntity]>)
        
        case todayItems(id: TodayItemCellStore.State.ID, action: TodayItemCellStore.Action)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case select(NewsEntity)
        }
    }
    
    @Dependency(\.newsClient) var newsClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.fetchTodayNewsListRequest)
                ])
                
            case .fetchTodayNewsListRequest:
                return .run { send in
                    await send(.fetchTodayNewsListResponse(TaskResult { try await newsClient.fetchTodayNewsList() }))
                }
                
            case let .fetchTodayNewsListResponse(.success(entities)):
                state.todayItems = .init(
                    uniqueElements: entities.map { entity in
                        return .init(news: entity)
                    }
                )
                return .none
                
            case let .todayItems(id: id, action: .delegate(.tapped)):
                if let news = state.todayItems[id: id]?.news {
                    return .send(.delegate(.select(news)))
                }
                return .none
                
            default:
                return .none
            }
        }
        .forEach(\.todayItems, action: /Action.todayItems(id:action:)) {
            TodayItemCellStore()
        }
    }
}

