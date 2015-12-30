//
//  ViewController.swift
//  KittyMapper
//
//  Created by Siddhartha Gupta on 12/28/15.
//
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
//    @IBOutlet weak var copyright: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
//        let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
//            longitude: 151.20, zoom: 6)
//        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
//        mapView.myLocationEnabled = true
//        self.view = mapView
//        
//        copyright.text = "KittyMapper©"
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
         if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.settings.indoorPicker = false;

         }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
    }
}

extension ViewController: GMSMapViewDelegate {
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Pop"];
        let vc = storyboard.instantiateViewControllerWithIdentifier("ColonyPopoverController") as! ColonyPopoverController
        vc.modalPresentationStyle = .Popover
        vc.preferredContentSize = CGSizeMake(200, 150)
        
        if let popoverController = vc.popoverPresentationController {
            popoverController.delegate = self
            popoverController.sourceRect = CGRectMake(100, 150, 20, 10)
            popoverController.sourceView = self.view
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
        
        
    }

}

