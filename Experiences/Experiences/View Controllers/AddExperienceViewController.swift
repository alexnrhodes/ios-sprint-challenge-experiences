//
//  AddExperienceViewController.swift
//  Experiences
//
//  Created by Alex Rhodes on 11/1/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddExperienceViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var SavedExperienceButton: UIButton!
    
    let locationManager = CLLocationManager()
    let experienceController = ExperienceController()
    let status = CLLocationManager.authorizationStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            break
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUsersCurrentLocation()
        //        let annotations = mapView.annotations.compactMap({ $0 as? (Experience)
        //           return $0.coordinate
        //        })
        //        mapView.addAnnotation(annotations)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if locations.first != nil {
            print("location:: (location)")
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        fatalError("Error: \(error)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.requestLocation()
    }
    
    
    func getUsersCurrentLocation() {
        guard let location = locationManager.location?.coordinate else {fatalError()}
        
        let mapViewArea = MKCoordinateRegion(center: location, latitudinalMeters: 13000, longitudinalMeters: 13000)
        mapView.setRegion(mapViewArea, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension AddExperienceViewController: MKMapViewDelegate, CLLocationManagerDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let experience = annotation as? Experience else { return nil }
//    }
}
