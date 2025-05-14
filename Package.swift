// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Beacon",
    platforms: [
        .iOS(.v17),
        .macOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Beacon",
            targets: ["Beacon"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk", "11.0.0"..<"12.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Beacon",
            dependencies: [
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
            ],
        ),
        .testTarget(
            name: "BeaconTests",
            dependencies: ["Beacon"]
        ),
    ]
)
