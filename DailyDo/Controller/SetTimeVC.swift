//
//  SetTimeVC.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/30.
//

import UIKit

class SetTimeVC: UIViewController {

    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        setLayout()
        
    }
    
    func setDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.locale = Locale(identifier: country.korea)
        datePicker.timeZone = .autoupdatingCurrent
    }
    
    func setLayout() {
        view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(100)
        }
    }

}
