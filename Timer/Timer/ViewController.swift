//
//  ViewController.swift
//  Timer
//
//  Created by Alfred Wu on 6/20/17.
//  Copyright © 2017 Alfred Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var time = 0
    var isRunning = false
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDisplay()
    }

    func tick() {
        time += 1
        updateDisplay()
    }

    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.tick)), userInfo: nil, repeats: true)
    }
   
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isRunning == false {
            runTimer()
            isRunning = true
            sender.setTitle("Pause", for: .normal)
        } else {
            timer.invalidate()
            isRunning = false
            sender.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        time = 0
        timer.invalidate()
        isRunning = false
        timeDisplay.text = format(time)
        startButton.setTitle("Start", for: .normal)
    }

    @IBAction func minusButtonTapped(_ sender: Any) {
        time -= 60
        if time < 0 {
            time = 0
        }
        updateDisplay()
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        time += 60
        updateDisplay()
    }
    
    private func updateDisplay() {
        timeDisplay.text = format(time)
    }
    
    private func format(_ time: Int) -> String {
        let hours = time / 3600
        let minutes = time / 60 % 60
        let seconds = time % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
}

