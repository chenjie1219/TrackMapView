//
//  HBMapView.swift
//  HBMapVIew
//
//  Created by Jason on 2020/4/8.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

public class TrackMapView: UIView {
    
    /// 大头针复用的identifier
    fileprivate static let annotationId = "annotationId"
    
    fileprivate lazy var mapView:MKMapView = {
        
        let mapView = MKMapView(frame: self.bounds)
        
        mapView.mapType = .mutedStandard
        
        // 是否显示建筑物
        mapView.showsBuildings = true
        
        // 是否显示交通
        mapView.showsTraffic = true
        
        mapView.delegate = self
        
        return mapView
        
    }()
    
    /// 轨迹路径的经纬度数组
    fileprivate lazy var coordinates = [CLLocationCoordinate2D]()
    
    /// 渐变色数组
    fileprivate lazy var lineColor = UIColor()
    
    /// 线条宽度
    fileprivate lazy var lineWidth:CGFloat = 10
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    // 支持storyboard或xib
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        setupUI()
    }
    
    
}


// MARK: - UI
extension TrackMapView {
    
    func setupUI() {
        
        addSubview(mapView)
        
    }
    
}


// MARK: - Method
extension TrackMapView {
    
    /// 绘制轨迹
    public func drawPolyLine(coordinates:[CLLocationCoordinate2D], color:UIColor, width:CGFloat = 10, startImage:UIImage? = nil, endImage:UIImage? = nil) {
        
        if coordinates.isEmpty {
            return
        }
        
        lineColor = color
        
        lineWidth = width
        
        let polyLine = MKPolyline(coordinates: coordinates, count: coordinates.count)
        
        mapView.addOverlay(polyLine)
        
        mapView.centerCoordinate = mapView.caculateCenter(coordinates: coordinates)
        
        mapView.zoomLevel = 10
        
        guard let startImage = startImage,
            let startCoordinate = coordinates.first else {
                return
        }
        
        let startAnnotation = CustomAnnotation(coordinate: startCoordinate, image: startImage)
        
        mapView.addAnnotation(startAnnotation)
        
        guard let endImage = endImage,
            let endCoordinate = coordinates.last else {
                return
        }
        
        let endAnnotation = CustomAnnotation(coordinate: endCoordinate, image: endImage)
        
        mapView.addAnnotation(endAnnotation)
        
    }
    
}



// MARK: - MKMapViewDelegate
extension TrackMapView:MKMapViewDelegate{
    
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            
            let lineRenderer = MKPolylineRenderer(overlay: overlay)
            
            lineRenderer.lineWidth = lineWidth
            
            lineRenderer.strokeColor = lineColor
            
            return lineRenderer
            
        }else{
            
            return MKPolylineRenderer()
        }
    }
    
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: TrackMapView.annotationId)
        
        if annotationView == nil {
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: TrackMapView.annotationId)
            
        }
        
        annotationView?.annotation = annotation
        
        guard let annotation = annotation as? CustomAnnotation else {
            return annotationView
        }
        
        annotationView?.image = annotation.image
        
        annotationView?.centerOffset = CGPoint(x: 0, y: -12)
        
        return annotationView
        
    }
    
}

