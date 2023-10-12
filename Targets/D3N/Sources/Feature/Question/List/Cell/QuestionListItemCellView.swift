//
//  QuestionListItemCell.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct QuestionListItemCellView: View {
    let store: StoreOf<QuestionListItemCellStore>
    
    public init(store: StoreOf<QuestionListItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Text("1")
                
                VStack {
                    Image(systemName: "star")
                }
                
                VStack {
                    Text("Title")
                    
                    Text("Desc")
                }
                
                Spacer()
            }
            .onTapGesture {
                viewStore.send(.tapped)
            }
        }
    }
}
