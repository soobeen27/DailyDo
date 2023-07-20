//
//  AddToDoViewController.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/20.
//

import UIKit

class AddAlarmVC: UIViewController {
    
    private let tableView = UITableView()
    
    let dataManager = CoreDataManager.shared
    
    var memoData: MemoEntity?
    
    var cycle: Int16 = 0
    
    lazy var alarmTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        textView.isScrollEnabled = false
        textView.textContainer.maximumNumberOfLines = 5
        
        textView.text = addAlram.insertMessage
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
        
        var attrStr = AttributedString.init(addAlram.cancel)
        attrStr.font = .systemFont(ofSize: 18)
        attrStr.foregroundColor = .systemBlue
        
        var btnConf = UIButton.Configuration.plain()
        btnConf.attributedTitle = attrStr
        
        let btn = UIButton(configuration: btnConf)
        
        return btn
    }()
    
    lazy var saveBtn: UIButton = {
        var attrStr = AttributedString.init(addAlram.add)
        attrStr.font = .systemFont(ofSize: 18, weight: .semibold)
        attrStr.foregroundColor = .systemBlue
        
        var btnConf = UIButton.Configuration.plain()
        btnConf.attributedTitle = attrStr
        
        let btn = UIButton(configuration: btnConf)
        btn.addTarget(self, action: #selector(saveBtnHit(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var testBtn: UIButton = {
        var attrStr = AttributedString.init(addAlram.add)
        attrStr.font = .systemFont(ofSize: 18, weight: .semibold)
        attrStr.foregroundColor = .systemBlue
        
        var btnConf = UIButton.Configuration.plain()
        btnConf.attributedTitle = attrStr
        
        let btn = UIButton(configuration: btnConf)
        btn.addTarget(self, action: #selector(saveBtnHit(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var setTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.addSubview(tableView)
        return view
    }()
    
    
    lazy var tfAndPvSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [alarmTextView, setTimeView])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 30
        return sv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = addAlram.addAlarm
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    lazy var titleAndBtnView: UIView = {
        let view = UIView()
        view.addSubview(cancelBtn)
        view.addSubview(titleLabel)
        view.addSubview(saveBtn)
        return view
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name(nfcentre.name), object: nil)
    }
    
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
        tableView.register(SetTimeCell.self, forCellReuseIdentifier: cellIdentifier.setTime)
    }
    
    @objc func saveBtnHit(_ sender: UIButton!) {
        print("add btn hit")
        if let data = memoData {
            data.memo = alarmTextView.text
            dataManager.updateMemo(newMemoEntity: data) {
                self.dismiss(animated: true)
            }
        } else {
            let newText = alarmTextView.text
            dataManager.saveMemoEntity(memoText: newText, memoCycle: cycle, firstTime: "0800", secondTime: "2200", isFirst: true) {
                self.dismiss(animated: true)
            }
        }
    }
//MARK: Layout setting
    func setLayout() {
        view.addSubview(tfAndPvSV)
        view.addSubview(titleAndBtnView)
        view.addSubview(testBtn)
        
        
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
        
        saveBtn.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        alarmTextView.snp.makeConstraints {
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
        
        testBtn.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
    }
    
}
//MARK: UITableViewDelegate

extension AddAlarmVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = SetCycleVC()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
            
        }
        //        else {
        //            let vc = SetTimeVC()
        //            vc.modalPresentationStyle = .automatic
        //            present(vc, animated: true)
        //        }
    }
}

extension AddAlarmVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.setTime, for: indexPath) as! SetTimeCell
        cell.leftLabel.text = addAlram.cellLeftLabel[indexPath.row]
        if indexPath.row == 0 {
            cell.rightLabel.text = cycleText.days[Int(cycle)]
        } else {
            cell.rightLabel.text = addAlram.cellRightLabel[indexPath.row]
        }
        return cell
    }
}

//MARK: UITextViewDelegate

extension AddAlarmVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .secondaryLabel {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = addAlram.insertMessage
            textView.textColor = .secondaryLabel
        }
    }
}
//MARK: Delegate Protocol
protocol UpdateCycle: AnyObject {
    func updateCycle(_ cycle: Int16)
}

extension AddAlarmVC: UpdateCycle {
    func updateCycle(_ cycle: Int16) {
        self.cycle = cycle
        print(self.cycle)
        self.tableView.reloadData()
    }
}
