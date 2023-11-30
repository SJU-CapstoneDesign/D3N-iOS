////
////  TodayListItemCellStore.swift
////  D3N
////
////  Created by 송영모 on 11/6/23.
////  Copyright © 2023 sju. All rights reserved.
////
//
//import Foundation
//
//import ComposableArchitecture
//
//public struct TodayListItemCellStore: Reducer {
//    public struct State: Equatable, Identifiable {
//        public var id: UUID
//        public var newsEntity: NewsEntity
//        
//        public init(
//            id: UUID = .init(),
//            newsEntity: NewsEntity
//        ) {
//            self.id = id
//            self.newsEntity = newsEntity
//        }
//    }
//    
//    public enum Action: Equatable {
//        case onAppear
//        
//        case tapped
//        
//        case delegate(Delegate)
//        
//        public enum Delegate: Equatable {
//            case onAppear
//            case tapped
//        }
//    }
//    
//    public var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .onAppear:
//                return .send(.delegate(.onAppear))
//                
//            case .tapped:
//                return .send(.delegate(.tapped))
//                
//            default:
//                return .none
//            }
//        }
//    }
//}
