//
//  CatMainViewController.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/25.
//

import UIKit
import MapKit

class CatMainViewController: UIViewController {
    
    let transition = CircularTransition()

    @IBOutlet weak var mainMapView: MKMapView!
    @IBOutlet var mainMapViewTapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var pageContainer: UIView!
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(
            x: mainMapView.frame.width - (79 + 48),
            y: mainMapView.frame.height - (79 + 79),
            width: 79,
            height: 79
        )
        button.setImage(UIImage(named: "addButtonImage"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTouchUpInside(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private var addButtonOriginalPosition: CGPoint!
    private var addButtonMovedPosition: CGPoint!
    
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
        
        self.navigationController?.isNavigationBarHidden = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        updatePin()
        
        pageContainer.alpha = 0
        mainMapView.delegate = self
        
        view.addSubview(addButton)
        addButtonOriginalPosition = addButton.frame.origin
        addButtonMovedPosition = addButtonOriginalPosition
        addButtonMovedPosition?.y -= pageContainer.frame.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePin()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func updatePin() {
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
    
    @IBAction func mainMapViewTapGestureRecognizerAction(_ sender: UITapGestureRecognizer) {
        
        guard pageContainer.alpha == 1 else { return }
        
        UIView.animate(withDuration: 0.7) {
            self.pageContainer.alpha = 0
            self.addButton.frame.origin = self.addButtonOriginalPosition
        }
    }
    
    @objc func addButtonTouchUpInside(_ sender: UIButton) {
        let plusVC = UIStoryboard(name: "PlusViewController", bundle: nil).instantiateViewController(withIdentifier: "PlusViewController")
        plusVC.modalPresentationStyle = .custom
        plusVC.transitioningDelegate = self
        present(plusVC, animated: true, completion: nil)
        
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
            self.addButton.frame.origin = self.addButtonMovedPosition
        }
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        guard pageContainer.alpha == 1 else { return }
        
        UIView.animate(withDuration: 0.7) {
            self.pageContainer.alpha = 0
            self.addButton.frame.origin = self.addButtonOriginalPosition
        }
    }
}

extension CatMainViewController: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.transitionMode = .present
    transition.startingPoint = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height - 60)
    transition.circleColor = .white
    return transition
  }
      
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    transition.transitionMode = .dismiss
    transition.startingPoint = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height - 60)
    transition.circleColor = .white
    return transition
  }
}
