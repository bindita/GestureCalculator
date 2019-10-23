//
//  ViewController.swift
//  calculator
//
//  Created by Mac on 14/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate, UIGestureRecognizerDelegate {
    
    //@IBOutlet weak var imginput: UIImageView!
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        synthesizer.delegate = self
        //imginput.isUserInteractionEnabled = true
        //button.addTarget(self, action: #selector(ViewController.touchDownEvent(_:)), for: .touchDown)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        //print("Speech finished")
        /*let date = Date()
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let nanosec = calendar.component(.nanosecond, from: date)
        let totalsecs = Double(((hours*60 + minutes)*60 + seconds)*1000 + Int(nanosec/1000000)) / 1000
        print("a_"+timestamp+":"+String(totalsecs))*/
    }
    
    // Handle device shaking
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?){
        //super.motionEnded()
        if event?.subtype == UIEventSubtype.motionShake{
            printTimestamp("S:")
            //timestamp = "S"
            speaktext(inputlabel.text!)
        }
    }
    
    //@IBOutlet weak var delete: UIButton!
    @IBOutlet weak var numberlabel: UILabel!
    @IBOutlet weak var inputlabel: UILabel!
    
    //var operation = true
    var op = ""
    //var number1 : Double?
    var textnumber = ""
    var text_to_display = ""
    var number1 = "" //: Double? = 0
    var number2 = ""
    //var timestamp = ""
    
    let formatter = DateFormatter()
    //var textLog = TextLog()
    
    let audiorate = 0.6
    
    //appending number to label
    func Addnumberfunc(number:String)
    {
        printTimestamp(number+":")
        //timestamp = number
        speaktextwithoutdelay(number)
        textnumber = textnumber + number
        text_to_display = text_to_display + number
        displayinput(text_to_display)
    }
    
    // making number negative
    @IBAction func some(_ sender: Any) {
        printTimestamp("+/-:")
        //var textnum = String(numberlabel.text!)
        textnumber = textnumber + "-"
        text_to_display = text_to_display + "-"
        displayinput(text_to_display)
        //numberlabel.text = textnum
        //operation = true
        //speaktext("minus")
    }
    
    //delete button action
    @IBAction func deleteaction(_ sender: Any) {
        printTimestamp("D:")
        //timestamp = "D"
        speaktextwithoutdelay("delete")
        if !text_to_display.isEmpty{
            speaktextwithdelay(String(text_to_display.last!))
            //if text_to_display.suffix(1) == op{
            if !op.isEmpty && text_to_display.last! == op.last!{
                op.remove(at: op.index(before: op.endIndex))//op = ""
            }
            else if textnumber.isEmpty{
                number1.remove(at: number1.index(before: number1.endIndex))
            }
            else{
                textnumber.remove(at: textnumber.index(before: textnumber.endIndex))
            }
            text_to_display.remove(at: text_to_display.index(before: text_to_display.endIndex))
            displayinput(text_to_display)
        }
    }
    
    // clear button
    @IBAction func clear(_ sender: Any) {
        printTimestamp("C:")
        //timestamp = "C"
        speaktextwithoutdelay("clear")
        //print("text:"+inputlabel.text!)
        inputlabel.text = ""
        numberlabel.text = "0"
        number1 = ""
        number2 = ""
        textnumber = ""
        op = ""
        text_to_display = ""
    }
    
    // mathematical operations
    @IBAction func plus(_ sender: Any) {
        printTimestamp("+:")
        //timestamp = "+"
        speaktextwithoutdelay("add")
        op += "+"
        number1 = number1 + textnumber
        textnumber = ""
        text_to_display = text_to_display + op
        displayinput(text_to_display)
    }
    
    @IBAction func minus(_ sender: Any) {
        printTimestamp("-:")
        //timestamp = "-"
        if textnumber.isEmpty{ //&& !op.isEmpty {
            speaktextwithoutdelay("minus")
            textnumber = textnumber + "-"
            text_to_display = text_to_display + "-"
            displayinput(text_to_display)
        }
        else{
            speaktextwithoutdelay("subtract")
            op += "-"
            number1 = number1 + textnumber
            textnumber = ""
            text_to_display = text_to_display + op
            displayinput(text_to_display)
        }
    }
    
    @IBAction func mul(_ sender: Any) {
        printTimestamp("*:")
        //timestamp = "*"
        speaktextwithoutdelay("multiply")
        op += "*"
        number1 = number1 + textnumber
        textnumber = ""
        text_to_display = text_to_display + op
        displayinput(text_to_display)
    }
    
    @IBAction func divide(_ sender: Any) {
        printTimestamp("/:")
        //timestamp = "/"
        speaktextwithoutdelay("divide")
        op += "/"
        number1 = number1 + textnumber
        textnumber = ""
        text_to_display = text_to_display + op
        displayinput(text_to_display)
    }
    
    @IBAction func eqauls(_ sender: Any) {
        printTimestamp("=:")
        //timestamp = "="
        speaktextwithoutdelay("equals")
        var result:Double?
        if (op.isEmpty || textnumber.isEmpty){
            result = 0
        }
        else{
            number2 = textnumber//Double(numberlabel.text!)
            let num1 = Double(number1)
            let num2 = Double(number2)
            if (num1 != nil && num2 != nil){
                switch op {
                    case "*":
                        result = num1! * num2!
                    case "/":
                        result = num1! / num2!
                    case "-":
                        result = num1! - num2!
                    case "+":
                        result = num1! + num2!
                    default:
                        result = 0
                }
            }
            else{
                result = 0
            }
        }
        result = round(1000*result!) / 1000
        speaktextwithdelay(String(result!))
        numberlabel.text = String(result!)
        //print("text:"+inputlabel.text!)
        number1 = ""
        number2 = ""
        textnumber = ""
        op = ""
        text_to_display = ""
    }
    
    // digits and decimal point
    @IBAction func dot(_ sender: Any) {
        printTimestamp(".:")
        //timestamp = "."
        speaktextwithoutdelay("point")
        textnumber = textnumber + "."
        text_to_display = text_to_display + "."
        displayinput(text_to_display)
    }
    
    @IBAction func zero(_ sender: Any) {
        Addnumberfunc(number: "0")
    }
    
    @IBAction func one(_ sender: Any) {
        Addnumberfunc(number: "1")
    }
    
    @IBAction func two(_ sender: Any) {
        Addnumberfunc(number: "2")
    }
    
    @IBAction func three(_ sender: Any) {
        Addnumberfunc(number: "3")
    }
    
    @IBAction func four(_ sender: Any) {
        Addnumberfunc(number: "4")
    }
    
    @IBAction func five(_ sender: Any) {
        Addnumberfunc(number: "5")
    }
    
    @IBAction func six(_ sender: Any) {
        Addnumberfunc(number: "6")
    }
    
    @IBAction func seven(_ sender: Any) {
        Addnumberfunc(number: "7")
    }
    
    @IBAction func eight(_ sender: Any) {
        Addnumberfunc(number: "8")
    }
    
    @IBAction func nine(_ sender: Any) {
        Addnumberfunc(number: "9")
    }
    
    func displayinput(_ str: String){
        inputlabel.text = str
    }
    
    func printTimestamp(_ str: String){
        /*formatter.timeStyle = .medium
        formatter.dateStyle = .short
        let date = Date()
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let nanosec = calendar.component(.nanosecond, from: date)
        let totalsecs = Double(((hours*60 + minutes)*60 + seconds)*1000 + Int(nanosec/1000000)) / 1000
        //let timestamp = str+" "+String(hours)+"."+String(minutes)+"."+String(seconds)+"."+String(nanosec)
        print(str+String(totalsecs))*///,to: &logger)
    }
    
    func speaktext(_ str: String){
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = Float(audiorate)
        //utterance.volume = 0.0
        synthesizer.speak(utterance)
    }
    func speaktextwithoutdelay(_ str: String){
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = Float(audiorate)
        utterance.volume = 0.0
        synthesizer.speak(utterance)
    }
    func speaktextwithdelay(_ str: String){
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = Float(audiorate)
        DispatchQueue.main.asyncAfter(deadline: .now() + (0.35/audiorate)) { // 1 sec delay
            
        }
        synthesizer.speak(utterance)
    }
    
}
