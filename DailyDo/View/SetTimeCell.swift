//
//  SetTimeCell.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/07/20.
//

import UIKit

class SetTimeCell: UITableViewCell {
    
    weak var delegate: DatePickerDelegate?
    
    lazy var leftLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "첫번째 알림"
        return label
    }()
    
    lazy var timePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.tintColor = .label
        dp.datePickerMode = .time
        dp.preferredDatePickerStyle = .compact
        dp.setValue(UIColor.secondaryLabel, forKeyPath: "textColor")
        dp.setValue(false, forKeyPath: "highlightsToday")
        dp.subviews.first?.subviews.forEach { grayView in
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .secondarySystemBackground
            grayView.insertSubview(view, at: 0)
            view.topAnchor.constraint(equalTo: grayView.safeAreaLayoutGuide.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: grayView.safeAreaLayoutGuide.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: grayView.safeAreaLayoutGuide.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: grayView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        dp.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        return dp
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        delegate?.datePickerValueChanged(self, selectedDate: sender.date)
    }
    
    private func setLayout() {
        contentView.addSubview(leftLabel)
        contentView.addSubview(timePicker)
        
        leftLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
        }
        
        timePicker.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
        }
    }
}
