//
//  D3NProgressBar.swift
//  D3N
//
//  Created by 송영모 on 11/20/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

public struct D3NProgressBar: View {
    let progress: [Bool]
    let currentIndex: Int
    
    init(
        progress: [Bool] = [],
        currentIndex: Int = 0
    ) {
        self.progress = progress
        self.currentIndex = 0
    }
    
    public var body: some View {
        HStack {
            ForEach(Array(self.progress.enumerated()), id: \.offset) { index, isSolved in
                item(index: index)
            }
        }
    }
    
    private func item(index: Int) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(index == currentIndex ? Color.black : Color.gray)
            .frame(height: 8)
    }
}
