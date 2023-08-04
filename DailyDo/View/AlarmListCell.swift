//
//  ToDoListCell.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/06/19.
//

import UIKit
import SnapKit

class AlarmListCell: UITableViewCell {
    
    weak var delegate: DoneBtnDelegate?
    
    var memoEntity: MemoEntity? {
        didSet{
            setData()
            setIsDoneBtn(doneBtn)
        }
    }
    
    lazy var toDoView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var toDoTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        label.textColor = .label
        label.text = "sample text"
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        return label
    }()
    
    lazy var alarmCycleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.text = "sample secondary text"
        return label
    }()
    
    lazy var doneBtnView: UIView = {
        let view = UIView()
        view.addSubview(doneBtn)
        return view
    }()
    
    lazy var doneBtn: UIButton = {
        var attrStr =  AttributedString.init("오류")
        attrStr.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        attrStr.foregroundColor = .label
        
        
        var configuration = UIButton.Configuration.tinted()
        configuration.attributedTitle = attrStr
        
        let btn = UIButton(configuration: configuration)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(doneBtnHit(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var labelStView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [toDoTextLabel, alarmCycleLabel])
        st.spacing = 10
        st.axis = .vertical
        st.alignment = .fill
        return st
    }()
    
    lazy var toDoStView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [labelStView,doneBtnView])
        st.spacing = 15
        st.axis = .horizontal
        st.alignment = .fill
        return st
    }()
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: DoneBtn target func
    @objc func doneBtnHit(_ sender: UIButton) {
        print("done btn hit")
        delegate?.toggleDoneBtn(indexPath: tag)
        
        setIsDoneBtn(sender)
        
    }
    
    func setIsDoneBtn(_ sender: UIButton) {
        if let isDone = memoEntity?.isDone {
            var attrStr = isDone ? AttributedString.init("완료") : AttributedString.init("미완")
            attrStr.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            attrStr.foregroundColor = isDone ? .secondaryLabel : .label
            sender.configuration?.attributedTitle = attrStr
            sender.tintColor = isDone ? .completeColour : .incompleteColour
        }
    }
    
    
    func setData() {
        toDoTextLabel.text = memoEntity?.memo ?? ""
        alarmCycleLabel.text = CycleText.days[Int(memoEntity?.cycle ?? 0)]
    }
    
    func setLayout() {
        contentView.addSubview(toDoView)
        toDoView.addSubview(toDoStView)
        
        toDoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        doneBtnView.snp.makeConstraints {
            $0.width.equalTo(60)
        }
        
        
        
        doneBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.center.equalToSuperview()
        }
        
        toDoStView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
    }
    
}
