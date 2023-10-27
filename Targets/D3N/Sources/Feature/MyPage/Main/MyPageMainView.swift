//
//  MyPageMain.swift
//  D3N
//
//  Created by 송영모 on 10/15/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct MyPageMainView: View {
    let store: StoreOf<MyPageMainStore>
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                Section {
                    if let url = URL(string: "https://tally.so/r/n9Z6rQ") {
                        Link(destination: url, label: {
                            Label(
                                title: {
                                    Text("매삼뉴 피드백 창구")
                                }, icon: {
                                    Image(systemName: "doc.text.image.fill")
                                        .foregroundStyle(.blue)
                                }
                            )
                        })
                    }
                }
            }
        }
    }
}
