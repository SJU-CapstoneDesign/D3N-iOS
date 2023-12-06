//
//  TodayNewsEntity.swift
//  D3N
//
//  Created by 송영모 on 11/30/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct TodayNewsEntity: Equatable {
    public let type: String
    public let title: String
    public let subtitle: String
    public let newses: [NewsEntity]
}