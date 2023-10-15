//
//  ChoiceListItemCellView.swift
//  D3N
//
//  Created by 송영모 on 10/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct ChoiceListItemCellView: View {
    let store: StoreOf<ChoiceListItemCellStore>
    
    public init(store: StoreOf<ChoiceListItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Button(action: {
                    viewStore.send(.tapped)
                }, label: {
                    Label(
                        LocalizedStringKey(viewStore.state.choice),
                        systemImage: viewStore.state.isSelected ? "circle.fill" : "circle"
                    )
                })
                .font(.subheadline)
                .foregroundStyle(.black)
                
                Spacer()
            }
        }
    }
}
