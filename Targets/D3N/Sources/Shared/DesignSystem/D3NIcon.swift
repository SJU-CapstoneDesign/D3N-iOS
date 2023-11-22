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
    public let inactiveColor: Color
    public let activeColor: Color
    public let isActive: Bool
    
    init(
        systemImageName: String,
        inactiveColor: Color = .gray,
        activeColor: Color = .blue,
        isActive: Bool = false
    ) {
        self.systemImageName = systemImageName
        self.inactiveColor = inactiveColor
        self.activeColor = activeColor
        self.isActive = isActive
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundStyle(isActive ? activeColor.opacity(0.1) : inactiveColor.opacity(0.1))
            
            Image(systemName: systemImageName)
                .foregroundStyle(isActive ? activeColor : inactiveColor)
        }
    }
}

public extension D3NIcon {
    static func resolved(index: Int, isActive: Bool) -> D3NIcon {
        self.resolved(number: index + 1, isActive: isActive)
    }
    
    static func resolved(number: Int, isActive: Bool) -> D3NIcon {
        switch number {
        case 1: return .one(isActive: isActive)
        case 2: return .two(isActive: isActive)
        case 3: return .three(isActive: isActive)
        case 4: return .four(isActive: isActive)
        default: return .one(isActive: isActive)
        }
    }
    
    static func one(isActive: Bool) -> D3NIcon {
        return .init(systemImageName: "1.circle.fill", isActive: isActive)
    }
    
    static func two(isActive: Bool) -> D3NIcon {
        return .init(systemImageName: "2.circle.fill", isActive: isActive)
    }
    
    static func three(isActive: Bool) -> D3NIcon {
        return .init(systemImageName: "3.circle.fill", isActive: isActive)
    }
    
    static func four(isActive: Bool) -> D3NIcon {
        return .init(systemImageName: "4.circle.fill", isActive: isActive)
    }
}
