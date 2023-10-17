//
//  Color+Extension.swift
//  D3N
//
//  Created by 송영모 on 10/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

public extension Color {
    static var foreground: Self {
        return Color(uiColor: .label)
    }
    
    static var background: Self {
        return Color(uiColor: .systemBackground)
    }
    
    static var systemGray5: Self {
        return Color(uiColor: .systemGray5)
    }
    
    static var systemGray6: Self {
        return Color(uiColor: .systemGray6)
    }
}
