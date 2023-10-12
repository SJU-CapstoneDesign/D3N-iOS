//
//  BaseModel.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

struct BaseModel<T: Codable>: Codable {
    let success: Bool
    let result: T?
    let error: ErrorDTO?
}
