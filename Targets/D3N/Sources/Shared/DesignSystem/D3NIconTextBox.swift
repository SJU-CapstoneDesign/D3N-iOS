//
//  D3NIconTextBox.swift
//  D3N
//
//  Created by 송영모 on 11/30/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

public struct D3NIconTextBox: View {
    let icon: D3NIcon?
    let key: LocalizedStringKey
    
    init(
        icon: D3NIcon? = nil,
        key: LocalizedStringKey
    ) {
        self.icon = icon
        self.key = key
    }
    
    public var body: some View {
        HStack {
            icon
            
            Text(key)
                .fontWeight(.semibold)
        }
        .padding(10)
        .background(.ultraThickMaterial)
        .cornerRadius(20)
        .clipped()
    }
}

public extension D3NIconTextBox {
    static func resolved(number: Int) -> D3NIconTextBox {
        switch number {
        case 1: return .one
        case 2: return .two
        case 3: return .three
        default: return .one
        }
    }
    
    static let one = D3NIconTextBox(icon: .one(color: .yellow, isActive: false), key: "LEVEL 1")
    static let two = D3NIconTextBox(icon: .two(color: .green, isActive: false), key: "LEVEL 2")
    static let three = D3NIconTextBox(icon: .three(color: .pink, isActive: false), key: "LEVEL 3")
}
