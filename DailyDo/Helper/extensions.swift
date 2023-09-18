//
//  extensions.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/07/25.
//

import Foundation

extension Date {
    func getStrTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        return dateFormatter.string(from: self)
    }
    
    func getStrIdentifier() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMdHm"
        return dateFormatter.string(from: self)
    }
}

extension String {
    func getIntHour() -> Int {
        return Int(self.prefix(2)) ?? 09
    }
    
    func getIntMinute() -> Int {
        return Int(self.suffix(2)) ?? 00
    }
}
