//
//  ViewController.swift
//  SliderSet
//
//  Created by 張仕錦 on 2019/3/20.
//  Copyright © 2019 AppsMike. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var wordNumberLabel: UILabel!
    @IBOutlet weak var wordSizeLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var gradualLabel: UILabel!
    
    @IBOutlet weak var wordSizeSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var voiceSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var frameSlider: UISlider!
    @IBOutlet weak var gradualSlider: UISlider!
    
    @IBOutlet weak var redSwitch: UISwitch!
    @IBOutlet weak var greenSwitch: UISwitch!
    @IBOutlet weak var blueSwitch: UISwitch!
    
    @IBOutlet weak var gradualBackground: UIImageView!
    @IBOutlet weak var snowImage: UIImageView!
    @IBOutlet weak var boyImage: UIImageView!
    @IBOutlet weak var foxImage: UIImageView!
    
    @IBOutlet weak var textFieldWord: UITextField!
    
    //點畫面空白處讓鍵盤收回
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //點畫面空白處讓鍵盤收回
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
    
    //讓文字輸入框的字數顯示在label
    @IBAction func textNumber(_ sender: UITextField) {
        if sender.text?.count == nil {
            wordNumberLabel.text = "0"
        } else {
            wordNumberLabel.text = String(sender.text!.count)
        }
    }
    
    //控制字體大小且顯示在Label
    @IBAction func wordSizeAction(_ sender: UISlider) {
        textFieldWord.font = textFieldWord.font?.withSize(CGFloat(sender.value*30))
        wordSizeLabel.text = String(format: "%.2f", wordSizeSlider.value*30)
    }
    
    //G.R.B.Alpha的Slider且顯示在Label且顯示在Label
    @IBAction func changeSlider(_ sender: UISlider) {
        snowImage.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
        if sender == redSlider || sender == greenSlider || sender == blueSlider{
            redLabel.text = String(format: "%.2f", redSlider.value)
            greenLabel.text = String(format: "%.2f", greenSlider.value)
            blueLabel.text = String(format: "%.2f", blueSlider.value)
        }
    }
    
    //G.R.B開關
    @IBAction func switchAtion(_ sender: UISwitch) {
        if redSwitch.isOn{
            redSlider.isEnabled = false
        }else{
            redSlider.isEnabled = true
        }
        
        if greenSwitch.isOn{
            greenSlider.isEnabled = false
        }else{
            greenSlider.isEnabled = true
        }
        
        if blueSwitch.isOn{
            blueSlider.isEnabled = false
        }else{
            blueSlider.isEnabled = true
        }
    }
    
    //邊框Slider
    @IBAction func frameSliderAction(_ sender: UISlider) {
        snowImage.layer.borderColor = UIColor.black.cgColor
        snowImage.layer.borderWidth = CGFloat(10*frameSlider.value)
    }
    
    
    //漸層Slider 移動距離 說話
    @IBAction func gradualSliderAction(_ sender: UISlider) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradualBackground.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.blue.cgColor ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        let locationNum = round(20*gradualSlider.value)/10
        gradientLayer.locations = [0.0,NSNumber(value: locationNum)]
        gradualBackground.layer.addSublayer(gradientLayer)
        
        
        //移動距離
        boyImage.frame.origin.x = CGFloat(12 + 65 * gradualSlider.value)
        foxImage.frame.origin.x = CGFloat(311 - 105 * gradualSlider.value)
        
        //說話
        if gradualSlider.value == 1{
            let speechUtterance = AVSpeechUtterance(string: textFieldWord.text!)
            let synthesizer = AVSpeechSynthesizer()
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
            speechUtterance.pitchMultiplier = voiceSlider.value
            speechUtterance.rate = speedSlider.value
            synthesizer.speak(speechUtterance)
        }
    }
    
    //隨機Button
    @IBAction func randomButton(_ sender: UIButton) {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        let alpha = Double.random(in: 0...1)
        let frame = Double.random(in: 0...1)
        snowImage.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        snowImage.layer.borderColor = UIColor.black.cgColor
        snowImage.layer.borderWidth = CGFloat(10*frame)
        redLabel.text = String(format:"%.2f", red)
        greenLabel.text = String(format:"%.2f", green)
        blueLabel.text = String(format:"%.2f", blue)
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        alphaSlider.value = Float(alpha)
        frameSlider.value = Float(frame)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snowImage.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
        redSlider.isEnabled = false
        greenSlider.isEnabled = false
        blueSlider.isEnabled = false
        snowImage.layer.borderColor = UIColor.black.cgColor
        snowImage.layer.borderWidth = CGFloat(10*frameSlider.value)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradualBackground.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.blue.cgColor ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        let locationNum = round(40*gradualSlider.value)/10
        gradientLayer.locations = [0.0,NSNumber(value: locationNum)]
        gradualBackground.layer.addSublayer(gradientLayer)
    }
}

