//
//  TodayNewsEntity.swift
//  D3N
//
//  Created by 송영모 on 11/30/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

struct TodayNewsEntity {
    let type: String
    let title: String
    let subtitle: String
    let newses: [NewsEntity]
}
