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
    func makeTodayHomeViewModel(dependencies: TodayHomeViewModel.Dependencies) -> TodayHomeViewModel
    func makeQuestionPassageViewModel(dependencies: QuestionPassageViewModel.Dependencies) -> QuestionPassageViewModel
    func makeQuestionResultViewModel(dependencies: QuestionResultViewModel.Dependencies) -> QuestionResultViewModel
}

public final class TodayFlowCoordinator: ObservableObject {
    public let dependencies: TodayFlowCoordinatorDependencies
    
    public init(dependencies: TodayFlowCoordinatorDependencies) {
        self.dependencies = dependencies
    }
    
    public enum Scene: Hashable {
        case questionPassage(QuestionPassageViewModel.Dependencies)
        case questionResult(QuestionResultViewModel.Dependencies)
    }
    
    @Published public var path = NavigationPath()
    
    public func navigate(_ scene: Scene) {
        path.append(scene)
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public func popToRoot() {
        path = .init()
    }
}
