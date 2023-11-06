//
//  NewsField.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

public enum NewsField: String, Codable, CaseIterable {
    case politics = "POLITICS"
    case economy = "ECONOMY"
    case society = "SOCIETY"
    case culture = "CULTURE"
    case life = "LIFE"
    case global = "GLOBAL"
    case sports = "SPORTS"
    case it = "IT"
    case science = "SCIENCE"
    case entertainments = "ENTERTAINMENTS"
    
    var title: LocalizedStringKey {
        switch self {
        case .politics: "정치"
        case .economy: "경제"
        case .society: "사회"
        case .culture: "문화"
        case .life: "생활"
        case .global: "글로벌"
        case .sports: "스포츠"
        case .it: "IT"
        case .science: "과학"
        case .entertainments: "연예"
        }
    }
}
