//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Julian Currie on 10/8/16.
//  Copyright © 2016 Zombie. All rights reserved.

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var displayLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftString = ""
    var rightString = ""
    var result = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
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
        
        displayLbl.text = "0"
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        displayLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            //User selected multiple operations in a row
            if runningNumber != "" {
                rightString = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                    case Operation.Multiply:
                        result = "\(Double(leftString)! * Double(rightString)!)"
                        break
                    case Operation.Divide:
                        result = "\(Double(leftString)! / Double(rightString)!)"
                        break
                    case Operation.Subtract:
                        result = "\(Double(leftString)! - Double(rightString)!)"
                        break
                    case Operation.Add:
                        result = "\(Double(leftString)! + Double(rightString)!)"
                        break
                    default:
                        break
                }
                
                leftString = result
                displayLbl.text = result
            }
            
            currentOperation = operation
        } else {
            //First Time operator has been pressed
            leftString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

