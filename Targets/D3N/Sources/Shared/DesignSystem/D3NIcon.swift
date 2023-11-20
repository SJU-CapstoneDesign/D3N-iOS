//
//  D3NIcon.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

public struct D3NIcon: View {
    public let systemImageName: String
    public let color: Color
    
    public var body: some View {
        ZStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundStyle(color.opacity(0.1))
            
            Image(systemName: systemImageName)
                .foregroundStyle(color)
        }
    }
}

public extension D3NIcon {
    static func resolved(index: Int) -> D3NIcon {
        self.resolved(number: index + 1)
    }
    
    static func resolved(number: Int) -> D3NIcon {
        switch number {
        case 1: return .one
        case 2: return .two
        case 3: return .three
        case 4: return .four
        default: return .one
        }
    }
    
    static let one: D3NIcon = .init(systemImageName: "1.circle.fill", color: .black)
    static let two: D3NIcon = .init(systemImageName: "2.circle.fill", color: .black)
    static let three: D3NIcon = .init(systemImageName: "3.circle.fill", color: .black)
    static let four: D3NIcon = .init(systemImageName: "4.circle.fill", color: .black)
}
