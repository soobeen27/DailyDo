//
//  ViewController.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/19.
//

import UIKit

class ViewController: UIViewController {
    
    
    let sampleModel : [SampleModel] = [
        SampleModel(toDoText: "운동하기@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@", toDoCycle: "3일마다"),
        SampleModel(toDoText: "공부하기", toDoCycle: "매일"),
        SampleModel(toDoText: "빨래하기", toDoCycle: "일주일에 한번"),
        SampleModel(toDoText: "산책하기@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2", toDoCycle: "이틀마다")
    ]
    
    
    private let tableView = UITableView()
    
    lazy var addBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPressed))
        btn.tintColor = .label
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNav()
        setTableView()
        setLayout()
        // Do any additional setup after loading the view.
    }
    
    func setNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()  // 투명으로
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "DailyDo"
        
        navigationItem.rightBarButtonItem = self.addBtn
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 80
        tableView.register(ToDoListCell.self, forCellReuseIdentifier: "ToDoListCell")
        
    }
    
    @objc func addBtnPressed() {
        print("add btn pressed")
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
        return sampleModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell
        cell.sampleModel = sampleModel[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
}
extension ViewController: UITableViewDelegate {
    
}

