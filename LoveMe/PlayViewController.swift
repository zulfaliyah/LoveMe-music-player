//
//  PlayViewController.swift
//  LoveMe
//
//  Created by Zulfa Aliyah on 30/03/20.
//  Copyright © 2020 Zulfa Aliyah. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var cdView: UIImageView!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var airplayButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    
   
   
    @IBAction func prev(_ sender: Any) {
        if thisSong == 1 {
            playThis(thisOne: songs[thisSong-1])
        } else {
            playThis(thisOne: songs[1])
        }
        label.text = songs[thisSong]
        cdView.image = UIImage(named: picts[thisSong]+".jpg")
        button.setImage(UIImage(named: "pause"), for: .normal)
    }
    
    @IBAction func pause(_ sender: UIButton) {
        if audioPlayer.isPlaying{
            audioPlayer.pause()
            button.setImage(UIImage(named: "play"), for: .normal)
        } else {
            audioPlayer.play()
            button.setImage(UIImage(named: "pause"), for: .normal)
        }
        
    }
    
    @IBAction func next(_ sender: Any) {
        if thisSong < songs.count-1{
            playThis(thisOne: songs[thisSong+1])
        }
        else {
            playThis(thisOne: songs[0])
        }
        label.text = songs[thisSong]
        cdView.image = UIImage(named: picts[thisSong]+".jpg")
        button.setImage(UIImage(named: "pause"), for: .normal)
        
    }
    
    @IBAction func volume(_ sender: UISlider) {
        audioPlayer.volume = sender.value
    }
    
    
    func playThis(thisOne:String){
        do {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            thisSong+=1
            if thisSong == songs.count{
                thisSong = 0
            }
            audioPlayer.play()
        }
        catch {
            print("ERROR")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = songs[thisSong]
        cdView.image = UIImage(named: picts[thisSong]+".jpg")
        
        viewShadow.backgroundColor = UIColor.white
        viewShadow.layer.shadowColor = UIColor.black.cgColor
        viewShadow.layer.shadowOpacity = 0.3
        viewShadow.layer.shadowOffset = CGSize.zero
        viewShadow.layer.shadowRadius = 5
        self.view.addSubview(viewShadow)
        
        button.setImage(UIImage(named: "pause"), for: .normal)
        nextButton.setImage(UIImage(named: "next"), for: .normal)
        prevButton.setImage(UIImage(named: "prev"), for: .normal)
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
        airplayButton.setImage(UIImage(named: "airplay"), for: .normal)
        loveButton.setImage(UIImage(named: "love"), for: .normal)
        prevButton.setImage(UIImage(named: "love-fill"), for: .selected)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
