//
//  Dependencies.swift
//  Config
//
//  Created by 송영모 on 2023/08/11.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.2.0")),
    .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.0")),
    .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "10.15.0"))
])

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
