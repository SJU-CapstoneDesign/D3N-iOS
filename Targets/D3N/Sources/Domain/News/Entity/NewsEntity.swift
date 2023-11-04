//
//  NewsEntity.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct NewsEntity: Equatable {
    let id: Int
    let field: NewsField
    let type: NewsType
    let title: String
    let summary: String
    let url: String
    let mediaCompanyId: String
    let mediaCompanyLogo: String
    let mediaCompanyName: String
    
    //FIXME: 풀었던 뉴스 아이디 저장 로직 내부 구현
    let isAlreadySolved: Bool = false
    
    init(
        id: Int,
        field: NewsField,
        type: NewsType,
        title: String,
        summary: String,
        url: String,
        mediaCompanyId: String,
        mediaCompanyLogo: String,
        mediaCompanyName: String
    ) {
        self.id = id
        self.field = field
        self.type = type
        self.title = title
        self.summary = summary
        self.url = url
        self.mediaCompanyId = mediaCompanyId
        self.mediaCompanyLogo = mediaCompanyLogo
        self.mediaCompanyName = mediaCompanyName
        
        //FIXME: 풀었던 뉴스 아이디 저장 로직 내부 구현
//        self.isAlreadySolved = LocalStorageRepository.loadAlreadySolvedNewsIds().contains(id)
    }
}
