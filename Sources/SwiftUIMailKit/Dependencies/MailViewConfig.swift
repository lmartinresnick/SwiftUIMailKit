//
//  MailViewConfig.swift
//  SwiftUIMailKit
//
//  Created by Luke Martin-Resnick on 7/27/24.
//

import SwiftUI

public struct MailDetails {
    public var recipient: String? // setting this will override singleton recipient variable in EmailComposer
    public var subject: String
    public var body: String?

    public init(recipient: String? = nil, subject: String, body: String? = nil) {
        self.recipient = recipient
        self.subject = subject
        self.body = body
    }
}

public struct MailViewConfig {
    public var details: MailDetails
    public var open: Bool
    private let composer = EmailComposer.shared

    public init(
        details: MailDetails = MailDetails(subject: ""),
        open: Bool = false
    ) {
        self.details = details
        self.open = open
    }

    public func handleRequest() -> EmailType {
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
