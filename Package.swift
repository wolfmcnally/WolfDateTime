// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "WolfDateTime",
    products: [
        .library(
            name: "WolfDateTime",
            targets: ["WolfDateTime"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfCore", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "WolfDateTime",
            dependencies: ["WolfCore"])
        ]
)
