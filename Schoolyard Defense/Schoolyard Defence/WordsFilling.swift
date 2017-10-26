//
//  WordsFilling.swift
//  Schoolyard Defence
//
//  Created by Qi Liu on 10/29/16.
//  Copyright © 2016 wei. All rights reserved.
//

import UIKit
import AVFoundation

class WordsFilling: UIViewController, UITextFieldDelegate {
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var monsterImage: UIImageView!
    @IBOutlet weak var cannonImage: UIImageView!
    @IBOutlet weak var charStack: UIStackView!
    @IBOutlet weak var space1: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordsImage: UIImageView!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var stepsLabel: UILabel!
    
    var charsTextField = [UITextField]()
    
    let wordsList = ["apple", "gloves", "banana","hammer", "television",
                     "belt","saw","bicycle","bus","car","shoes","train","drill",
                     "cow","deer","elephant","giraffe","hat","lion","spoon",
                     "microwave","nail","oven","pear","pineapple","socks",
                     "tiger","zebra","fork","ambulance"]
    var wordsIndex = 0
    //var count = 0
    var score = 0
    var steps = 5
    var bearPositon: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultImage.alpha = 0
        stepsLabel.text = "\(steps)"
        //bear animation
        var monsterImageName = ["bear1","bear2","bear3","bear4","bear5","bear6",
                                "bear7","bear8","bear9","bear10","bear11","bear12",
                                "bear13","bear14","bear15","bear16","bear17"]
        var mImages = [UIImage]()
        for i in 0..<monsterImageName.count{
            mImages.append(UIImage(named: monsterImageName[i])!)
        }
        //cannon animation
        var cannonImageName = ["cannon1","cannon2","cannon3","cannon4","cannon5","cannon6",
                               "cannon7","cannon8","cannon9","cannon10","cannon11","cannon12",
                               "cannon13","cannon14","cannon15","cannon16","cannon17","cannon18",
                               "cannon19"]
        var cImages = [UIImage]()
        for i in 0..<cannonImageName.count{
            cImages.append(UIImage(named: cannonImageName[i])!)
        }
        
        cannonImage.animationImages = cImages
        cannonImage.animationDuration = 1
        
        monsterImage.animationImages = mImages
        monsterImage.animationDuration = 2.0
        monsterImage.startAnimating()
        
        space1.delegate = self
        space1.delegate = self
        space1.alpha = 0
        
        let char0 = UITextField()
        let char1 = UITextField()
        let char2 = UITextField()
        let char3 = UITextField()
        let char4 = UITextField()
        let char5 = UITextField()
        let char6 = UITextField()
        let char7 = UITextField()
        let char8 = UITextField()
        let char9 = UITextField()
        
        charsTextField.append(char0)
        charsTextField.append(char1)
        charsTextField.append(char2)
        charsTextField.append(char3)
        charsTextField.append(char4)
        charsTextField.append(char5)
        charsTextField.append(char6)
        charsTextField.append(char7)
        charsTextField.append(char8)
        charsTextField.append(char9)
        
        for i in 0..<charsTextField.count{
            charsTextField[i].delegate = self
            charsTextField[i].borderStyle = space1.borderStyle
            charsTextField[i].returnKeyType = UIReturnKeyType.done
            charsTextField[i].font = UIFont(name: space1.font!.fontName, size: 18)
            charsTextField[i].textAlignment = space1.textAlignment
            charsTextField[i].frame.size.width = 3.0
        }
        
        updateImage()
        
        self.charStack.removeArrangedSubview(space1)
    }
    
    func updateImage(){
        let str = wordsList[wordsIndex]
        wordsImage.image = UIImage(named: wordsList[wordsIndex])
        let charArray = Array(str.characters)
        let arrayIndex = charArray.count
        for i in 0..<arrayIndex{
            self.charStack.addArrangedSubview(charsTextField[i])
        }
        let rd = Int(arc4random_uniform(UInt32(arrayIndex)))
        let str2 = String((charArray[rd]))
        charsTextField[rd].text = str2.capitalized
    }
    
    func resetTextField(){
        //resultImage.alpha = 0
        let str = wordsList[wordsIndex]
        let charArray = Array(str.characters)
        let arrayIndex = charArray.count
        for i in 0..<arrayIndex{
            charsTextField[i].text = ""
            self.charStack.removeArrangedSubview(charsTextField[i])
        }
    }
    
    @IBAction func doneTouched(_ sender: UIButton) {
        let str = wordsList[wordsIndex]
        let charArray = Array(str.characters)
        let arrayIndex = charArray.count
        var resultStr = ""
        for i in 0..<arrayIndex{
            if let ch = charsTextField[i].text{
            resultStr.append(ch)
            }
        }
        if resultStr.capitalized == wordsList[wordsIndex].capitalized{
            self.resultImage.alpha = 1
            UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions(), animations: {
                self.resultImage.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.resultImage.image = UIImage(named: "correct")}, completion: {finished in
                    UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions(), animations: {
                        self.resultImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.resultImage.alpha = 0}, completion: nil)})
            score += 10
            scoreLabel.text = "Score: " + "\(score)"
            playAudio("cannon")
            cannonImage.animationRepeatCount = 1
            cannonImage.startAnimating()
            if(steps < 5){
                bearBackward()
                steps += 1;
            }
            if(steps > 5){
                steps = 4
            }
            stepsLabel.text = "\(steps)"
            resetTextField()
            wordsIndex += 1
            if wordsIndex == wordsList.count{
                win()
                return
            }
            updateImage()
        }else{
            playAudio("cowmoo")
            bearForward()
            steps -= 1
            if(steps == 0){
                gameOver()
            }
            stepsLabel.text = "\(steps)"
            self.resultImage.alpha = 1
            UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions(), animations: {
                self.resultImage.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.resultImage.image = UIImage(named: "wrong")}, completion: {finished in
                    UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions(), animations: {
                        self.resultImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.resultImage.alpha = 0}, completion: nil)})
        }
        
    }
    
    func bearForward(){
        UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions(), animations: {
            self.monsterImage.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            }, completion: { finished in
                UIView.animate(withDuration: 1.0, delay: 1.0, options: UIViewAnimationOptions(), animations: {
                    self.monsterImage.transform = CGAffineTransform(translationX: self.view.bounds.width/4, y: 0)
                    //self.monsterImage.center.x -= 20
                    }, completion: { finished in
                        UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions(), animations: {
                            self.monsterImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)}, completion: nil)
                })
        })
    }
    func bearBackward(){
        UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions(), animations: {
            self.monsterImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }, completion: { finished in
                UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions(), animations: {
                    self.monsterImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)}, completion: nil)})}
    
    func gameOver(){
        let alert = UIAlertController(title: "GamerOver", message: "Your score is \(score)", preferredStyle: UIAlertControllerStyle.alert)
        let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
            {action in
                self.score = 0
                self.steps = 5
                self.scoreLabel.text = "Score: " + "\(self.score)"
                self.resetTextField()
                self.wordsIndex = 0
                self.updateImage()
                self.stepsLabel.text = "\(self.steps)"
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: {
            self.playAudio("gameover")
        })
    }
    func win(){
        let alert = UIAlertController(title: "You Win!", message: "Your score is \(score), next level coming soon!", preferredStyle: UIAlertControllerStyle.alert)
        let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
            {action in
                self.score = 0
                self.steps = 5
                self.scoreLabel.text = "Score: " + "\(self.score)"
                self.wordsIndex = 0
                self.resetTextField()
                self.updateImage()
                self.stepsLabel.text = "\(self.steps)"
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: {
            self.playAudio("cheering")
        })

        
    }
    //hint costs 5 score
    @IBAction func hint(_ sender: UIBarButtonItem) {
        playAudio("button")
        var str = ""
        if score > 0{
            str = wordsList[wordsIndex]
            score -= 5
            scoreLabel.text = "\(score)"
            if score < 0{
                score = 0
            }
        }else{
            str = "A hint costs 5 score, you do not have enough score!"
        }
        let alert=UIAlertController(title: "Hint", message: str, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction=UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let len = (textField.text?.characters.count ?? 0) + string.characters.count - range.length
        let isfilled = len <= 1
        if len == 1 {
            textField.text = string
            textField.resignFirstResponder()
        }
        return isfilled
    }
    
    func playAudio(_ filename :String){
        let audioFilePath = Bundle.main.path(forResource: filename, ofType: "mp3")
        let fileURL = URL(fileURLWithPath: audioFilePath!)
        audioPlayer = try? AVAudioPlayer(contentsOf: fileURL)
        if audioPlayer != nil{
            audioPlayer!.play()
        }
    }

    @IBAction func onTapGestureRecognized(_ sender: UITapGestureRecognizer) {
        
        for i in 0..<charsTextField.count{
            charsTextField[i].resignFirstResponder()
        }
    }
    
}
