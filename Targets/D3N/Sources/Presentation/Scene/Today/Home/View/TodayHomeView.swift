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
        GeometryReader { proxy in
            VStack {
                TabView {
                    ForEach(0...10, id: \.self) { i in
                        PassageCardView()
                            .background(Color(
                                red: .random(in: 0...1),
                                green: .random(in: 0...1),
                                blue: .random(in: 0...1)
                            ))
                            .frame(width: proxy.size.width, height: proxy.size.height * 0.9)
                    }
                }
                
                Button("Home") {
                    viewModel.send(.nextButtonTapped)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onReceive(viewModel.$questionPassageDependencies) { dependenciesOrNil in
            if let dependencies = dependenciesOrNil {
                flowCoordinator.navigate(.questionPassage(dependencies))
            }
        }
    }
}

#Preview {
    TodayHomeView(viewModel: AppDIContainer().makeTodaySceneDIContainer().makeTodayHomeViewModel(dependencies: .init()))
}
