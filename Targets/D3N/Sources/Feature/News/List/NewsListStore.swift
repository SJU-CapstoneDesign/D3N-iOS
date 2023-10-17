//
//  NewsListStore.swift
//  D3N
//
//  Created by 송영모 on 10/17/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct NewsListStore: Reducer {
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
        case fetchNewsListResponse(Result<[NewsEntity], NewsError>)
        
        case tapped
        
        case newsListItems(id: NewsListItemCellStore.State.ID, action: NewsListItemCellStore.Action)
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case tapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.fetchNewsListRequest)
                ])
                
            case .tapped:
                return .send(.delegate(.tapped))
                
            case .fetchNewsListRequest:
                return .run { [pageIndex = state.pageIndex] send in
                    let response = await newsClient.fetchNewsList(pageIndex, FIXED_PAGE_SIZE)
                    await send(.fetchNewsListResponse(response))
                }
                
            case let .fetchNewsListResponse(.success(newsEntityList)):
                let newsListItems = state.makeNewsListItems(from: newsEntityList)
                state.newsListItems.append(contentsOf: newsListItems)
                return .none
                
            case let .newsListItems(id: id, action: .delegate(action)):
                switch action {
                case .onAppear:
                    if id == state.newsListItems.ids.last {
                        return .send(.fetchNewsListRequest)
                    }
                case .tapped: break
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

public extension NewsListStore.State {
    func makeNewsListItems(from newsEntityList: [NewsEntity]) -> IdentifiedArrayOf<NewsListItemCellStore.State> {
        return .init(
            uniqueElements: newsEntityList.map { newsEntity in
                return .init(newsEntity: newsEntity)
            }
        )
    }
}
