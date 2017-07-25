//
//  ViewController.swift
//  PowerNapTimer
//
//  Created by James Pacheco on 4/12/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    let myTimer = MyTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTimer.delegate = self
        setView()
    
    }
    
    func setView() {
        updateTimerLabel()
        // If timer is running, start button title should say "Cancel". If timer is not running, title should say "Start nap"
        if myTimer.isOn {
            startButton.setTitle("Cancel", for: UIControlState())
        } else {
            startButton.setTitle("Start nap", for: UIControlState())
        }
    }
    
    func updateTimerLabel() {
        timerLabel.text = myTimer.timeAsString()
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if myTimer.isOn {
            myTimer.stopTimer()
        } else {
            myTimer.startTimer(3)
        }
        setView()
 }
    // MARK: - UIAlertConroller
    
    func setupAlertController() {
        let alert = UIAlertController(title: "Wake Up!", message: "Wake Up You Lazy Bum!", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { (_) in
            self.setView()
        }
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Timer Delegate

extension ViewController: TimerDelegate {
    func timerSecondTick() {
        updateTimerLabel()
    }
    func timerCompleted() {
        setView()
        // Appear the notification and alertcontroller
        setupAlertController()
    }
    func timerStopped() {
        setView()
        // Cancel notification
    }
}
