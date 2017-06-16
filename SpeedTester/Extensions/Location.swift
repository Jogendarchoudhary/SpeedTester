//
//  Location.swift
//  SpeedTester
//
//  Created by Ranosys on 14/06/17.
//  Copyright © 2017 Jogendar. All rights reserved.
//

import Foundation
import MapKit
extension CLLocation {
    
    func updateCenterLocation(mapVeiw:MKMapView) {
        let center = CLLocationCoordinate2D(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapVeiw.setRegion(region, animated: true)
    }
    
    func calculateSpeed(interval:SpeedInterval, callbackForSetInterval: (SpeedInterval) -> Void) {
        let speed = Float(self.speed * 3.6) //for km/hrs
        
        if speed >= 80 && interval != SpeedInterval.greaterThan80{
            callbackForSetInterval(SpeedInterval.greaterThan80)
            _ =  TimerCheck(withInterval: SpeedInterval.greaterThan80, target: self)
            saveData(speedInterval: SpeedInterval.greaterThan80)
        } else if speed >= 60 && interval != SpeedInterval.speed60to80 {
            callbackForSetInterval(SpeedInterval.speed60to80)
            _ =  TimerCheck(withInterval: SpeedInterval.speed60to80, target: self)
            saveData(speedInterval: SpeedInterval.speed60to80)
        } else if speed >= 30 && interval != SpeedInterval.speed30to60 {
            callbackForSetInterval(SpeedInterval.speed30to60)
            _ =  TimerCheck(withInterval: SpeedInterval.speed30to60, target: self)
            saveData(speedInterval: SpeedInterval.speed30to60);
        } else if speed < 30 && interval != SpeedInterval.lessThan30 {
            callbackForSetInterval(SpeedInterval.lessThan30)
            _ =  TimerCheck(withInterval: SpeedInterval.lessThan30, target: self)
            saveData(speedInterval: SpeedInterval.lessThan30)
        }
    }
    
    @objc func timerFuncTriggered(_ timer: Timer) {
        var dict: [String: SpeedInterval] = timer.userInfo as! [String : SpeedInterval]
        let interval = dict["interval"]
        saveData(speedInterval: interval!)
    }
    
    func saveData(speedInterval : SpeedInterval) {
        let finalData = "\(self.timestamp) \(self.coordinate.latitude)  \(self.coordinate.longitude) \(speedInterval.rawValue)"
        Utils.writeSpeedDataIntoFile(speedData: finalData)
        _ = DBManager.shared.insertDataIntoTable(speedValue: finalData)
    }
}
