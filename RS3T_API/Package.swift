// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RS3T_API",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.0.0")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1")),
        .package(url: "https://github.com/IBM-Swift/BlueCryptor.git", .upToNextMinor(from:"0.8.0")),
        .package(url: "https://github.com/vapor/mysql.git", .upToNextMinor(from:"1.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "RS3T_API",
            dependencies: ["Kitura", "HeliumLogger", "Cryptor", "MySQL"]),
    ]
)
