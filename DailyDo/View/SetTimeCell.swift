//
//  SetTimeCell.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/21.
//

import UIKit

class SetTimeCell: UITableViewCell {

    lazy var leftLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "알림 주기"
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.text = "매일"
        return label
    }()
    
    lazy var rightImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.forward")
        iv.tintColor = .secondaryLabel
        iv.frame.size = CGSize(width: 16, height: 16)
        return iv
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        contentView.addSubview(rightImg)
        
        
        leftLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints {
            $0.trailing.equalTo(rightImg.snp.leading).offset(-5)
            $0.centerY.equalToSuperview()
        }
        
        rightImg.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
        }
    }
    
}
