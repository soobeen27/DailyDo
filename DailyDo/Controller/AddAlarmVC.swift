//
//  AddToDoViewController.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/20.
//

import UIKit

class AddAlarmVC: UIViewController {
    
    //    private let tableView = UITableView()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40
        tableView.register(SetCycleCell.self, forCellReuseIdentifier: CellIdentifier.setCycle)
        tableView.register(SetTimeCell.self, forCellReuseIdentifier: CellIdentifier.setTime)
        return tableView
    }()
    
    private var dataSource = [CellModel]()
    
    let dataManager = CoreDataManager.shared
    
    var memoData: MemoEntity?
    
    var cycle: Int16 = 0
    
    var firstTime: Date?
    var secondTime: Date?
    
    //    lazy var firstTime = UIDatePicker()
    
    
    
    
    lazy var alarmTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        textView.isScrollEnabled = false
        textView.textContainer.maximumNumberOfLines = 5
        
        textView.text = AddAlram.insertMessage
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
    
//    lazy var cancelBtn: UIButton = {
//
//        var attrStr = AttributedString.init(AddAlram.cancel)
//        attrStr.font = .systemFont(ofSize: 18)
//        attrStr.foregroundColor = .systemBlue
//
//        var btnConf = UIButton.Configuration.plain()
//        btnConf.attributedTitle = attrStr
//
//        let btn = UIButton(configuration: btnConf)
//
//        return btn
//    }()
//
//    lazy var saveBtn: UIButton = {
//        var attrStr = AttributedString.init(AddAlram.add)
//        attrStr.font = .systemFont(ofSize: 18, weight: .semibold)
//        attrStr.foregroundColor = .systemBlue
//
//        var btnConf = UIButton.Configuration.plain()
//        btnConf.attributedTitle = attrStr
//
//        let btn = UIButton(configuration: btnConf)
//        btn.addTarget(self, action: #selector(saveBtnHit(_:)), for: .touchUpInside)
//        return btn
//    }()
    
    lazy var saveBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(saveBtnHit(_:)))
        return btn
    }()
    
    lazy var testBtn: UIButton = {
        var attrStr = AttributedString.init(AddAlram.add)
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
        label.text = AddAlram.addAlarm
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
//    lazy var titleAndBtnView: UIView = {
//        let view = UIView()
//        view.addSubview(cancelBtn)
//        view.addSubview(titleLabel)
//        view.addSubview(saveBtn)
//        return view
//    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name(Nfcentre.name), object: nil)
    }
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = .systemBackground
        //        setTableView()
        setLayout()
        refresh()
        setNav()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: Save Button Hit func
    @objc func saveBtnHit(_ sender: UIButton!) {
        print("add btn hit")
        
        if let data = memoData {
            data.memo = alarmTextView.text
            dataManager.updateMemo(newMemoEntity: data) {
                self.dismiss(animated: true)
            }
        } else {
            let newText = alarmTextView.text
            guard let firstTimeStr = firstTime?.getStrTime(), let secondTimeStr = secondTime?.getStrTime() else { return }
            dataManager.saveMemoEntity(memoText: newText, memoCycle: cycle, firstTime: firstTimeStr, secondTime: secondTimeStr, isFirst: true) {
                self.dismiss(animated: true)
                print(self.dataManager.getMemoListFromCoreData())
            }
        }
    }
    //MARK: NavigationController setting
    func setNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        title = DailyDo.addAlarmVCTitle
        
//        navigationItem.rightBarButtonItem = self.addBtn
    }
    
    //MARK: TableView data setting
    private func refresh() {
        self.dataSource = [
            .setCycle(leftLabel: "반복 주기", rightLabel: CycleText.days[Int(cycle)]),
            .setTime(leftLabel: AddAlram.cellLeftLabel[0]),
            .setTime(leftLabel: AddAlram.cellLeftLabel[0])
            
        ]
        self.tableView.reloadData()
    }
    
    //MARK: Layout setting
    func setLayout() {
        view.addSubview(tfAndPvSV)
//        view.addSubview(titleAndBtnView)
        view.addSubview(testBtn)
        
        
//        titleAndBtnView.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(15)
//            $0.leading.equalToSuperview().offset(10)
//            $0.trailing.equalToSuperview().offset(-10)
//            $0.height.equalTo(cancelBtn.snp.height)
//        }
//
//        cancelBtn.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.leading.equalToSuperview()
//        }
//
//        saveBtn.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.trailing.equalToSuperview()
//        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        alarmTextView.snp.makeConstraints {
            $0.height.equalTo(150)
        }
        
        setTimeView.snp.makeConstraints {
            $0.height.equalTo(119)
        }
        
//        tfAndPvSV.snp.makeConstraints {
//            $0.top.equalTo(cancelBtn.snp.bottom).offset(40)
//            $0.leading.equalToSuperview().offset(20)
//            $0.trailing.equalToSuperview().offset(-20)
//        }
//
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
    }
}
//MARK: UITableViewDataSource
extension AddAlarmVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.dataSource[indexPath.row] {
        case let .setCycle(leftLabel,  rightLabel):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.setCycle, for: indexPath) as! SetCycleCell
            cell.leftLabel.text = leftLabel
            cell.rightLabel.text = rightLabel
            return cell
        case let .setTime(leftLabel):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.setTime, for: indexPath) as! SetTimeCell
            cell.delegate = self
            cell.leftLabel.text = leftLabel
            cell.tag = indexPath.row
            cell.selectionStyle = .none
            return cell
        }
        
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
            textView.text = AddAlram.insertMessage
            textView.textColor = .secondaryLabel
        }
    }
}

extension AddAlarmVC: UpdateCycle {
    func updateCycle(_ cycle: Int16) {
        self.cycle = cycle
        print(self.cycle)
        self.refresh()
    }
}

extension AddAlarmVC: DatePickerDelegate {
    func datePickerValueChanged(_ cell: SetTimeCell, selectedDate: Date) {
        if cell.tag == 1 {
            self.firstTime = selectedDate
            // This is the first cell's picker
            // Handle the selected date for the first cell here
        } else if cell.tag == 2 {
            self.secondTime = selectedDate
            // This is the second cell's picker
            // Handle the selected date for the second cell here
        }
    }
}
