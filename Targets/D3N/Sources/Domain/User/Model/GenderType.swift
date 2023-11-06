//
//  GenderType.swift
//  D3N
//
//  Created by 송영모 on 11/4/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

public enum Gender: String, Codable, CaseIterable {
    case man = "MAN"
    case woman = "WOMAN"
    case notSelected = "NOT_SELECTED"
    
    var title: LocalizedStringKey {
        switch self {
        case .man: return "남자"
        case .woman: return "여자"
        case .notSelected: return "선택안함"
        }
    }
}
