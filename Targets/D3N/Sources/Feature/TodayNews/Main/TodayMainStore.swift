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
    let TODAY_NEWS_PAGE_SIZE = 3
    
    public struct State: Equatable {
        var todayNewses: [TodayNewsEntity] = [] {
            didSet {
                self.todayNewsListItems = makeTodayNewsListItems(from: todayNewses)
            }
        }
//        var newses: [NewsEntity] = [] {
//            didSet {
////                self.todayListItems = makeTodayListItems(from: newses)
//            }
//        }
        
//        var todayListItems: IdentifiedArrayOf<TodayListItemCellStore.State> = []
        var todayNewsListItems: IdentifiedArrayOf<TodayNewsListItemCellStore.State> = []
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case allNewsButtonTapped
        
        case fetchTodayNewsListRequest
        case fetchTodayNewsListResponse(Result<[TodayNewsEntity], D3NAPIError>)
        
//        case fetchNewsListRequest
//        case fetchNewsListResponse(Result<[NewsEntity], D3NAPIError>)
        
//        case todayListItems(id: TodayListItemCellStore.State.ID, action: TodayListItemCellStore.Action)
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
                
//            case .fetchNewsListRequest:
//                return .run { send in
//                    let response = await newsClient.fetch(TODAY_NEWS_PAGE_INDEX, TODAY_NEWS_PAGE_SIZE)
//                    await send(.fetchNewsListResponse(response))
//                }
//                
//            case let .fetchNewsListResponse(.success(newses)):
//                state.newses = newses
//                return .none
                
//            case let .todayListItems(id: id, action: .delegate(.tapped)):
//                if let newsEntity = state.todayListItems[id: id]?.newsEntity {
//                    return .send(.delegate(.select(newsEntity)))
//                }
//                return .none
                
            default:
                return .none
            }
        }
//        .forEach(\.todayListItems, action: /Action.todayListItems(id:action:)) {
//            TodayListItemCellStore()
//        }
        .forEach(\.todayNewsListItems, action: /Action.todayNewsListItems(id: action:)) {
            TodayNewsListItemCellStore()
        }
    }
}

public extension TodayMainStore.State {
    func makeTodayNewsListItems(from todayNewses: [TodayNewsEntity]) -> IdentifiedArrayOf<TodayNewsListItemCellStore.State> {
        return .init(
            uniqueElements: todayNewses.map { todayNews in
                .init(todayNews: todayNews)
            }
        )
    }
}
