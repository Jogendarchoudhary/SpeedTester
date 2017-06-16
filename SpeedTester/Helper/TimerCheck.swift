//
//  TimerCheck.swift
//  SpeedTester
//
//  Created by Ranosys on 15/06/17.
//  Copyright © 2017 Jogendar. All rights reserved.
//

import Foundation

class TimerCheck {
    public var shareInstance = Timer()
    init() {
    }
    init(withInterval: SpeedInterval,target:Any) {
        shareInstance.invalidate()
        shareInstance = Timer.scheduledTimer(timeInterval: TimeInterval(withInterval.rawValue), target: target, selector: #selector(timerFuncTriggered(_:)), userInfo: ["interval":withInterval], repeats: true)
    }
    @objc func timerFuncTriggered(_ timer: Timer) {}
    func stop() {
        shareInstance.invalidate()
    }
}
