//
//  FiniensApp.swift
//  Finiens
//
//  Created by 송영모 on 2023/07/26.
//

import SwiftUI
import AppTrackingTransparency

import ComposableArchitecture

@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootStore.State()) {
                    RootStore()
                }
            )
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in
                })
            }
        }
    }
}
