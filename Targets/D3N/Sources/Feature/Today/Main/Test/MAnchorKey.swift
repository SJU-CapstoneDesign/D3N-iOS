//
//  SwiftUIView.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/10/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

struct MAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String: Anchor<CGRect>], nextValue: () -> [String: Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
