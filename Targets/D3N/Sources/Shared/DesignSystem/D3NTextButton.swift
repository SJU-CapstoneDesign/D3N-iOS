//
//  D3NTextButton.swift
//  D3N
//
//  Created by 송영모 on 11/20/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

public struct D3NTextButton: View {
    public let activeTitle: LocalizedStringKey
    public let inactiveTitle: LocalizedStringKey
    public let isActive: Bool
    
    public var action: () -> ()
    
    init(
        activeTitle: LocalizedStringKey = "",
        inactiveTitle: LocalizedStringKey = "",
        isActive: Bool = false,
        action: @escaping () -> Void
    ) {
        self.activeTitle = activeTitle
        self.inactiveTitle = inactiveTitle
        self.isActive = isActive
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Text(self.isActive ? self.activeTitle : self.inactiveTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(isActive ? .white : .black)
            }
        })
        .padding(10)
        .background(isActive ? Color.blue : Color.systemGray5)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
    }
}
