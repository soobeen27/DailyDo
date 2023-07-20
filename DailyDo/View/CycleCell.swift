//
//  CycleCell.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/22.
//

import UIKit

class CycleCell: UITableViewCell {

    
    lazy var cycleLabel: UILabel = {
        let label = UILabel()
        label.text = "every 7days"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLayout() {
        contentView.addSubview(cycleLabel)
        
        cycleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
        }
    }

}
