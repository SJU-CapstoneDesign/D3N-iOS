//
//  NewsDTO.swift
//  D3N
//
//  Created by 송영모 on 10/17/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

struct NewsDTO: Codable {
    let id: Int
    let field: NewsField
    let newsType: NewsType
    let title: String
    let summary: String
    let url: String
    
    func toDomain() -> NewsEntity {
        return .init(
            id: self.id,
            field: self.field,
            type: self.newsType,
            title: self.title,
            summary: self.summary,
            url: self.url
        )
    }
}
