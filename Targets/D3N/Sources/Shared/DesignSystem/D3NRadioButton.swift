//
//  MinimalGroupButton.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import SwiftUI

public struct D3NRadioButton: View {
    public let title: LocalizedStringKey
    public let isSelected: Bool
    
    public var action: () -> ()
    
    init(
        title: LocalizedStringKey = "",
        isSelected: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Spacer()
                Text(self.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(isSelected ? .white : .black)
                Spacer()
            }
        })
        .padding(10)
        .background(isSelected ? Color.blue : Color.systemGray6)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
    }
}
