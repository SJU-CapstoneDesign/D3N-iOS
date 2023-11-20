//
//  D3NAnimationButton.swift
//  D3N
//
//  Created by 송영모 on 11/20/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

struct D3NIconAnimationButton: View {
    let icon: D3NIcon?
    let title: String
    let content: String
    
    var action: () -> ()
    
    var isSelected: Bool = false
    @State var isPressed: Bool = false
    
    init(
        icon: D3NIcon? = nil,
        title: String = "",
        content: String = "",
        isSelected: Bool = false,
        
        action: @escaping () -> ()
    ) {
        self.icon = icon
        self.title = title
        self.content = content
        self.isSelected = isSelected
//        self.isPressed = isSelected
        
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                self.icon
                
                VStack(alignment: .leading, spacing: 5) {
                    if !title.isEmpty {
                        Text(title)
                            .fontWeight(.semibold)
                    }
                    if !content.isEmpty {
                        Text(content)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
            }
            .contentShape(.rect)
        })
        .buttonStyle(
            ScrollViewGestureButtonStyle(
                pressAction: {
                    withAnimation {
                        isPressed = true
                    }
                },
                doubleTapTimeoutout: 1,
                doubleTapAction: {
                },
                longPressTime: 0,
                longPressAction: {
                },
                endAction: {
                    withAnimation {
                        isPressed = false
                    }
                }
            )
        )
        .padding(10)
        .background(isSelected ? Color.systemGray6 : Color.background)
        .cornerRadius(20)
        .clipped()
        .scaleEffect(isSelected ? 0.95 : 1)
    }
}
