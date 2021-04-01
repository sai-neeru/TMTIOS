//
//  Int+Extension.swift
//  RedditDemo
//
//  Created by Sai Pavan Neerukonda on 3/31/21.
//

import Foundation

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            let num = round(million*10)/10
            if num / 1000000 == 1 {
                return "\(1.0)B"
            }
            return "\(num)M"
        }
        else if thousand >= 1.0 {
            let num = round(thousand*10)/10
            if num / 1000 == 1 {
                return "\(1.0)M"
            }
            return "\(num)K"
        }
        else {
            return "\(self)"
        }
    }
}
