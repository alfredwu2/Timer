//
//  ViewController.swift
//  Timer
//
//  Created by Alfred Wu on 6/20/17.
//  Copyright © 2017 Alfred Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var display: [UILabel]!
    @IBOutlet weak var totalDisplay: UILabel!
    @IBOutlet var startButton: [UIButton]!
    
    
    var time = [0, 0, 0]
    var isRunning = [false, false, false]
    var timer = [Timer(), Timer(), Timer()]
    
    var startTime = [NSDate(), NSDate(), NSDate()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDisplay()
    }

    func tick0() {
        if isRunning[0] == true {
            //time[0] += 1
            time[0] = Int(NSDate(timeIntervalSinceNow: 0).timeIntervalSinceReferenceDate - startTime[0].timeIntervalSinceReferenceDate)
        }
        updateDisplay()
    }
    
    func tick1() {
        if isRunning[1] == true {
            //time[1] += 1
            time[1] = Int(NSDate(timeIntervalSinceNow: 0).timeIntervalSinceReferenceDate - startTime[1].timeIntervalSinceReferenceDate)
        }
        updateDisplay()
    }
    
    func tick2() {
        if isRunning[2] == true {
            //time[2] += 1
            time[2] = Int(NSDate(timeIntervalSinceNow: 0).timeIntervalSinceReferenceDate - startTime[2].timeIntervalSinceReferenceDate)
        }
        updateDisplay()
    }
    
    func runTimer(_ tag: Int) {
        
        startTime[tag] = NSDate(timeIntervalSinceNow: -Double(time[tag]))
        
        var select: Selector
        switch tag {
        case 0:
            select = (#selector(ViewController.tick0))
        case 1:
            select = (#selector(ViewController.tick1))
        case 2:
            select = (#selector(ViewController.tick2))
        default:
            select = (#selector(ViewController.tick0))
        }
        timer[tag] = Timer.scheduledTimer(timeInterval: 1, target: self, selector: select, userInfo: nil, repeats: true)
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isRunning[sender.tag] == false {
            runTimer(sender.tag)
            isRunning[sender.tag] = true
            sender.setTitle("Pause", for: .normal)
        } else {
            timer[sender.tag].invalidate()
            isRunning[sender.tag] = false
            sender.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer[sender.tag].invalidate()
        time[sender.tag] = 0
        isRunning[sender.tag] = false
        for button in startButton {
            if button.tag == sender.tag {
                button.setTitle("Start", for: .normal)
            }
        }
        updateDisplay()
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        time[sender.tag] -= 60
        if time[sender.tag] < 0 {
            time[sender.tag] = 0
        }
        
        timer[sender.tag].invalidate()
        runTimer(sender.tag)
        
        updateDisplay()
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        time[sender.tag] += 60
        
        timer[sender.tag].invalidate()
        runTimer(sender.tag)
        
        updateDisplay()
    }
    
    
    private func updateDisplay() {
        //timeDisplay.text = format(time)
     
        for label in self.display {
            label.text = format(time[label.tag])
        }
        
        var totalTime = 0
        for time in time {
            totalTime += time
        }
        
        totalDisplay.text = format(totalTime)
    }
    
    private func format(_ time: Int) -> String {
        let hours = time / 3600
        let minutes = time / 60 % 60
        let seconds = time % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
}

