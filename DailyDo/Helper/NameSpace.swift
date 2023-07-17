//
//  nameSpace.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/07/10.
//

import Foundation

enum cellIdentifier{
    static let alarmList = "alarmListCell"
    static let setTime = "setTimeCell"
    static let cycle = "CycleCell"
}

enum nfcentre {
    static let name = "DismissAddAlarmVC"
}


enum country {
    static let korea = "ko-KR"
}

enum cycleText {
    static let days = ["1일마다","2일마다","3일마다","4일마다","5일마다","6일마다","7일마다"]
}

enum addAlram {
    static let cellLeftLabel = ["반복 주기", "첫번째 알림", "두번째 알림"]
    static let cellRightLabel = ["매일", "09:30", "20:00"]
    
    static let insertMessage = "내용을 입력해주세요."
    static let addAlarm = "알람 추가"
    static let cancel = "취소"
    static let add = "추가"
}

enum dailyDo {
    static let title = "DailyDo"
}
