//
//  AppDIContainer.swift
//  MullingIOS
//
//  Created by 송영모 on 2023/08/21.
//  Copyright © 2023 folio.world. All rights reserved.
//

import Foundation

public final class AppDIContainer: AppDIContainerInterface {
    public func makeTodaySceneDIContainer() -> TodaySceneDIContainer {
        return TodaySceneDIContainer()
    }
}
