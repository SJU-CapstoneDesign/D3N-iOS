//
//  TodayMainView.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TodayMainView: View {
    let store: StoreOf<TodayMainStore>
    @State private var isPressing = false
    
    public func toggleIsPressing() {
        withAnimation(.easeOut(duration: 0.3)){
            isPressing.toggle()
        }
    }
    
    public init(store: StoreOf<TodayMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack {
                    todayNewsView(viewStore: viewStore)
                        .padding()
                    
                    LazyVGrid(columns: .init(repeating: .init(), count: 5)) {
                        ForEach(NewsField.allCases, id: \.self) { newsField in
                            newsField.icon
                        }
                    }
                }
            }
            .task {
                viewStore.send(.onAppear, animation: .default)
            }
            .navigationTitle("Today")
        }
    }
    
    private func todayNewsView(viewStore: ViewStoreOf<TodayMainStore>) -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                Text("최신 뉴스를 가져왔어요")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
                
                HStack {
                    Text("오늘의 뉴스 3 문제")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button("전체보기", action: {
                        viewStore.send(.allNewsButtonTapped)
                    }
                    )
                }
            }
            .onTapGesture {
                viewStore.send(.allNewsButtonTapped)
                isPressing = false
            }
            ForEachStore(self.store.scope(state: \.todayListItems, action: TodayMainStore.Action.todayListItems(id:action:))) {
                TodayListItemCellView(store: $0)
            }
        }
        .padding()
        .background(Color.background)
        .cornerRadius(20)
        .clipped()
        .shadow(color: .systemGray5, radius: 20)
    }
}

struct ScrollViewGestureButtonStyle: ButtonStyle {
    
    init(
        pressAction: @escaping () -> Void,
        doubleTapTimeoutout: TimeInterval,
        doubleTapAction: @escaping () -> Void,
        longPressTime: TimeInterval,
        longPressAction: @escaping () -> Void,
        endAction: @escaping () -> Void
    ) {
        self.pressAction = pressAction
        self.doubleTapTimeoutout = doubleTapTimeoutout
        self.doubleTapAction = doubleTapAction
        self.longPressTime = longPressTime
        self.longPressAction = longPressAction
        self.endAction = endAction
    }
    
    private var doubleTapTimeoutout: TimeInterval
    private var longPressTime: TimeInterval
    
    private var pressAction: () -> Void
    private var longPressAction: () -> Void
    private var doubleTapAction: () -> Void
    private var endAction: () -> Void
    
    @State
    var doubleTapDate = Date()
    
    @State
    var longPressDate = Date()
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { isPressed in
                longPressDate = Date()
                if isPressed {
                    pressAction()
                    doubleTapDate = tryTriggerDoubleTap() ? .distantPast : .now
                    tryTriggerLongPressAfterDelay(triggered: longPressDate)
                } else {
                    endAction()
                }
            }
    }
}

private extension ScrollViewGestureButtonStyle {
    
    func tryTriggerDoubleTap() -> Bool {
        let interval = Date().timeIntervalSince(doubleTapDate)
        guard interval < doubleTapTimeoutout else { return false }
        doubleTapAction()
        return true
    }
    
    func tryTriggerLongPressAfterDelay(triggered date: Date) {
        DispatchQueue.main.asyncAfter(deadline: .now() + longPressTime) {
            guard date == longPressDate else { return }
            longPressAction()
        }
    }
}
