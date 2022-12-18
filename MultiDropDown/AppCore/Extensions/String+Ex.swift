//
//  String+Ex.swift
//  SeamsLabTask
//
//  Created by ahmed mostafa on 02/02/2022.
//

import Foundation

extension String {
    func checkRate() -> Bool {
        if count == 0 { return false }
        let regex = try? NSRegularExpression(pattern: "^([1-5])$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

extension String {
    func convertDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en")
        let convertedDate = dateFormatter.date(from: self)
        guard dateFormatter.date(from: self) != nil else { return "" }
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        return timeStamp
    }
}
