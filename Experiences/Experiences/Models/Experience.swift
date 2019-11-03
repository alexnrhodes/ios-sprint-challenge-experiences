//
//  Experience.swift
//  Experiences
//
//  Created by Alex Rhodes on 11/1/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation
import MapKit

class Experience: NSObject, MKAnnotation {
    
    let experienceTitle: String
    let coordinate: CLLocationCoordinate2D
    let audio: URL?
    let video: URL?
    let image: URL?
    
    init(experienceTitle: String, coordinate: CLLocationCoordinate2D, audio: URL?, video: URL?, image: URL?) {
        self.experienceTitle = experienceTitle
        self.coordinate = coordinate
        self.audio = audio
        self.video = video
        self.image = image
    }
    
    
}
