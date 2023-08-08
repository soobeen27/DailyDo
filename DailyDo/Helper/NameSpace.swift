//
//  nameSpace.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/07/10.
//

import Foundation

enum CellIdentifier{
    static let alarmList = "alarmListCell"
    static let setCycle = "setCycleCell"
    static let setTime = "setTimeCell"
    static let cycle = "CycleCell"
}

enum Nfcentre {
    static let name = "DismissAddAlarmVC"
}


enum Country {
    static let korea = "ko-KR"
}

enum CycleText {
    static let days = ["매일","2일마다","3일마다","4일마다","5일마다","6일마다","7일마다"]
}

enum AddAlram {
    static let cellLeftLabel = ["첫번째 알림", "두번째 알림"]
    static let cellRightLabel = ["매일", "09:30", "20:00"]
    
    static let insertMessage = "내용을 입력해주세요."
    static let title = "알람 추가"
    static let cancel = "취소"
    static let add = "추가"
    static let cycleTerm = "반복 주기"
}

enum DoneBtn {
    static let isDone = ["미완","완료"]
    
}


enum DailyDo {
    static let title = "DailyDo"
}


