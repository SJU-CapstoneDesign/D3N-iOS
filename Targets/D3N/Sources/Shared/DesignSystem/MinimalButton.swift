//
//  MinimalButton.swift
//  D3N
//
//  Created by 송영모 on 10/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

public struct MinimalButton: View {
    public let title: String
    public let isActive: Bool
    
    public var action: () -> ()
    
    public init(
        title: String = "",
        isActive: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isActive = isActive
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Spacer()
                
                Text(self.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.background)
                
                Spacer()
            }
            .padding(.vertical, 10)
        })
        .background(isActive ? Color.foreground : Color.gray)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
    }
}
