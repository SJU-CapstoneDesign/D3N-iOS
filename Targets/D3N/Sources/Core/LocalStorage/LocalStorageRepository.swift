//
//  LocalStorageRepository.swift
//  D3N
//
//  Created by 송영모 on 10/17/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct LocalStorageManager {
    public enum Key: String {
        case accessToken
        case refreshToken
    }
    
    public static func save(_ key: Key, value: String) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    public static func load(_ key: Key) -> String {
        let value = UserDefaults.standard.object(forKey: key.rawValue) as? String
        return value ?? ""
    }
    
//    public static func saveAlreadySolvedNewsIds(ids: [Int]) {
//        var newIds = loadAlreadySolvedNewsIds() + ids
//        UserDefaults.standard.set(newIds, forKey: Keys.alreadySolvedNewsIds.rawValue)
//    }
//    
//    public static func loadAlreadySolvedNewsIds() -> [Int] {
//        let ids = UserDefaults.standard.object(forKey: Keys.alreadySolvedNewsIds.rawValue) as? [Int]
//        return ids ?? []
//    }
}
