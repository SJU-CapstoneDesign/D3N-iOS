import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String, platform: Platform, additionalTargets: [String]) -> Project {
        var dependencies: [TargetDependency] = []
        
        dependencies += [
            .external(name: "ComposableArchitecture"),
            .external(name: "Moya"),
            .external(name: "FirebaseAnalytics"),
            .external(name: "GoogleMobileAds")
        ]
        
        var targets = makeAppTargets(
            name: name,
            platform: platform,
            dependencies: dependencies
        )
            //TODO: 지금 안사용
        // targets += additionalTargets.flatMap({ makeFrameworkTargets(name: $0, platform: platform) })
        return Project(
            name: name,
            organizationName: "sju",
            targets: targets
        )
    }
    
    // MARK: - Private
    
    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(name: String, platform: Platform) -> [Target] {
        let sources = Target(
            name: name,
            platform: platform,
            product: .framework,
            bundleId: "sju.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone, .ipad]),
            infoPlist: .default,
            sources: ["Targets/\(name)/Sources/**"],
            resources: [],
            dependencies: []
        )
        let tests = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "sju.\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            resources: [],
            dependencies: [.target(name: name)]
        )
        return [sources, tests]
    }
    
    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "sju.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone, .ipad]),
            infoPlist: .file(path: .relativeToRoot("Targets/\(name)/Sources/Config/D3N-Info.plist")),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            entitlements: .file(path: .relativeToRoot("D3N.entitlements")),
            dependencies: dependencies,
            settings: .settings(
                base: SettingsDictionary().otherLinkerFlags(["-ObjC"]),
                configurations: [
                    .debug(
                        name: "Debug",
                        xcconfig: .relativeToRoot("Targets/\(name)/Sources/Config/Debug.xcconfig")
                    ),
                    .release(
                        name: "Release",
                        xcconfig: .relativeToRoot("Targets/\(name)/Sources/Config/Release.xcconfig")
                    ),
                ]
            )
        )
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "sju.\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])
        return [mainTarget, testTarget]
    }
}
