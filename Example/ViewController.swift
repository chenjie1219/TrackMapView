//
//  ViewController.swift
//  Example
//
//  Created by Jason on 2020/4/9.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit
import MapKit
import TrackMapView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mapView = view as! TrackMapView
        
        let coordinates = [
        CLLocationCoordinate2D(latitude: 39.855539, longitude: 116.119037),
        CLLocationCoordinate2D(latitude: 39.88539, longitude: 116.250285),
        CLLocationCoordinate2D(latitude: 39.805479, longitude: 116.180859),
        CLLocationCoordinate2D(latitude: 39.788467, longitude: 116.226786),
        CLLocationCoordinate2D(latitude: 40.001442, longitude: 116.353915),
        CLLocationCoordinate2D(latitude: 39.989105, longitude: 116.360200)]
        
        mapView.drawPolyLine(coordinates: coordinates, color: .red, startImage: #imageLiteral(resourceName: "icon_start"), endImage: #imageLiteral(resourceName: "icon_end"))
    }


}

