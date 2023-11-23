//
//  SolvedNewsStore.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/23/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct SolvedNewsStore: Reducer {
    let FIXED_PAGE_SIZE = 10
    
    public struct State: Equatable, Identifiable {
        public let id: UUID
        
        var newsEntityList: [NewsEntity] = []
        var pageIndex: Int = 0
        
        var newsListItems: IdentifiedArrayOf<NewsListItemCellStore.State> = []
        
        public init(
            id: UUID = .init()
        ) {
            self.id = id
        }
    }
    
    @Dependency(\.newsClient) var newsClient
    
    public enum Action: Equatable {
        case onAppear
        
        case fetchNewsListRequest
        case fetchNewsListResponse(Result<[NewsEntity], D3NAPIError>)
        
        case newsListItems(id: NewsListItemCellStore.State.ID, action: NewsListItemCellStore.Action)
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case select(NewsEntity)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.fetchNewsListRequest)
                ])
                
            case .fetchNewsListRequest:
                return .run { [pageIndex = state.pageIndex] send in
                    let response = await newsClient.fetchNewsList(pageIndex, FIXED_PAGE_SIZE)
                    await send(.fetchNewsListResponse(response))
                }
                
            case let .fetchNewsListResponse(.success(newsEntityList)):
                let newsListItems = state.makeSolvedNewsListItems(from: newsEntityList)
                state.newsListItems.append(contentsOf: newsListItems)
                state.pageIndex += 1
                return .none
                
            case let .newsListItems(id: id, action: .delegate(action)):
                switch action {
                case .onAppear:
                    if id == state.newsListItems.ids.last {
                        return .send(.fetchNewsListRequest)
                    }
                case .tapped:
                    if let newsEntity = state.newsListItems[id: id]?.newsEntity {
                        return .send(.delegate(.select(newsEntity)))
                    }
                }
                return .none
                
            default:
                return .none
            }
        }
        .forEach(\.newsListItems, action: /Action.newsListItems(id:action:)) {
            NewsListItemCellStore()
        }
    }
}

public extension SolvedNewsStore.State {
    func makeSolvedNewsListItems(from newsEntityList: [NewsEntity]) -> IdentifiedArrayOf<NewsListItemCellStore.State> {
        return .init(
            uniqueElements: newsEntityList.map { newsEntity in
                return .init(newsEntity: newsEntity)
            }
        )
    }
}

