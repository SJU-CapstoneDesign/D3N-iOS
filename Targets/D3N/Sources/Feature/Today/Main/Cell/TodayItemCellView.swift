//
//  TodayItemCellView.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TodayItemCellView: View {
    let store: StoreOf<TodayItemCellStore>
    
    public init(store: StoreOf<TodayItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.mint)
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text("테스트 제목")
                        .font(.headline)
                    
                    Text("설명")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Button("풀기", action: {})
                    .buttonStyle(.bordered)
            }
        }
    }
}
