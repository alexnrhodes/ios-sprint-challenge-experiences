//
//  ExperienceController.swift
//  Experiences
//
//  Created by Alex Rhodes on 11/1/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation
import MapKit

class ExperienceController {
    
    static let shared = ExperienceController()
    
    var currentExperience: Experience?
    
    var experiences: [Experience] = []
    
    func addExperience(audio: URL?, video: URL?, image: UIImage, coordinate: CLLocationCoordinate2D, title: String) {
        
        let experience = Experience(experienceTitle: title, coordinate: coordinate, audio: audio, video: video, image: image)
        experiences.append(experience)
        self.currentExperience = experience
    }
}
