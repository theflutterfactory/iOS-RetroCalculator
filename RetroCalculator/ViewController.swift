//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Julian Currie on 10/8/16.
//  Copyright © 2016 Zombie. All rights reserved.

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

