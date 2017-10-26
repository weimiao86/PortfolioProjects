//
//  ViewController.swift
//  Schoolyard Defence
//
//  Created by Qi Liu on 10/29/16.
//  Copyright © 2016 wei. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?

    @IBOutlet weak var schoolImage: UIImageView!
    @IBOutlet weak var bearImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var schoolImageName = ["s1.jpg","s2.jpg","s3.jpg","s4.jpg"]
        var schoolImages = [UIImage]()
        
        for i in 0..<schoolImageName.count{
            schoolImages.append(UIImage(named: schoolImageName[i])!)
        }
        
        schoolImage.animationImages = schoolImages
        schoolImage.animationDuration = 1.0
        schoolImage.startAnimating()
        
        var monsterImageName = ["bear1","bear2","bear3","bear4","bear5","bear6",
                                "bear7","bear8","bear9","bear10","bear11","bear12",
                                "bear13","bear14","bear15","bear16","bear17"]
        var mImages = [UIImage]()
        for i in 0..<monsterImageName.count{
            mImages.append(UIImage(named: monsterImageName[i])!)
        }
        
        bearImage.animationImages = mImages
        bearImage.animationDuration = 2.0
        bearImage.startAnimating()
        
        playAudio("maoxiandao")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 3.0, delay: 0.4,
                                   options: [.repeat, .autoreverse], animations: {
                                    self.bearImage.center.x += self.view.bounds.width/4
                                    self.bearImage.transform = CGAffineTransform(scaleX: -1, y: 1)
                                    self.bearImage.center.x -= self.view.bounds.width/2
            }, completion: nil )
    }
    
    @IBAction func goWord(_ sender: UIButton) {
        playAudio("button")
    }
    
    @IBAction func goMath(_ sender: UIButton) {
        playAudio("button")
    }
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        playAudio("maoxiandao")
    }
    
    func playAudio(_ filename :String){
        let audioFilePath = Bundle.main.path(forResource: filename, ofType: "mp3")
        let fileURL = URL(fileURLWithPath: audioFilePath!)
        audioPlayer = try? AVAudioPlayer(contentsOf: fileURL)
        if audioPlayer != nil{
            audioPlayer!.play()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

