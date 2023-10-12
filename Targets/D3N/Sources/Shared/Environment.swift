//
//  Environment.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct Environment {
    public static var baseURL: String {
        return Bundle.main.infoDictionary?["SERVER_HOST"] as? String ?? ""
    }
}
