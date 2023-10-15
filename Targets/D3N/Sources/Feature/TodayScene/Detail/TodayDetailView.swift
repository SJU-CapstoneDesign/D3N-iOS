//
//  TodayDetailView.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TodayDetailView: View {
    let store: StoreOf<TodayDetailStore>
    
    public init(store: StoreOf<TodayDetailStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("Today Detail")
        }
    }
}
