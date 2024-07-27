//
//  EmailComposer.swift
//  SwiftUIMailKit
//
//  Created by Luke Martin-Resnick on 7/27/24.
//

import MessageUI
import SwiftUI

public final class EmailComposer {
    public static let shared = EmailComposer()

    public var recipient: String?

    public static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }

    public func handleEmailRequest(details: MailDetails) -> EmailType {
        if Self.canSendMail {
            return .mfmail
        }

        if let emailUrl = createEmailUrl(details: details) {
            return .thirdPartyUrl(url: emailUrl)
        }

        return .error(message: "Unable to process request. No email provider found on device.")
    }
}

public extension EmailComposer {
    private func createEmailUrl(details: MailDetails) -> URL? {
        let recipient = details.recipient ?? self.recipient ?? ""

        let gmailUrl = EmailProvider.gmail.url(recipient: recipient, subject: details.subject, body: details.body)
        let outlookUrl = EmailProvider.outlook.url(recipient: recipient, subject: details.subject, body: details.body)
        let yahooMail = EmailProvider.yahoo.url(recipient: recipient, subject: details.subject, body: details.body)
        let sparkUrl = EmailProvider.spark.url(recipient: recipient, subject: details.subject, body: details.body)
        let defaultUrl = EmailProvider.system.url(recipient: recipient, subject: details.subject, body: details.body)

        if let gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        } else if let defaultUrl, UIApplication.shared.canOpenURL(defaultUrl) {
            return defaultUrl
        }

        return nil
    }
}
