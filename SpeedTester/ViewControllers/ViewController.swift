//
//  ViewController.swift
//  SpeedTester
//
//  Created by Ranosys on 14/06/17.
//  Copyright © 2017 Jogendar. All rights reserved.
//

import UIKit
import MapKit

enum SpeedInterval: Int {
    case greaterThan80 = 30
    case speed60to80 = 60
    case speed30to60 = 120
    case lessThan30 = 300
    case notAny = 1
}

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationBtn: UIButton!
    var locationManager:CLLocationManager!
    var timeInterval: SpeedInterval = SpeedInterval.notAny
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationBtn.setLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setSpeedInterval(interval: SpeedInterval) -> Void {
        timeInterval = interval
    }
    // MARK: - Location button Methods
    @IBAction func locationButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.setBackground()
        if sender.isSelected {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
            TimerCheck().stop()
        }
    }
    
    
}
extension ViewController:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        location.updateCenterLocation(mapVeiw: self.mapView)
        location.calculateSpeed(interval: timeInterval, callbackForSetInterval: setSpeedInterval)
    }
}
