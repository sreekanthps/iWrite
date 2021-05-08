//
//  DateHelper.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 26/4/21.
//

import Foundation
extension Date {
    var unixTimestamp: Int64 {
        return Int64(self.timeIntervalSince1970 * 1_000)
    }
}
