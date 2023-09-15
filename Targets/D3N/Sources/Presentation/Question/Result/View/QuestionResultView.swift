//
//  QuestionResultView.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

public struct QuestionResultView: View {
    @StateObject private var viewModel: QuestionResultViewModel
    
    public init(viewModel: QuestionResultViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Text("Question Result")
    }
}
