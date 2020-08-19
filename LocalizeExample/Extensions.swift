//
//  Extensions.swift
//  LocalizeExample
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        print(endIndex)
        guard (0..<endIndex).contains(index) else {
            return nil
        }
        return self[index]
    }
}

extension String {
    func localized(_ locale: Locale? = Locale.current) -> String {
        if let path = Bundle.main.path(forResource: locale?.languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        return NSLocalizedString(self, comment: "")
    }
}
