//
//  FetchNewsListResponseDTO.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

typealias FetchNewsListResponseDTO = PageResult<FetchNewsListResponseElement>

struct FetchNewsListResponseElement: Codable {
    let id: Int
    let field: NewsField
    let newsType: NewsType
    let title: String
    let summary: String
    let url: String
    let mediaCompanyId: String
    let mediaCompanyLogo: String
    let mediaCompanyName: String
    let secondTime: Int
}

extension FetchNewsListResponseElement {
    func toEntity() -> NewsEntity {
        return .init(
            id: self.id,
            field: self.field,
            type: self.newsType,
            title: self.title,
            summary: self.summary,
            url: self.url,
            mediaCompanyId: self.mediaCompanyId,
            mediaCompanyLogo: self.mediaCompanyLogo,
            mediaCompanyName: self.mediaCompanyName,
            secondTime: self.secondTime
        )
    }
}
