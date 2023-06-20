//
//  SetCycleVC.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/21.
//

import UIKit

class SetCycleVC: UIViewController {

    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    func setTableView() {
        tableView.rowHeight = 40
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableView.register(SetTimeCell.self, forCellReuseIdentifier: "SetTimeCell")
    }
}

extension SetCycleVC: UITableViewDelegate {
    
}
extension SetCycleVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
