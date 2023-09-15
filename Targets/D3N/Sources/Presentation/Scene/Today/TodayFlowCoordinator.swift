//
//  TodayFlowCoordinator.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

public protocol TodayFlowCoordinatorDependencies {
    func makeTodayHomeViewModel(dependencies: )
    func makeChatViewModel(dependencies: ChatViewModel.Dependencies) -> ChatViewModel
    func makeChatResultViewModel(dependencies: ChatResultViewModel.Dependencies) -> ChatResultViewModel
}

public final class TodayFlowCoordinator: ObservableObject {
    public let dependencies: TodayFlowCoordinatorDependencies
    
    init(dependencies: TodayFlowCoordinatorDependencies) {
        self.dependencies = dependencies
    }
    
    public enum Scene: Hashable {
        case home
    }
    
    @Published public var path = NavigationPath()
    
    public func navigate(_ scene: Scene) {
        path.append(scene)
    }
    
    public func pop() {
        path.removeLast()
    }
}
