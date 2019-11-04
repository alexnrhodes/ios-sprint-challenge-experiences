//
//  CreateExperienceViewController.swift
//  Experiences
//
//  Created by Alex Rhodes on 11/3/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit
import MapKit

class CreateExperienceViewController: UIViewController {
    
    var player = Player()
    var recorder = Recorder()
    var location: CLLocationCoordinate2D?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var recordAudio: UIButton!
    @IBOutlet weak var uploadPhoto: UIButton!
    @IBOutlet weak var saveExperienceButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let experiencController = ExperienceController.shared
    
      private lazy var timeFormatter: DateComponentsFormatter = {
          let formatting = DateComponentsFormatter()
          formatting.unitsStyle = .positional // 00:00  mm:ss
          // NOTE: DateComponentFormatter is good for minutes/hours/seconds
          // DateComponentsFormatter not good for milliseconds, use DateFormatter instead)
          formatting.zeroFormattingBehavior = .pad
          formatting.allowedUnits = [.minute, .second]
          return formatting
      }()
      
      // Gets called when a ViewController is created
      // from storyboard
     
    var originalImage: UIImage?
    
    var scaledImage: UIImage? {
        didSet {
//            updateImage()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        recorder.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        let playTitle = player.isPlaying ? "Pause" : "Play"
        playPauseButton.setTitle(playTitle, for: .normal)
        
        let recordTitle = recorder.isRecording ? "Stop Recording" : "Record"
        recordAudio.setTitle(recordTitle, for: .normal)
    }
    
    @IBAction func saveExperience(_ sender: UIButton) {
        
        guard let audio = recorder.url,
        let location = location,
            let title = titleTextField.text, let image = originalImage else {return}
        
        experiencController.addExperience(audio: audio, video: nil, image: image, coordinate: location, title: title)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playAudioButtonPressed(_ sender: UIButton) {
        player.playPause()
    }
    
    @IBAction func recordAudioButtonTapped(_ sender: UIButton) {
        recorder.toggleRecording()
    }
    
    @IBAction func UploadPhotoButtonTapped(_ sender: UIButton) {
        presentImagePickerController()
    }
    
    private func presentImagePickerController() {
           
           guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
               NSLog("The photo library is not available")
               return
           }
           
           let imagePicker = UIImagePickerController()
           imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
           
           present(imagePicker, animated: true, completion: nil)
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
// MARK: recorder extension

extension CreateExperienceViewController: PlayerDelegate {
    func playerDidChangeState(player: Player) {
        // update the UI
        
        updateViews()
    }
}

extension CreateExperienceViewController: RecorderDelegate {
    func recorderDidChangeState(recorder: Recorder) {
        updateViews()
    }
    
    func recorderDidSaveFile(recorder: Recorder) {
        updateViews()
        
        // TODO: Play the file
        if let url = recorder.url, recorder.isRecording == false {
            // Recording is finished, let's try and play the file
            
            player.playRecordedAudio(url: url)
            player.delegate = self
        }
    }
}

extension CreateExperienceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // get the image
        
        if let image = info[.originalImage] as? UIImage {
            originalImage = image
            imageView.image = image
    
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

