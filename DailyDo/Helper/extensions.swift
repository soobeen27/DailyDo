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
}
