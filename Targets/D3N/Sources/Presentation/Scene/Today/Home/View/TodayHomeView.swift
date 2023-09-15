//
//  TodayHomeView.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

public struct TodayHomeView: View {
    @EnvironmentObject private var flowCoordinator: TodayFlowCoordinator
    @StateObject public var viewModel: TodayHomeViewModel
    
    public init(viewModel: TodayHomeViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Text("Home")
    }
}

#Preview {
    TodayHomeView(viewModel: AppDIContainer().makeTodaySceneDIContainer().makeTodayHomeViewModel(dependencies: .init()))
}
