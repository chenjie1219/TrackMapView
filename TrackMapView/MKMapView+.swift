//
//  MKMapView+.swift
//  Letsfit
//
//  Created by Jason on 2020/4/8.
//  Copyright © 2020 Mac. All rights reserved.
//

import MapKit
 
extension MKMapView {
    
    /// 多经纬度计算中心点
    func caculateCenter(coordinates:[CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
           
           var X=0.0,Y=0.0,Z=0.0
           
           let count:Double = Double(coordinates.count)
           
           coordinates.forEach { (coordinate) in
               let lat = coordinate.latitude * Double.pi / 180
               let lng = coordinate.longitude * Double.pi / 180
               let x = cos(lat) * cos(lng)
               let y = cos(lat) * sin(lng)
               let z = sin(lat)
               X += x
               Y += y
               Z += z
           }
           X = X/count
           Y = Y/count
           Z = Z/count
           
           let Lng = atan2(Y, X)
           
           let Hyp = sqrt(X*X + Y*Y)
           
           let Lat = atan2(Z, Hyp)
           
           return CLLocationCoordinate2D(latitude: Lat * 180 / Double.pi, longitude: Lng * 180 / Double.pi)
    }
    
    
    
    //缩放级别
    var zoomLevel: Int {
        //获取缩放级别
        get {
            return Int(log2(360 * (Double(frame.size.width/256)
                / region.span.longitudeDelta)) + 1)
        }
        //设置缩放级别
        set {
            setCenterCoordinate(zoomLevel: newValue,
                                animated: false)
        }
    }
     
    //设置缩放级别时调用
    private func setCenterCoordinate(zoomLevel: Int,
                                     animated: Bool) {
        let span = MKCoordinateSpan(latitudeDelta: 0,
                                    longitudeDelta: 360 / pow(2, Double(zoomLevel)) * Double(frame.size.width) / 256)
        setRegion(MKCoordinateRegion(center: centerCoordinate, span: span), animated: animated)
    }
}
