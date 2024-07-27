# SwiftUIMailKit
[![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.9-Orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS-Green?style=flat-square)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)

SwiftUIMail is a lightweight library to easily draft emails within your SwiftUI Views. It is written in Swift. Utilizes MFMessageComposeViewController and third party email provider support.

## Requirements

| Platform                                             | Minimum Swift Version | Installation                                                                                                         | Status                   |
| ---------------------------------------------------- | --------------------- | -------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| iOS 14.0+ | 5.5+ / Xcode 15+    | [Swift Package Manager](#swift-package-manager) | Fully Tested             |

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding KeyboardBeGone as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift` or the Package list in Xcode.

```swift
dependencies: [
    .package(url: "https://github.com/lmartinresnick/SwiftUIMail", .upToNextMajor(from: "1.0.0"))
]
```

## Usage

SwiftUIMailKit is easy to use.

- Import library
```swift
import SwiftUIMailKit
```

- A sample `SwiftUI View` using `MailViewConfig`
```swift
struct ExampleView: View {
    @State private var mailViewConfig = MailViewConfig()
    @Environment(\.openURL) private var openURL

    var body: some View {
        Button("Handle Mail Request") {
            switch mailViewConfig.handleRequest() {
            case .mfMail:
                let details = MailDetails(recipient: "hi@example.com", subject: "MailViewConfig Example email", body: "This is an example using MailViewConfig")
                mailViewConfig.open(details)
            case .thirdPartyUrl(let url):
                openURL(url)
            case error(let message):
                // Handle error message
            }
        }
        .openMailView($mailViewConfig)
    }
}
```
- A sample `SwiftUI View` using basic options. *Note: This will only try to open using MFMailComposeViewController*
```swift
struct ExampleView: View {
    @State private var openMailView = false
    @State private var recipient = "hi@example.com"
    @State private var subject = "Basic Example"
    @State private var body = "This is a basic example."

    var body: some View {
        Button("Handle Mail Request") {
            if EmailComposer.canSendMail {
                openMailView = true
            } else {
                // handle error
            }
        }
        .openMailView(open: $openMailView, to: recipient, subject: subject, body: body)
    }
}
```
- (Optional): Set global recipient to avoid usage in MailDetails object
```swift
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        ...
        EmailComposer.shared.recipient = "hi@example.com"
        ...
        return true
    }
}
```

- (Optional): Configure `EmailComposer` to default to system (`MFMailComposerViewController`) or Third Party Email Provider.
```swift
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        ...
        EmailComposer.shared.defaultToSystem = true // try system first
        EmailComposer.shared.defaultToSystem = false // try third party provider first
        ...
        return true
    }
}
```

## Communication

- If you **found a bug**, open an issue here on GitHub. The more detail the better!

## License

SwiftUIMailKit is released under the MIT license. [See LICENSE](https://github.com/lmartinresnick/SwiftUIMailKit/blob/main/LICENSE) for details.
