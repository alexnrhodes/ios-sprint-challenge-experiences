//
//  AudioPlayer.swift
//  Experiences
//
//  Created by Alex Rhodes on 11/3/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import AVFoundation

protocol PlayerDelegate {
    func playerDidChangeState(player: Player)
}


// AVAudioPlayerDelegate requires a NSObject subclass
class Player: NSObject {
    
    var audioPlayer: AVAudioPlayer?
    var delegate: PlayerDelegate?
    var url: URL?
    var timer: Timer?
    
    var timeElapsed: TimeInterval {
    //        return audioPlayer?.currentTime ?? 0.0
        audioPlayer?.currentTime ?? 0.0
    }

    var duration: TimeInterval {
        audioPlayer?.duration ?? 0.0
    }

    var timeRemaining: TimeInterval {
        duration - timeElapsed
    }
    
    func playRecordedAudio(url: URL) {
        let newUrl = url
        self.url = newUrl
        
      do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("AudioPlayer Error: \(url)")
        }
    }
    
    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
    
    func play() {
        audioPlayer?.play()
        delegate?.playerDidChangeState(player: self)
        startTimer()
    }
    
    func pause() {
        audioPlayer?.pause()
        delegate?.playerDidChangeState(player: self)
        cancelTimer()
    }
    
    func playPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func startTimer() {
        cancelTimer()
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(updateTimer(timer:)), userInfo: nil, repeats: true)
    }

    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func updateTimer(timer: Timer) {
        delegate?.playerDidChangeState(player: self)
    }
    
    // FUTURE: seekToPosition: Double
}

extension Player: AVAudioPlayerDelegate {
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("AVAudioError: \(String(describing: error))")
        cancelTimer()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // send delegate message to update the UI
        delegate?.playerDidChangeState(player: self)
        cancelTimer()
    }
}
