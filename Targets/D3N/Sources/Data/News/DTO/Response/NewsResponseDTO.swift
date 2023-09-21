//
//  NewsResponseDTO.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

struct NewsResponseDTO: Codable {
    let title, summary: String
    let url: String
    let field: String
    let quizs: [QuizDTO]
    
    enum CodingKeys: String, CodingKey {
        case title
        case summary
        case url
        case field
        case quizs = "quizList"
    }
    
    func toDomain() -> NewsEntity {
        return .init(
            title: self.title,
            summary: self.summary,
            url: self.url,
            field: self.field,
            quizs: self.quizs.map { $0.toDomain() }
        )
    }
}

struct QuizDTO: Codable {
    let question: String
    let choiceList: [String]
    let answer: Int
    let reason: String
    
    func toDomain() -> QuizEntity {
        return .init(
            question: self.question,
            choiceList: self.choiceList,
            answer: self.answer,
            reason: self.reason
        )
    }
}

extension QuizDTO {
    static let mocks: [Self] = [
        .init(
            question: "철도파업 사흘째에도 열차 운행이 감축되는 상황에서, 운행률은 어느 수준에 머무르고 있나요?",
            choiceList: [
                "운행률이 100%로 정상 운행 중입니다.",
                "운행률이 80%로 다소 감소하였습니다.",
                "운행률은 평소의 70% 수준에 머무르고 있습니다.",
                "운행률은 50% 미만으로 매우 감소하였습니다."
            ],
            answer: 3,
            reason: "철도파업 사흘째에도 열차 운행이 감축되는 상황에서, 운행률은 평소의 70% 수준에 머무르고 있습니다."
        ),
        .init(
            question: "고속열차(KTX와 SRT)는 이번 철도파업 기간 동안 어떻게 운행될 예정인가요?",
            choiceList: [
                "고속열차는 평소와 동일한 운행률을 유지합니다.",
                "고속열차도 운행률이 70%로 감소됩니다.",
                "고속열차는 전면 중단됩니다.",
                "고속열차는 일반열차와 동일한 운행률로 운행됩니다."
            ],
            answer: 2,
            reason: "고속열차(KTX와 SRT)는 철도파업 기간 동안 운행률이 70%로 감소됩니다."
        ),
        .init(
            question: "철도노조 파업 기간 동안 코레일은 어떤 노력을 기울일 계획인가요?",
            choiceList: [
                "운행을 중단할 예정입니다.",
                "국민 불편 최소화를 위해 열차 운행을 추가 재개할 예정입니다.",
                "파업을 지속할 예정입니다.",
                "파업 기간에 특별한 조치를 취하지 않을 예정입니다."
            ],
            answer: 2,
            reason: "철도노조 파업 기간 동안 코레일은 국민 불편 최소화를 위해 열차 운행을 추가 재개할 예정입니다."
        ),
    ]
}

extension NewsResponseDTO {
    static let mock = Self(
        title: "철도파업 사흘째 열차 감축 운행 지속‥이용객 불편 이어져",
        summary: "전국철도노동조합 파업 사흘째인 오늘도 열차 감축 운행이 이어지는 가운데 운행률은 평소의 70% 수준에 머물고 있습니다.",
        url: "https://n.news.naver.com/mnews/article/214/0001300292?sid=102",
        field: "사회",
        quizs: QuizDTO.mocks
    )
}
