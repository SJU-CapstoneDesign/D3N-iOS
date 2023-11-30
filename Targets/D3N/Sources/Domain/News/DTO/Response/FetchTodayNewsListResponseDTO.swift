//
//  FetchTodayNewsListResponseDTO.swift
//  D3N
//
//  Created by 송영모 on 11/30/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

typealias FetchTodayNewsListResponseDTO = [FetchTodayNewsListResponseElement]

struct FetchTodayNewsListResponseElement: Codable {
    let type, title, subtitle: String
    let newsList: [FetchNewsListResponseElement]
}
