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
    private var pageController: CatMainPageViewController?
    
    private let model = CatRequestModel()
    
    private let locationManager = CLLocationManager()
    
    private var catData = [CatModel]() {
        didSet {
            for cat in catData {
                setPin(cat, delta: spanValue, title: cat.name, subTitle: cat.description)
            }
        }
    }
    
    private let spanValue = 0.03
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        model.getAllCats { result in
            if let result = result as? [CatModel] {
                self.catData = result
                self.pageController?.reloadPage(self.catData)
            }
        }
        
        locationManager.startUpdatingLocation()
        
        if let cat = catData.first {
            goLocation(cat, delta: spanValue)
        }
        
        pageContainer.alpha = 0
        mainMapView.delegate = self
    }
    
    @discardableResult
    private func goLocation(_ cat: CatModel, delta span: Double) -> CLLocationCoordinate2D {
        
        let latitude = Double(cat.latitude) ?? 0
        let longitude = Double(cat.longitude) ?? 0
        
        let pLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        
        mainMapView.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    private func setPin(_ cat: CatModel, delta span: Double, title: String, subTitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(cat, delta: span)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageController = segue.destination as? CatMainPageViewController {
            self.pageController = pageController
        }
    }
}

extension CatMainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard
            let pLocation = locations.last,
            let location = catData.first(where: { mock in
                Double(mock.latitude) ?? 0.0 == pLocation.coordinate.latitude
                && Double(mock.longitude) ?? 0.0 == pLocation.coordinate.longitude
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
