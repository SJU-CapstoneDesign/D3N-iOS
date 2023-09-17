//
//  RootApp.swift
//  MullingIOS
//
//  Created by 송영모 on 2023/08/21.
//  Copyright © 2023 folio.world. All rights reserved.
//

import SwiftUI
import AppTrackingTransparency

@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    
    private let appDIContainer: AppDIContainerInterface = AppDIContainer()
    
    init() { }
    
    var body: some Scene {
        WindowGroup {
            TodayScene(sceneDIContainer: appDIContainer.makeTodaySceneDIContainer())
        }
    }
}
