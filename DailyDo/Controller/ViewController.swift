//
//  ViewController.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/19.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let dataManager = CoreDataManager.shared
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    private let tableView = UITableView()
    
    lazy var addBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnHit))
        btn.tintColor = .label
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNav()
        setTableView()
        setLayout()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailNotification(_:)),
            name: NSNotification.Name(Nfcentre.name),
            object: nil
        )
        
    }
    
    
   
    
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    
    //MARK: NavigationController Setting
    func setNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.tintColor = UIColor.subLabelColour
        navigationController?.navigationBar.prefersLargeTitles = true
        title = DailyDo.title
        
        navigationItem.rightBarButtonItem = self.addBtn
    }
    
    func setTableView() {
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 80
        tableView.register(AlarmListCell.self, forCellReuseIdentifier: CellIdentifier.alarmList)
        
    }
    
    @objc func addBtnHit() {
        print("add btn pressed")
        let addAlarmVC = AddAlarmVC()
        let navigationController = UINavigationController(rootViewController: addAlarmVC)
        navigationController.modalPresentationStyle = .automatic
        present(navigationController, animated: true)
    }
    
    func setLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataManager.getMemo().count
        return dataManager.getMemoListFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.alarmList, for: indexPath) as! AlarmListCell
        cell.selectionStyle = .none
//        cell.memo = dataManager.getMemo()[indexPath.row]
        cell.delegate = self
        cell.tag = indexPath.row
        cell.memoEntity = dataManager.getMemoListFromCoreData()[indexPath.row]
        return cell
    }
    
    
}

extension ViewController: DoneBtnDelegate {
    func toggleDoneBtn(indexPath: Int) {
        let newData = dataManager.getMemoListFromCoreData()[indexPath]
        newData.isDone.toggle()
        print(newData.isDone)
        dataManager.updateMemo(newMemoEntity: newData) {
            self.tableView.reloadData()
        }
    }
}

