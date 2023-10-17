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
    let TODAY_NEWS_PAGE_INDEX = 0
    let TODAY_NEWS_PAGE_SIZE = 10
    
    public struct State: Equatable {
        var newsList: [NewsEntity] = [] {
            didSet {
                self.todayItems = makeTodayItems(from: newsList)
            }
        }
        
        var todayItems: IdentifiedArrayOf<TodayItemCellStore.State> = []
        
        public init() { }
        
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case fetchNewsListRequest
        case fetchNewsListResponse(Result<[NewsEntity], NewsError>)
        
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
                    .send(.fetchNewsListRequest)
                ])
                
            case .fetchNewsListRequest:
                return .run { send in
                    let response = await newsClient.fetchNewsList(TODAY_NEWS_PAGE_INDEX, TODAY_NEWS_PAGE_SIZE)
                    await send(.fetchNewsListResponse(response))
                }
                
            case let .fetchNewsListResponse(.success(newsList)):
                state.newsList = newsList
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

public extension TodayMainStore.State {
    func makeTodayItems(from newsList: [NewsEntity]) -> IdentifiedArrayOf<TodayItemCellStore.State> {
        return .init(
            uniqueElements: newsList.map { news in
                return .init(news: news)
            }
        )
    }
}
