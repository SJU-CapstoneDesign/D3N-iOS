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
        var newsEntityList: [NewsEntity] = [] {
            didSet {
                self.newsListItems = makeNewsListItems(from: newsEntityList)
            }
        }
        
        var newsListItems: IdentifiedArrayOf<NewsListItemCellStore.State> = []
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case allNewsButtonTapped
        
        case fetchNewsListRequest
        case fetchNewsListResponse(Result<[NewsEntity], NewsError>)
        
        case newsListItems(id: NewsListItemCellStore.State.ID, action: NewsListItemCellStore.Action)
        
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
                return .concatenate([
                    .send(.fetchNewsListRequest)
                ])
                
            case .allNewsButtonTapped:
                return .send(.delegate(.allNewsButtonTapped))
                
            case .fetchNewsListRequest:
                return .run { send in
                    let response = await newsClient.fetchNewsList(TODAY_NEWS_PAGE_INDEX, TODAY_NEWS_PAGE_SIZE)
                    await send(.fetchNewsListResponse(response))
                }
                
            case let .fetchNewsListResponse(.success(newsEntityList)):
                state.newsEntityList = newsEntityList
                return .none
                
            case let .newsListItems(id: id, action: .delegate(.tapped)):
                if let newsEntity = state.newsListItems[id: id]?.newsEntity {
                    return .send(.delegate(.select(newsEntity)))
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

public extension TodayMainStore.State {
    func makeNewsListItems(from newsEntityList: [NewsEntity]) -> IdentifiedArrayOf<NewsListItemCellStore.State> {
        return .init(
            uniqueElements: newsEntityList.map { newsEntity in
                return .init(newsEntity: newsEntity)
            }
        )
    }
}
