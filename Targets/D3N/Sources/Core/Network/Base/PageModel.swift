//
//  PageableModel.swift
//  D3N
//
//  Created by 송영모 on 10/17/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct PageModel<T: Codable>: Codable {
    let success: Bool
    let result: PageResult<T>?
    let error: ErrorDTO?
}

public struct PageResult<T: Codable>: Codable {
    public let content: [T]
    public let pageable: Pageable
    public let totalPages, totalElements: Int
    public let last: Bool
    public let size, number: Int
    public let sort: PageableSort
    public let numberOfElements: Int
    public let first, empty: Bool
}

public struct Pageable: Codable {
    public let pageNumber, pageSize: Int
    public let sort: PageableSort
    public let offset: Int
    public let paged, unpaged: Bool
}

public struct PageableSort: Codable {
    public let empty, unsorted, sorted: Bool
}
