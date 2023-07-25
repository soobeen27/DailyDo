//
//  Colours.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/07/26.
//

import UIKit

enum Colors: String {
    
    case complete = "complete"
    case incomplete = "incomplete"
    var doneBtnBackground: UIColor {
        switch self {
        case .complete:
            return UIColor.blue
        case .incomplete:
            return UIColor.black
        }
        
    }
}


