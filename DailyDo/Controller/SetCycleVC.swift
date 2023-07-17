//
//  SetCycleVC.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/21.
//

import UIKit

class SetCycleVC: UIViewController {
    
//    private let cycle = ["1일마다","2일마다","3일마다","4일마다","5일마다","6일마다","7일마다"]

    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setTableView()
        setLayout()
    }
    
    func setTableView() {
        tableView.rowHeight = 40
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 10
        
        
        tableView.register(CycleCell.self, forCellReuseIdentifier: cellIdentifier.cycle)
    }
    
    func setLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(60)
            $0.height.equalTo(280)
        }
    }
    
    
}





extension SetCycleVC: UITableViewDelegate {
    
}
extension SetCycleVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cycle.count
        return cycleText.days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cycle, for: indexPath) as! CycleCell
//        cell.cycleLabel.text = cycle[indexPath.row]
        cell.cycleLabel.text = cycleText.days[indexPath.row]
        return cell
    }
    
    
}
