// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "unify_native",
    products: [
        .library(
            name: "UnifyNativeKit",
            targets: ["UnifyNativeKit"]
        ),
        .executable(
            name: "unify",
            targets: ["UnifyCLI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0")
    ],
    targets: [
        .target(
            name: "UnifyNativeKit",
            dependencies: []
        ),
        .executableTarget(
            name: "UnifyCLI",
            dependencies: [
                "UnifyNativeKit",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ]
)
