//
//  MapViewController.swift
//  ImHungry
//
//  Created by ShaoTianchi on 14-7-5.
//  Copyright (c) 2014年 rainbow. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet var mapView : MKMapView
    
    override func viewDidLoad() {
        mapView.delegate = self
    }
    
    func showNav(){
        self.navigationController.setNavigationBarHidden(false,animated: true)
    }
    
    var isLocated :Bool = false
    
    func findRestaurants(region:MKCoordinateRegion){
        var localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = "吃饭"
        localSearchRequest.region = region
        var localSearch = MKLocalSearch(request: localSearchRequest);
        localSearch.startWithCompletionHandler({(response:MKLocalSearchResponse!, error:NSError!) -> Void in
            if error {
                println(error)
            }else {
                dispatch_async(dispatch_get_main_queue(), {
                    let randomIndex = arc4random() % UInt32(response.mapItems.count)
                    let mapItem = response.mapItems[Int(randomIndex)] as MKMapItem
                    var annotation:MKPointAnnotation = MKPointAnnotation()
                    annotation.coordinate = mapItem.placemark.location.coordinate
                    annotation.title = mapItem.name
                    self.mapView.addAnnotation(annotation)
                    //show nav
                    self.title = mapItem.name
                    let delayTime = Int64(Double(2.0)*Double(NSEC_PER_SEC))
                    let popTime = dispatch_time(DISPATCH_TIME_NOW, delayTime );
                    dispatch_after(popTime, dispatch_get_main_queue(), {self.showNav()})
                })
            }
        })
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!){
        if !isLocated {
            self.isLocated = true
            let location: CLLocationCoordinate2D = userLocation.coordinate
            let region = MKCoordinateRegionMakeWithDistance(location, 650, 650);
            mapView.setRegion(region,animated: true);
            self.findRestaurants(region)
        }
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!){
        println(view.annotation.title)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!{
        let userLocation = mapView.userLocation as MKAnnotation
        var annotationView : MKAnnotationView!
        if annotation.isEqual(userLocation) {
           println("user location")
        }else{
            let AnnotationIdentifier = "location"
            annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(AnnotationIdentifier)
            if !annotationView {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: AnnotationIdentifier)
            }
            
            (annotationView as MKPinAnnotationView).animatesDrop = true;
            annotationView.canShowCallout = true;
            
            if !annotationView.viewWithTag(10109) {
                var goBtn = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
                goBtn.tag = 10109
                annotationView.rightCalloutAccessoryView = goBtn
                goBtn.addTarget( self,  action: "goToShop", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
        
        return annotationView
    }
    
    func goToShop(){
        println("go to shop")
    }

}
