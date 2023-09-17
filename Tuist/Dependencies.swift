//
//  Dependencies.swift
//  Config
//
//  Created by 송영모 on 2023/08/11.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.0.0")),
    .remote(url: "https://github.com/jaemyeong/NMapsMap.git", requirement: .upToNextMajor(from: "3.16.2"))
])

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
