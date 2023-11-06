//
//  LocalStorageRepository.swift
//  D3N
//
//  Created by 송영모 on 10/17/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct LocalStorageManager {
    public enum Key: String, CaseIterable {
        case accessToken
        case refreshToken
        case isOnBoardingNeeded
    }
    
    public static func save<T>(_ key: Key, value: T) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    public static func load<T>(_ key: Key) -> T? {
        let value = UserDefaults.standard.object(forKey: key.rawValue) as? T
        return value
    }
    
    public static func deleteAll() {
        Key.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}
