// swift-tools-version: 5.9

// Dit is een Swift Playgrounds-app. Open de map `Taken.swiftpm` in
// Swift Playgrounds (iPad of Mac) of in Xcode.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Taken",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        .iOSApplication(
            name: "Taken",
            targets: ["AppModule"],
            bundleIdentifier: "com.rv8470.Taken",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .asset("AccentColor"),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)
