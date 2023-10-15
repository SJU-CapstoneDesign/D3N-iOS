//
//  MinimalBackground.swift
//  D3N
//
//  Created by 송영모 on 10/15/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

struct MinimalBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(Color(uiColor: .systemGray6))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
            )
    }
}

public extension View {
    func minimalBackgroundStyle() -> some View {
        modifier(MinimalBackground())
    }
}
