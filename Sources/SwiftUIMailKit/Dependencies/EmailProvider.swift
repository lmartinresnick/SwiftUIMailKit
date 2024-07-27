//
//  EmailProvider.swift
//  SwiftUIMailKit
//
//  Created by Luke Martin-Resnick on 7/27/24.
//

import Foundation

public enum EmailType {
    case mfmail
    case thirdPartyUrl(url: URL)
    case error(message: String)
}

public enum EmailProvider {
    case system
    case gmail
    case outlook
    case yahoo
    case spark

    public func url(recipient: String, subject: String, body: String?) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var bodyEncoded: String?
        if let body {
            bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }

        var urlString: String

        switch self {
        case .system:
            urlString = "mailto:\(recipient)?subject=\(subjectEncoded)"
        case .gmail:
            urlString = "googlegmail://co?to=\(recipient)&subject=\(subjectEncoded)"
        case .outlook:
            urlString = "ms-outlook://compose?to=\(recipient)&subject=\(subjectEncoded)"
        case .yahoo:
            urlString = "ymail://mail/compose?to=\(recipient)&subject=\(subjectEncoded)"
        case .spark:
            urlString = "readdle-spark://compose?recipient=\(recipient)&subject=\(subjectEncoded)"
        }

        if let bodyEncoded {
            urlString += "&body=\(bodyEncoded)"
        }

        return URL(string: urlString)
    }
}
