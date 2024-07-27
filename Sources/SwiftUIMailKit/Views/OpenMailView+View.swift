//
//  OpenMailView+View.swift
//  SwiftUIMailKit
//
//  Created by Luke Martin-Resnick on 7/27/24.
//

import SwiftUI

public extension View {
    func openMailView(_ config: Binding<MailViewConfig>) -> some View {
        openMailView(
            open: config.open,
            to: config.details.recipient.wrappedValue ?? EmailComposer.shared.recipient ?? "",
            subject: config.details.subject.wrappedValue,
            body: config.details.body.wrappedValue
        )
    }

    func openMailView(open: Binding<Bool>, to: String, subject: String, body: String? = nil) -> some View {
        modifier(MailViewModifier(open: open, to: to, subject: subject, body: body))
    }
}
