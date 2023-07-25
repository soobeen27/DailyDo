//
//  CustomDelegates.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/07/25.
//

import Foundation

protocol UpdateCycle: AnyObject {
    func updateCycle(_ cycle: Int16)
}


protocol DatePickerDelegate: AnyObject {
    func datePickerValueChanged(_ cell: SetTimeCell, selectedDate: Date)
}

protocol DoneBtnDelegate: AnyObject {
    func toggleDoneBtn(indexPath: Int)
}
