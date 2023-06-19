//
//  AddToDoViewController.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/20.
//

import UIKit

class AddToDoViewController: UIViewController {

    lazy var toDoTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var cyclePickerView: UIPickerView = {
       let pv = UIPickerView()
        return pv
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}
