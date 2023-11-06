//
//  D3NSubmitButton.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import SwiftUI

public struct D3NSubmitButton: View {
    public let activeTitle: LocalizedStringKey
    public let inactiveTitle: LocalizedStringKey
    public let isActive: Bool
    
    public var action: (Bool) -> ()
    
    init(
        activeTitle: LocalizedStringKey = "",
        inactiveTitle: LocalizedStringKey = "",
        isActive: Bool = false,
        action: @escaping (Bool) -> Void
    ) {
        self.activeTitle = activeTitle
        self.inactiveTitle = inactiveTitle
        self.isActive = isActive
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action(self.isActive)
        }, label: {
            HStack {
                Spacer()
                Text(self.isActive ? self.activeTitle : self.inactiveTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(isActive ? .white : .black)
                Spacer()
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
