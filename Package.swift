// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "unify_native",
    products: [
        .executable(
            name: "UnifyNative",
            targets: ["UnifyNative"]
        ),
        .library(
            name: "UnifyNativeKit",
            targets: ["UnifyNativeKit"]
        )
    ],
    targets: [
        .executableTarget(
            name: "UnifyNative",
            dependencies: ["UnifyNativeKit"]
        ),
        .target(
            name: "UnifyNativeKit",
            dependencies: []
        )
    ]
)
