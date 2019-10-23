//
//  ViewController2.swift
//  GestureCalculator
//
//  Created by Bindita Chaudhuri on 10/29/18.
//  Copyright © 2018 Bindita Chaudhuri. All rights reserved.
//

import UIKit
import AVFoundation
import UIKit.UIGestureRecognizerSubclass

import Foundation

@available(iOS 10.0, *)
class ViewController2: UIViewController, AVSpeechSynthesizerDelegate{
    
    let synthesizer = AVSpeechSynthesizer()
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        synthesizer.delegate = self
        
        let SwipeRight1 = UISwipeGestureRecognizer(target: self, action: #selector(self.equalsigngesture))
        SwipeRight1.direction = UISwipeGestureRecognizer.Direction.right
        SwipeRight1.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(SwipeRight1)
        
        let SwipeLeft1 = UISwipeGestureRecognizer(target: self, action: #selector(self.deletegesture))
        SwipeLeft1.direction = UISwipeGestureRecognizer.Direction.left
        SwipeLeft1.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(SwipeLeft1)
        
        let SwipeLeft2 = UISwipeGestureRecognizer(target: self, action: #selector(self.cleargesture))
        SwipeLeft2.direction = UISwipeGestureRecognizer.Direction.left
        SwipeLeft2.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(SwipeLeft2)
        
        let SwipeUp1 = UISwipeGestureRecognizer(target: self, action: #selector(self.digit6gesture))
        SwipeUp1.direction = UISwipeGestureRecognizer.Direction.up
        SwipeUp1.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(SwipeUp1)
        
        let SwipeUp2 = UISwipeGestureRecognizer(target: self, action: #selector(self.plusgesture))
        SwipeUp2.direction = UISwipeGestureRecognizer.Direction.up
        SwipeUp2.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(SwipeUp2)
        
        let SwipeUp3 = UISwipeGestureRecognizer(target: self, action: #selector(self.multiplygesture))
        SwipeUp3.direction = UISwipeGestureRecognizer.Direction.up
        SwipeUp3.numberOfTouchesRequired = 3
        self.view.addGestureRecognizer(SwipeUp3)
        
        let SwipeDown1 = UISwipeGestureRecognizer(target: self, action: #selector(self.digit0gesture))
        SwipeDown1.direction = UISwipeGestureRecognizer.Direction.down
        SwipeDown1.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(SwipeDown1)
        
        let SwipeDown2 = UISwipeGestureRecognizer(target: self, action: #selector(self.minusgesture))
        SwipeDown2.direction = UISwipeGestureRecognizer.Direction.down
        SwipeDown2.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(SwipeDown2)
        
        let SwipeDown3 = UISwipeGestureRecognizer(target: self, action: #selector(self.dividegesture))
        SwipeDown3.direction = UISwipeGestureRecognizer.Direction.down
        SwipeDown3.numberOfTouchesRequired = 3
        self.view.addGestureRecognizer(SwipeDown3)
        
        let decimal = UILongPressGestureRecognizer(target: self, action: #selector(self.decimalgesture))
        decimal.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(decimal)
    }

    var firstgesture : UIGestureRecognizer? = nil
    @IBOutlet weak var inputarea: UILabel!
    @IBOutlet weak var resultarea: UILabel!
    
    var digit3flag = 0
    var digit6flag = 0
    var textnumber = ""
    var text_to_display = ""
    var op = ""
    
    var numbers = [Double]()
    var operators = [Int]()
    
    var counter = 0
    var flag = 0
    var number1 = "" //: Double? = 0
    var number2 = "" //: Double? = 0
    var touchViews = [UITouch:TouchSpotView]()
    var result:Double? = 0
    //var timestamp = ""
    
    let audiorate = 0.6
    
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
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            printTimestamp("S:")
            //timestamp = "S"
            speaktext(text_to_display)
        }
    }
    
    @objc func digit0gesture(sender:UISwipeGestureRecognizer){
        if digit3flag == 0 && digit6flag == 0{
            printTimestamp("0:")
            //timestamp = "0"
            speaktext(String(0))
            appenddigittodisplay(0)
            appenddigittocompute(0)
            displayinput(text_to_display)
        }
        else if digit3flag == 1 && digit6flag == 0{
            printTimestamp("3:")
            //timestamp = "3"
            speaktext(String(3))
            appenddigittodisplay(3)//Double(counter))
            appenddigittocompute(3)
            displayinput(text_to_display)
            digit3flag = 0
        }
        else if digit3flag == 0 && digit6flag == 1{
            printTimestamp("6_v2:")
            //timestamp = "6_v2"
            speaktext(String(6))
            appenddigittodisplay(6)//Double(counter))
            appenddigittocompute(6)
            displayinput(text_to_display)
            digit6flag = 0
        }
    }
    
    @objc func decimalgesture(sender: UILongPressGestureRecognizer){
        if (sender.state == UIGestureRecognizer.State.began){
                generator.impactOccurred()
        }
        else if (sender.state == UIGestureRecognizer.State.ended) {
            printTimestamp(".:")
            //timestamp = "."
            speaktext("point")
            text_to_display += "."
            textnumber += "."
            displayinput(text_to_display)
        }
    }
    
    @objc func digit6gesture(sender:UISwipeGestureRecognizer){
        if (sender.state == UIGestureRecognizer.State.ended){
            digit3flag = 0
            digit6flag = 1
        }
    }
    
    @objc func equalsigngesture(sender:UISwipeGestureRecognizer) {
        if (sender.state == UIGestureRecognizer.State.ended) {
            printTimestamp("=:")
            //timestamp = "="
            speaktextv2("equals")
            if op.isEmpty || textnumber.isEmpty{
                result = 0
            }
            else{
                number2 = textnumber
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
                        case "**":
                        result = pow(num1!, num2!)
                        default:
                        result = 0
                    }
                }
                else{
                    result = 0
                }
            }
            result = round(1000*result!) / 1000
            speaktextv2(String(result!))
            displayresult(String(result!))
            textnumber = ""
            op = ""
            number1 = ""
            number2 = ""
            digit3flag = 0
            digit6flag = 0
            displayinput(text_to_display)
            text_to_display = ""
        }
    }
    
    @objc func deletegesture(sender:UISwipeGestureRecognizer) {
        if (sender.state == UIGestureRecognizer.State.ended) {
            printTimestamp("D:")
            //timestamp = "D"
            if !text_to_display.isEmpty{
                speaktext("delete "+String(text_to_display.last!))
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
            else{
                speaktext("delete")
            }
        }
    }
    
    @objc func cleargesture(sender:UISwipeGestureRecognizer) {
        if (sender.state == UIGestureRecognizer.State.ended) {
            printTimestamp("C:")
            //timestamp = "C"
            speaktext("clear")
            //print("text:"+text_to_display)
            textnumber = ""
            text_to_display = ""
            op = ""
            digit3flag = 0
            digit6flag = 0
            number1 = ""
            number2 = ""
            displayinput(text_to_display)
            displayresult("")
        }
    }
    
    @objc func startovergesture(sender:UISwipeGestureRecognizer) {
        if (sender.state == UIGestureRecognizer.State.ended) {
            printTimestamp("Start:")
            textnumber = String(result!)
            text_to_display = textnumber
            displayinput(text_to_display)
            op = ""
            digit3flag = 0
            digit6flag = 0
            number1 = ""
            number2 = ""
            displayresult("")
            speaktext("start over")
        }
    }
    
    @objc func plusgesture(sender:UISwipeGestureRecognizer){
        printTimestamp("+:")
        //timestamp = "+"
        speaktext("add")
        op += "+"
        number1 = number1 + textnumber
        textnumber = ""
        appendsymbol("+")
        displayinput(text_to_display)
    }
    
    @objc func multiplygesture(sender:UISwipeGestureRecognizer){
        printTimestamp("*:")
        //timestamp = "*"
        speaktext("multiply")
        op += "*"
        number1 = number1 + textnumber
        textnumber = ""
        appendsymbol("*")
        displayinput(text_to_display)
    }
    
    @objc func dividegesture(sender:UISwipeGestureRecognizer){
        printTimestamp("/:")
        //timestamp = "/"
        speaktext("divide")
        op += "/"
        number1 = number1 + textnumber
        textnumber = ""
        appendsymbol("/")
        displayinput(text_to_display)
    }
    
    @objc func minusgesture(sender:UISwipeGestureRecognizer){
        printTimestamp("-:")
        //timestamp = "-"
        if textnumber.isEmpty{ //&& !op.isEmpty {
            speaktext("minus")
            textnumber = textnumber + "-"
            appendsymbol("-")
            displayinput(text_to_display)
        }
        else{
            speaktext("subtract")
            op += "-"
            number1 = number1 + textnumber
            textnumber = ""
            appendsymbol("-")
            displayinput(text_to_display)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchViews.count > 0{
            for key in touchViews.keys {
                let view = touchViews[key]
                view!.removeFromSuperview()
            }
        }
        for touch in touches {
            counter = counter + 1
            createViewForTouch(touch: touch)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let view = viewForTouch(touch: touch)
            // Move the view to the new location.
            let newLocation = touch.location(in: self.view)
            view?.center = newLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
        if touchViews.count == 0{
            if counter == 3 && digit3flag == 0 && digit6flag == 0{
                digit3flag = 1
            }
            else if digit3flag == 1 && digit6flag == 0{
                printTimestamp(String(counter+3)+":")
                //timestamp = String(counter+3)
                appenddigittodisplay(counter+3)
                appenddigittocompute(counter+3)
                displayinput(text_to_display)
                digit3flag = 0
                speaktext(String(counter+3))
            }
            else if digit3flag == 0 && digit6flag == 1{
                printTimestamp(String(counter+6)+":")
                //timestamp = String(counter+6)
                appenddigittodisplay(counter+6)
                appenddigittocompute(counter+6)
                displayinput(text_to_display)
                digit6flag = 0
                speaktext(String(counter+6))
            }
            else{
                printTimestamp(String(counter)+":")
                //timestamp = String(counter)
                appenddigittodisplay(counter)//Double(counter))
                appenddigittocompute(counter)
                displayinput(text_to_display)
                digit3flag = 0
                digit6flag = 0
                speaktext(String(counter))
            }
            counter = 0
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        counter = 0
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
    }
    
    func appendsymbol(_ symbol: String){
        text_to_display += symbol
    }
    
    func appenddigittodisplay(_ number: Int){
        text_to_display += String(number)
    }
    func appenddigittocompute(_ number: Int){
        textnumber += String(number)
    }
    
    func displayinput(_ str: String){
        inputarea.text = "Input: "+str
    }
    func displayresult(_ str: String){
        resultarea.text = "Result: "+str
    }
    
    func printTimestamp(_ str: String){
        /*let date = Date()
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let nanosec = calendar.component(.nanosecond, from: date)
        let totalsecs = Double(((hours*60 + minutes)*60 + seconds)*1000 + Int(nanosec/1000000)) / 1000
        print(str+String(totalsecs))//,to: &logger)*/
        digit3flag = 0
        digit6flag = 0
    }
    
    func speaktext(_ str: String){
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = Float(audiorate)
        synthesizer.speak(utterance)
    }
    func speaktextv2(_ str: String){
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = Float(audiorate)
        synthesizer.speak(utterance)
    }
    
    // Circle area (view creation)
    
    func createViewForTouch( touch : UITouch ) {
        let newView = TouchSpotView()
        newView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        newView.center = touch.location(in: self.view)
        
        // Add the view and animate it to a new size.
        self.view.addSubview(newView)
        //UIView.animate(withDuration: 0.2) {
        //    newView.bounds.size = CGSize(width: 100, height: 100)
        //}
        
        // Save the views internally
        touchViews[touch] = newView
    }
    
    func viewForTouch (touch : UITouch) -> TouchSpotView? {
        return touchViews[touch]
    }
    
    func removeViewForTouch (touch : UITouch ) {
        if let view = touchViews[touch] {
            view.removeFromSuperview()
            touchViews.removeValue(forKey: touch)
        }
    }
}
class TouchSpotView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //isMultipleTouchEnabled = true
        //fatalError("init(coder:) has not been implemented")
    }
    
    // Update the corner radius when the bounds change.
    override var bounds: CGRect {
        get { return super.bounds }
        set(newBounds) {
            super.bounds = newBounds
            layer.cornerRadius = newBounds.size.width / 2.0
        }
    }
}
