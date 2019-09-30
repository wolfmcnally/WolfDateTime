// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "WolfDateTime",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "WolfDateTime",
            targets: ["WolfDateTime"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfCore", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "WolfDateTime",
            dependencies: ["WolfCore"])
        ]
)
