//
//  LocalStorageRepository.swift
//  D3N
//
//  Created by 송영모 on 10/17/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct LocalStorageRepository {
    enum Keys: String {
        case alreadySolvedNewsIds
    }
    
    public static func saveAlreadySolvedNewsIds(ids: [Int]) {
        var newIds = loadAlreadySolvedNewsIds() + ids
        UserDefaults.standard.set(newIds, forKey: Keys.alreadySolvedNewsIds.rawValue)
    }
    
    public static func loadAlreadySolvedNewsIds() -> [Int] {
        let ids = UserDefaults.standard.object(forKey: Keys.alreadySolvedNewsIds.rawValue) as? [Int]
        return ids ?? []
    }
}
