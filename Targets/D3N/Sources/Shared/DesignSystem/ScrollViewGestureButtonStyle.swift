//
//  ScrollViewGestureButtonStyle.swift
//  D3N
//
//  Created by 송영모 on 11/10/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

/// 스크롤뷰 내부에서 버튼 이벤트를 수신하며 스크롤 뷰에 버튼 트리거를 답니다.
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
