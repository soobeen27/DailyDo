//
//  AddToDoViewController.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/20.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    let leftLabel = ["반복 주기", "첫번째 알림", "두번째 알림"]
    let rightLabel = ["매일", "09:30", "20:00"]
    
    private let tableView = UITableView()
    
    lazy var toDoTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        textView.isScrollEnabled = false
        textView.textContainer.maximumNumberOfLines = 5
        
        textView.text = "내용을 입력해 주세요."
        textView.textColor = .secondaryLabel
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()
    
    lazy var cyclePickerView: UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    lazy var cancelBtn: UIButton = {
        
        var attrStr = AttributedString.init("취소")
        attrStr.font = .systemFont(ofSize: 18)
        attrStr.foregroundColor = .systemBlue
        
        var btnConf = UIButton.Configuration.plain()
        btnConf.attributedTitle = attrStr
        
        let btn = UIButton(configuration: btnConf)
        
        return btn
    }()
    
    lazy var addBtn: UIButton = {
        var attrStr = AttributedString.init("추가")
        attrStr.font = .systemFont(ofSize: 18, weight: .semibold)
        attrStr.foregroundColor = .systemBlue
        
        var btnConf = UIButton.Configuration.plain()
        btnConf.attributedTitle = attrStr
        
        let btn = UIButton(configuration: btnConf)
        return btn
    }()
    
    lazy var setTimeView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
//        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        return view
    }()
    
    
    lazy var tfAndPvSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [toDoTextView, setTimeView])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 30
        return sv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "알림 추가"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    lazy var titleAndBtnView: UIView = {
        let view = UIView()
        view.addSubview(cancelBtn)
        view.addSubview(titleLabel)
        view.addSubview(addBtn)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setTableView()
        setLayout()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.backgroundColor = .secondarySystemBackground
        
        tableView.rowHeight = 40
        tableView.register(SetTimeCell.self, forCellReuseIdentifier: "SetTimeCell")
    }
    
    func setLayout() {
        view.addSubview(tfAndPvSV)
        view.addSubview(titleAndBtnView)
        
        
        titleAndBtnView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(cancelBtn.snp.height)
        }
        
        cancelBtn.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        addBtn.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        toDoTextView.snp.makeConstraints {
            $0.height.equalTo(150)
        }
        
        setTimeView.snp.makeConstraints {
            $0.height.equalTo(119)
        }
        
        tfAndPvSV.snp.makeConstraints {
            $0.top.equalTo(cancelBtn.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(setTimeView)
        }
        
    }
    
}

extension AddToDoViewController: UITableViewDelegate {
    
}

extension AddToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetTimeCell", for: indexPath) as! SetTimeCell
        cell.leftLabel.text = leftLabel[indexPath.row]
        cell.rightLabel.text = rightLabel[indexPath.row]
        return cell
    }
}

extension AddToDoViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .secondaryLabel {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요."
            textView.textColor = .secondaryLabel
        }
    }
}
