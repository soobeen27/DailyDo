//
//  SetCycleVC.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/21.
//

import UIKit

class SetCycleVC: UIViewController {

    private let tableView = UITableView()
        
    var delegate: UpdateCycle?
    
    var cycleIndex: Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .subLabelColour
        setTableView()
        setLayout()
    }
    
    func setTableView() {
        tableView.rowHeight = 40
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
        
        
        tableView.register(CycleCell.self, forCellReuseIdentifier: CellIdentifier.cycle)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = .checkmark
        delegate?.updateCycle(Int16(indexPath.row))
        
        if let wholeIndexPath = tableView.indexPathsForVisibleRows {
            for cellPath in wholeIndexPath{
               if cellPath == indexPath{
                   continue
               }
                tableView.cellForRow(at: cellPath)!.accessoryType = .none
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
}
extension SetCycleVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cycle.count
        return CycleText.days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cycle, for: indexPath) as! CycleCell
        cell.cycleLabel.text = CycleText.days[indexPath.row]
        if cycleIndex == Int16(indexPath.row) {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    
}

