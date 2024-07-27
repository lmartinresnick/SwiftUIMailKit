//
//  MailViewConfig.swift
//  SwiftUIMailKit
//
//  Created by Luke Martin-Resnick on 7/27/24.
//

import SwiftUI

public struct MailDetails {
    var recipient: String? // setting this will override singleton recipient variable in EmailComposer
    var subject: String
    var body: String?
}

public struct MailViewConfig {
    var details: MailDetails = MailDetails(subject: "")
    var open: Bool = false

    private let composer = EmailComposer()

    func handleRequest() -> EmailType {
        composer.handleEmailRequest(details: details)
    }
}

public extension MailViewConfig {
    mutating func open(_ details: MailDetails) {
        self.details = details
        withAnimation { self.open = true }
    }

    mutating func close() {
        withAnimation { self.open = false }
    }
}
