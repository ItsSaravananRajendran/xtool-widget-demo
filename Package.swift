// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "WidgetDemo",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        // An xtool project should contain exactly one library product,
        // representing the main app.
        .library(
            name: "WidgetDemo",
            targets: ["WidgetDemo"]
        ),
        // A widget is an app extension: a second product built as a
        // com.apple.widgetkit-extension bundle.
        .library(
            name: "WidgetDemoWidget",
            targets: ["WidgetDemoWidget"]
        ),
    ],
    targets: [
        .target(
            name: "WidgetDemo"
        ),
        .target(
            name: "WidgetDemoWidget"
        ),
    ]
)
