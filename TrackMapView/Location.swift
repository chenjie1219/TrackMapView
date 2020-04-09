//
//  HBLocation.swift
//  HBMapVIew
//
//  Created by Jason on 2020/4/8.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation
import CoreLocation


public class Location: NSObject {
    
    public static let shared = Location()
    
    private override init() {
        super.init()
    }
    
    fileprivate lazy var locationManager:CLLocationManager = {
        
        let manager = CLLocationManager()
        
        manager.activityType = .fitness
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.distanceFilter = kCLLocationAccuracyHundredMeters
        
        manager.requestWhenInUseAuthorization()
        
        manager.delegate = self
        
        return manager
        
    }()
    
    /// 获取到当前位置的回调
    fileprivate var locationClosure:((CLLocationCoordinate2D)->())?
    
    /// 定位是否打开
    public lazy var isLocationEnabled = CLLocationManager.locationServicesEnabled()
    
    /// 定位授权状态
    public lazy var locationStatus = CLLocationManager.authorizationStatus()
    
    /// 当前位置经纬度,为nil时使用updateLocation方法获取最新值
    public  lazy var currentCoordinate = locationManager.location?.coordinate
    
    
}


// MARK: - Method
extension Location {
    
    /// 获取当前位置并回调经纬度
    public func updateLocation(closure:((CLLocationCoordinate2D)->())?) {
        
        guard let coordinate = currentCoordinate else {
            
            locationManager.requestLocation()
            
            locationClosure = closure
            
            return
            
        }
        
        closure?(coordinate)
        
    }
    
}


// MARK: - CLLocationManagerDelegate
extension Location:CLLocationManagerDelegate{
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        locationStatus = status
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let coordinate = locations.last?.coordinate else {
            return
        }
        
        currentCoordinate = coordinate
        
        locationClosure?(coordinate)
        
        locationManager.stopUpdatingLocation()
        
    }
    
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("定位失败")
    }
    
}

