// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DrugTestCheckerCore",

    platforms: [
        .iOS(.v26)
    ],

    products: [
        .library(
            name: "DrugTestCheckerCore",
            targets: ["DrugTestCheckerCore"]
        ),
    ],

    targets: [
        .target(
            name: "DrugTestCheckerCore"
        ),
        .testTarget(
            name: "DrugTestCheckerCoreTests",
            dependencies: ["DrugTestCheckerCore"]
        ),
    ],

    swiftLanguageModes: [.v6]
)
