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
                personalSection(viewStore: viewStore)
                
                feedbackSection()
                
                unlinkSection(viewStore: viewStore)
            }
            .alert(
                store: self.store.scope(
                    state: \.$alert,
                    action: { .alert($0) }
                )
            )
        }
    }
    
    private func personalSection(viewStore: ViewStoreOf<MyPageMainStore>) -> some View {
        Section {
            Button("내가 푼 뉴스 보기", action: {
                viewStore.send(.solvedNewsButtonTapped)
            })
            .foregroundStyle(.blue)
        }
    }
    
    private func feedbackSection() -> some View {
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
    
    private func unlinkSection(viewStore: ViewStoreOf<MyPageMainStore>) -> some View {
        Section {
            Button("회원탈퇴", action: {
                viewStore.send(.unlinkButtonTapped)
            })
            .foregroundStyle(.red)
        }
    }
}
