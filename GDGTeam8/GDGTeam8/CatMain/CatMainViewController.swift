//
//  CatMainViewController.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/25.
//

import UIKit
import MapKit

class CatMainViewController: UIViewController {

    @IBOutlet weak var mainMapView: MKMapView!
    
    @IBOutlet weak var switchMapButton: UIButton!
    
    @IBOutlet weak var createFeedButton: UIButton!
    
    @IBOutlet weak var switchFeedButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mainMapView.showsUserLocation = true
    }
    
    func goLocation(_ location: Location, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        
        mainMapView.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    func setPin(_ location: Location, delta span: Double, title: String, subTitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(location, delta: span)
        annotation.title = title
        annotation.subtitle = subTitle
        mainMapView.addAnnotation(annotation)
    }
    
    @IBAction func switchMapButtonTouchUpInside(_ sender: UIButton) {
    }
    
    @IBAction func createFeedButtonTouchUpInside(_ sender: UIButton) {
    }
    
    @IBAction func switchFeedButtonTouchUpInside(_ sender: UIButton) {
    }
}

extension CatMainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let pLocation = locations.last else { return }
        _ = goLocation(Location(longitude: pLocation.coordinate.longitude, latitude: pLocation.coordinate.latitude), delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation) { placeMarks, error in
            let pm = placeMarks?.first
            
            var address = ""
            
            if let country = pm?.country {
                address = country
            }
            
            if let pmLocality = pm?.locality {
                address += " \(pmLocality)"
            }
            
            if let pmThoroughFare = pm?.thoroughfare {
                address += " \(pmThoroughFare)"
            }
            
            print(address)
        }
        locationManager
            .stopUpdatingLocation()
    }
}
