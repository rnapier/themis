// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Themis",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Themis",
            targets: ["Themis"]),
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.

        .target(
            name: "soter",
            path: "src/soter",
            exclude: ["openssl", "boringssl"],
//            sources: ["soter/"],
            publicHeadersPath: ".",
            cSettings: [
                .define("CRYPTO_ENGINE_PATH", to: "cryptokit"),
                .headerSearchPath(".."),
            ]
        ),

        .target(
            name: "core",
            dependencies: ["soter"],
            path: "src/themis",
//            sources: ["themis/"],
            publicHeadersPath: ".",
            cSettings: [
                .define("CRYPTO_ENGINE_PATH", to: "cryptokit"),
                .headerSearchPath(".."),
            ]
        ),

        .target(
            name: "Themis",
            dependencies: ["core"],
            path: "src/wrappers/themis/Obj-C",
            publicHeadersPath: "themis",
            cSettings: [
                .headerSearchPath("."),
                .unsafeFlags(["-Wno-nonportable-include-path"])  // FIXME: remove
            ]
        ),
//        .testTarget(
//            name: "ThemisTests",
//            dependencies: ["Themis"],
//            path: "tests/objcthemis/objthemis"
//        ),
    ]
)
