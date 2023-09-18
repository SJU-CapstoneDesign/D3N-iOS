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
                HStack {
                    Button(action: {}, label: {
                        Label("뉴스", systemImage: "chevron.down")
                            .font(.title3)
                            .fontWeight(.semibold)
                    })
                    Spacer()
                }
                .padding(.horizontal)
                
                TabView {
                    ForEach(0...10, id: \.self) { i in
                        PassageCardView()
                            .frame(width: proxy.size.width * 0.9, height: proxy.size.height * 0.8)
                            .onTapGesture {
                                viewModel.send(.passageItemTapped(i))
                            }
                    }
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
