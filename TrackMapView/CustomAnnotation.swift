//
//  HBAnnotation.swift
//  HBMapVIew
//
//  Created by Jason on 2020/4/9.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject,MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    var image:UIImage?
    
    init(coordinate:CLLocationCoordinate2D,image:UIImage? = nil) {
        
        self.coordinate = coordinate
        
        self.image = image
        
        super.init()
    }

    
    
}
