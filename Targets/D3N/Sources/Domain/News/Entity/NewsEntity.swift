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

public extension NewsEntity {
    static let mock = NewsEntity(
        id: 11605391,
        field: .society,
        type: .koreanNews,
        title: "강원도 임금근로자 2명 중 1명 ‘비정규직’…역대 최고치",
        summary: "[앵커] 강원도 내 임금근로자 2명 가운데 한 명은 비정규직이라는 분석이 나왔습니다. 강원도 내 비정규직 비율이 계속 늘어 처음으로 50%를 넘긴 건데요. 경기침체가 길어지는 만큼, 좋은 일자리 찾기가 더 어려워질거란...",
        url: "https://n.news.naver.com/mnews/article/056/0011605391?sid=101",
        mediaCompanyId: "056",
        mediaCompanyLogo: "https://mimgnews.pstatic.net/image/upload/office_logo/056/2021/07/15/logo_056_57_20210715101841.png",
        mediaCompanyName: "KBS"
    )
    
    static let mocks = [
        NewsEntity(
            id: 5622923,
            field: .society,
            type: .koreanNews,
            title: "[사설]미적대는 의대 입학정원 수요조사 발표, 이유 뭔가",
            summary: "정부가 의과대학 입학정원 수요 조사 결과 발표를 두 차례나 연기하며 주저하는 모습을 보이고 있다. 보건복지부는 의대 정원 수요 조사 결과를 지난 13일 발표하겠다더니 돌연 연기한 데 이어 늦어도 17일까지는...",
            url: "https://n.news.naver.com/mnews/article/018/0005622923?sid=110",
            mediaCompanyId: "018",
            mediaCompanyLogo: "https://mimgnews.pstatic.net/image/upload/office_logo/018/2018/08/08/logo_018_57_20180808174308.png",
            mediaCompanyName: "이데일리"
          ),
        NewsEntity(
            id: 11605391,
            field: .society,
            type: .koreanNews,
            title: "강원도 임금근로자 2명 중 1명 ‘비정규직’…역대 최고치",
            summary: "[앵커] 강원도 내 임금근로자 2명 가운데 한 명은 비정규직이라는 분석이 나왔습니다. 강원도 내 비정규직 비율이 계속 늘어 처음으로 50%를 넘긴 건데요. 경기침체가 길어지는 만큼, 좋은 일자리 찾기가 더 어려워질거란...",
            url: "https://n.news.naver.com/mnews/article/056/0011605391?sid=101",
            mediaCompanyId: "056",
            mediaCompanyLogo: "https://mimgnews.pstatic.net/image/upload/office_logo/056/2021/07/15/logo_056_57_20210715101841.png",
            mediaCompanyName: "KBS"
        )
    ]
}
