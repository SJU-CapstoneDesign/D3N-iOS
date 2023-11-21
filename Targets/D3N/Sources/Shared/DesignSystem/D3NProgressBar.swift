//
//  D3NProgressBar.swift
//  D3N
//
//  Created by 송영모 on 11/20/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

public struct ProgressItem {
    let secondTime: Int?
}

public struct D3NProgressBar: View {
    let items: [ProgressItem]
    let currentIndex: Int
    
    init(
        items: [ProgressItem] = [],
        currentIndex: Int = 0
    ) {
        self.items = items
        self.currentIndex = currentIndex
    }
    
    public var body: some View {
        HStack {
            ForEach(Array(self.items.enumerated()), id: \.offset) { index, item in
                progressItemView(index: index, item: item)
            }
        }
    }
    
    private func progressItemView(index: Int, item: ProgressItem) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(index == currentIndex ? Color.black : Color.gray)
                .frame(height: 8)
            
            if let secondTime = item.secondTime {
                Text("\(secondTime)")
                    .font(.caption2)
                    .foregroundStyle(index == currentIndex ? Color.black : Color.gray)
            }
        }
    }
}
