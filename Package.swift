// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "WolfDateTime",
    platforms: [
        .iOS(.v9), .macOS(.v10_13), .tvOS(.v11)
    ],
    products: [
        .library(
            name: "WolfDateTime",
            targets: ["WolfDateTime"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfCore", .branch("Swift-5.1")),
        // .package(url: "https://github.com/wolfmcnally/WolfCore", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "WolfDateTime",
            dependencies: ["WolfCore"])
        ]
)
