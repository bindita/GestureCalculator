//
//  ViewController.swift
//  PromptReader
//
//  Created by Bindita Chaudhuri on 3/26/19.
//  Copyright © 2019 Bindita Chaudhuri. All rights reserved.
//

import UIKit
import AVFoundation
import UIKit.UIGestureRecognizerSubclass

import Foundation
struct Log: TextOutputStream {
    func write(_ string: String) {
        let fm = FileManager.default
        let log = fm.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("promptreaderlog.txt")
        //let log = URL(string: fm.currentDirectoryPath + "log.txt")!
        //print(log)
        if let handle = try? FileHandle(forWritingTo: log) {
            handle.seekToEndOfFile()
            handle.write(string.data(using: .utf8)!)
            handle.closeFile()
        } else {
            try? string.data(using: .utf8)?.write(to: log)
        }
    }
}
var logger = Log()

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    let synthesizer = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        synthesizer.delegate = self
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.nextcommandgesture))
        tapgesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapgesture)
        
        let dtapgesture = UITapGestureRecognizer(target: self, action: #selector(self.repeatcommandgesture))
        dtapgesture.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(dtapgesture)
    }
    
    let formatter = DateFormatter()
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        //print("Speech finished")
        let date = Date()
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let nanosec = calendar.component(.nanosecond, from: date)
        let totalsecs = Double(((hours*60 + minutes)*60 + seconds)*1000 + Int(nanosec/1000000)) / 1000
        //let time = Double(Int((totalsecs - start_time)*1000)) / 1000
        print("a_p"+String(prompt_counter)+":"+String(totalsecs))
        let text = expressions_in_speech[exp_counter-1]
        if (text == "equals" || text == "clear"){
            prompt_counter += 1
        }
    }

    // PRACTICE PROMPTS
    let prompts0 =
        ["19","add","45","equals",
        "32.7","clear",
        "60","divide","minus 8","equals",
        "5.05", "subtract", "3", "equals",
        "249", "clear"]

    // PROMPT SET 1
    let prompts1 =
        ["72","add","58","equals",
         "minus 531", "clear",
         "4.9","multiply","7","equals",
         "9","divide","12","equals",
         "309","clear",
         "7","multiply","minus 12","equals",
         "64.8","clear",
         "40","clear",
         "806", "add", "3", "equals",
         "65", "clear",
         //well done!
         "64","divide","2","equals",
         "9.8","add","30","equals",
         "907","clear",
         "minus 85.5","clear",
         "2","multiply","83","equals",
         "79","clear",
         "74","subtract","61","equals",
         "4.05","clear",
         "31","clear",
         "21","divide","6","equals",
         //well done!
         "34.1","clear",
         "6800","clear",
         "48","divide","16","equals",
         "9.7","subtract","7","equals",
         "minus 32","clear",
         "65","add","28","equals",
         "59.2","clear",
         "3","multiply","9","equals",
         "10","divide","4","equals",
         "57","clear"]
    
    // PROMPT SET 2
    let prompts2 =
        ["28","clear",
         "918","add", "6", "equals",
         "80", "clear",
         "43.6", "clear",
         "3", "multiply", "minus 29", "equals",
         "519", "clear",
         "3", "divide", "54", "equals",
         "0.6", "multiply","7", "equals",
         "minus 772", "clear",
         "50", "add", "14", "equals",
         //well done!
         "17","divide", "8", "equals",
         "56", "clear",
         "2.01", "clear",
         "60", "subtract", "40", "equals",
         "99", "clear",
         "3", "multiply", "75", "equals",
         "minus 42.9", "clear",
         "321", "clear",
         "8.4", "add", "38", "equals",
         "76","divide","5", "equals",
         //well done!
         "92","clear",
         "41","divide","5", "equals",
         "5", "multiply", "2", "equals",
         "6.03", "clear",
         "87", "add", "30", "equals",
         "minus 47","clear",
         "8.6", "subtract","9", "equals",
         "63", "divide", "91", "equals",
         "4021", "clear",
         "85.7", "clear"]
    
    // PROMPT SET 3
    let prompts3 =
        ["89","add","15","equals",
        "46","clear",
        "-360","clear",
        "118","add","2","equals",
        "0.4","multiply","2","equals",
        "23","clear",
        "5","divide","35","equals",
        "79.7","clear",
        "748","clear",
        "9","multiply","-60","equals",
        // well done
        "97","divide","3","equals",
        "90","divide","7","equals",
        "4.2","add","70","equals",
        "44","clear",
        "852","clear",
        "6.03","clear",
        "minus 58.3","clear",
        "81","subtract","59","equals",
        "6","multiply","21","equals",
        "16","clear",
        // well done
        "67.8","clear",
        "19","clear",
        "30","divide","2","equals",
        "9207","clear",
        "4","multiply","4","equals",
        "50","divide","66","equals",
        "5.9","subtract","2","equals",
        "83.8","clear",
        "minus 45","clear",
        "71","add","13","equals"]

    //Get reference of UITextView
    @IBOutlet weak var textfield: UITextField!
    
    //Get value of input from UITextView in variable
    //let name: String = textfield.text!
    
    @IBAction func OnTextChange(_ sender: Any) {
        exp_counter = 0
        prompt_counter_old = 1
        prompt_counter = 1
        let num = Int(textfield.text!)
        if (num == 1){
            expressions_in_speech = prompts1
        }
        else if (num == 2){
            expressions_in_speech = prompts2
        }
        else if (num == 3){
            expressions_in_speech = prompts3
        }
        else{
            expressions_in_speech = prompts0
        }
    }
    
    var exp_counter = 0
    var prompt_counter_old = 1
    var prompt_counter = 1
    var start_time = 0.0
    var expressions_in_speech: [String] = [ ]
    
    @objc func nextcommandgesture(sender: UITapGestureRecognizer){
        if (sender.state == UIGestureRecognizer.State.ended){
            if (prompt_counter > prompt_counter_old){
                printTimestamp("end:")
                prompt_counter_old += 1
            }
            printTimestamp("p"+String(prompt_counter)+":")
            if (exp_counter < expressions_in_speech.count){
                let text = expressions_in_speech[exp_counter]
                speaktext(text)
                exp_counter += 1
            }
            else{
                speaktext("Done")
            }
        }
    }
    
    @objc func repeatcommandgesture(sender: UITapGestureRecognizer){
        if (sender.state == UIGestureRecognizer.State.ended){
            speaktext(expressions_in_speech[exp_counter-1])
        }
    }
    
    func speaktext(_ str: String){
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        //utterance.rate = 0.7
        synthesizer.speak(utterance)
        //synthesizer.stopSpeaking(at: .word)
    }
    
    func printTimestamp(_ str: String){
    //func getTimestamp() -> Double{
        //formatter.timeStyle = .medium
        //formatter.dateStyle = .short
        //let toPrint = str + String(CACurrentMediaTime())//formatter.string(from: Date())
        //print(toPrint)
        //textLog.write(toPrint+"\n")
        let date = Date()
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let nanosec = calendar.component(.nanosecond, from: date)
        let totalsecs = Double(((hours*60 + minutes)*60 + seconds)*1000 + Int(nanosec/1000000)) / 1000
        //return totalsecs
        print(str+String(totalsecs))
        print(str+String(totalsecs),to: &logger)
            //+"."+String(minutes)+"."+String(seconds)+"."+String(nanosec))
    }
    
}

