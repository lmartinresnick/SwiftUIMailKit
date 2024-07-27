//
//  MailView.swift
//  SwiftUIMailKit
//
//  Created by Luke Martin-Resnick on 7/27/24.
//

import MessageUI
import SwiftUI

public struct MailViewModifier: ViewModifier {
    @Binding public var open: Bool

    public let to: String
    public let subject: String
    public var body: String?

    public func body(content: Content) -> some View {
        content
            .sheet(
                isPresented: $open,
                onDismiss: {
                    open = false
                },
                content: {
                    MailView(to: to, subject: subject, body: body)
                        .ignoresSafeArea()
                }
            )
    }
}

public struct MailView: UIViewControllerRepresentable {

    public var to: String
    public var subject: String
    public var body: String? = nil

    public func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let view = MFMailComposeViewController()
        view.mailComposeDelegate = context.coordinator
        view.setToRecipients([to])
        view.setSubject(subject)
        if let body {
            view.setMessageBody(body, isHTML: false)
        }
        return view
    }

    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }


    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        public var parent: MailView

        public init(_ parent: MailView) {
            self.parent = parent
        }

        public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}
