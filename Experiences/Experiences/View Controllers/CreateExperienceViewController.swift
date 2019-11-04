//
//  CreateExperienceViewController.swift
//  Experiences
//
//  Created by Alex Rhodes on 11/3/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class CreateExperienceViewController: UIViewController {
    
    var player = Player()
    var recorder = Recorder()

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var recordAudio: UIButton!
    @IBOutlet weak var uploadPhoto: UIButton!
    
    
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
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        recorder.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
//        let playTitle = player.isPlaying ? "Pause" : "Play"
//        playButton.setTitle(playTitle, for: .normal)
        
        let recordTitle = recorder.isRecording ? "Stop Recording" : "Record"
        recordAudio.setTitle(recordTitle, for: .normal)
        
    }
    
    @IBAction func playAudioButtonPressed(_ sender: UIButton) {
        player.playPause()
    }
    
    @IBAction func recordAudioButtonTapped(_ sender: UIButton) {
        recorder.toggleRecording()
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

