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
    @IBOutlet var mainMapViewTapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var switchMapButton: UIButton!
    
    @IBOutlet weak var createFeedButton: UIButton!
    
    @IBOutlet weak var switchFeedButton: UIButton!
    
    @IBOutlet weak var pageContainer: UIView!
    
    private let locationManager = CLLocationManager()
    
    private let mockLocations: [Location] = [
        Location(longitude: 127.033466, latitude: 37.5000868, title: "마켓컬리", subTitle: "MarketKully") // 마켓컬리
        , Location(longitude: 126.895297, latitude: 37.4820956, title: "당근마켓", subTitle: "CarrotMarket") // 당근마켓
        , Location(longitude: 127.044359, latitude: 37.5036694, title: "긱플", subTitle: "GigPlay") // 긱플
        , Location(longitude: 127.025764, latitude: 37.4967280, title: "오늘의집", subTitle: "TodayHouse") // 오늘의 집
    ]
    
    private let spanValue = 0.03
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        for location in mockLocations {
            setPin(location, delta: spanValue, title: location.title, subTitle: location.subTitle)
        }
        
        locationManager.startUpdatingLocation()
        
        if let marketKully = mockLocations.first {
            goLocation(marketKully, delta: spanValue)
        }
        
        pageContainer.alpha = 0
        mainMapView.delegate = self
    }
    
    @discardableResult
    private func goLocation(_ location: Location, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        
        mainMapView.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    private func setPin(_ location: Location, delta span: Double, title: String, subTitle: String) {
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
    
    @IBAction func mainMapViewTapGestureRecognizerAction(_ sender: UITapGestureRecognizer) {
        
        guard pageContainer.alpha == 1 else { return }
        
        UIView.animate(withDuration: 0.7) {
            self.pageContainer.alpha = 0
        }
    }
}

extension CatMainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard
            let pLocation = locations.last,
            let location = mockLocations.first(where: { mock in
                mock.latitude == pLocation.coordinate.latitude && mock.longitude == pLocation.coordinate.longitude
            })
        else {
            return
        }
        
        _ = goLocation(location, delta: spanValue)
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

extension CatMainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard pageContainer.alpha == 0 else { return }
        
        UIView.animate(withDuration: 0.7) {
            self.pageContainer.alpha = 1
        }
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        guard pageContainer.alpha == 1 else { return }
        
        UIView.animate(withDuration: 0.7) {
            self.pageContainer.alpha = 0
        }
    }
}
