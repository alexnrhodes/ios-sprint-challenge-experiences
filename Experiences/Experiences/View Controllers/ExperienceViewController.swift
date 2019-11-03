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

class ExperienceViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var SavedExperienceButton: UIButton!
    
    let locationManager = CLLocationManager()
    let experienceController = ExperienceController()
    let status = CLLocationManager.authorizationStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "ExperienceView")

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
        addAnnotation()
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
    
    func addAnnotation() {
        let annotation = MKPointAnnotation()
        guard let coordinate = experienceController.currentExperience?.coordinate, let title = experienceController.currentExperience?.experienceTitle else {return}
    
        annotation.title = title
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
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

extension ExperienceViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let experience = annotation as? Experience else { return nil }
        
         let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "ExperienceView", for: experience) as? MKMarkerAnnotationView
        annotationView?.glyphText = experience.experienceTitle
               annotationView?.glyphTintColor = .gray
               annotationView?.titleVisibility = .visible
        
        return annotationView
    }
}
