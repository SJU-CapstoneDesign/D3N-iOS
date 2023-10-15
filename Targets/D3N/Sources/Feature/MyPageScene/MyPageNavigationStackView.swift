//
//  MyPageNavigationStackView.swift
//  D3N
//
//  Created by 송영모 on 10/15/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct MyPageNavigationStackView: View {
    let store: StoreOf<MyPageNavigationStackStore>
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            MyPageMainView(store: self.store.scope(state: \.main, action: MyPageNavigationStackStore.Action.main))
        }
    }
}
