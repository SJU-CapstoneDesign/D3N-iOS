//
//  UserOnboardResponseDTO.swift
//  D3N
//
//  Created by 송영모 on 11/4/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import Foundation

struct UserOnboardResponseDTO: Codable {
    let createdAt, modifiedAt, id, nickname: String
    let gender: Gender
    let birthYear: Int
    let categoryList: [NewsField]
    let scrapList: [Int]
    let appleRefreshToken, refreshToken, memberProvider, roleType: String
    let solvedQuizList: [UserOnboardResponseSolvedQuizDTO]
}

extension UserOnboardResponseDTO {
    func toEntity() -> UserEntity {
        return .init(
            nickname: self.nickname,
            gender: self.gender,
            birthYear: self.birthYear,
            categoryList: self.categoryList)
    }
}

internal struct UserOnboardResponseSolvedQuizDTO: Codable {
    let createdAt, modifiedAt: String
    let id: Int
    let user: String
    let quizID, selectedAnswer, quizAnswer: Int
    let quizResult: Bool

    enum CodingKeys: String, CodingKey {
        case createdAt, modifiedAt, id, user
        case quizID = "quizId"
        case selectedAnswer, quizAnswer, quizResult
    }
}
