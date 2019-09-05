// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "CreditCardFormatter",
    dependencies: [

    ],
    targets: [
        .target(
            name: "CreditCardFormatter",
            dependencies: []),
        .testTarget(
            name: "CreditCardFormatterTests",
            dependencies: ["CreditCardFormatter"]),
    ]
)
