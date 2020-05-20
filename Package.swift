// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIPinInputView",
    platforms: [ .iOS(.v11)],
    products: [
        .library(
            name: "UIPinInputView",
            targets: ["UIPinInputView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/prashantLalShrestha/DeviceX.git", from: "1.1.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "UIPinInputView",
            dependencies: ["DeviceX"],
            path: "Sources"),
        .testTarget(
            name: "UIPinInputViewTests",
            dependencies: ["UIPinInputView", "DeviceX"],
            path: "UIPinInputViewTests"),
    ]
)
