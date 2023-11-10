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
