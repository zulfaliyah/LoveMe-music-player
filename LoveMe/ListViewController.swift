//
//  ListViewController.swift
//  LoveMe
//
//  Created by Zulfa Aliyah on 30/03/20.
//  Copyright © 2020 Zulfa Aliyah. All rights reserved.
//

import UIKit
import AVFoundation

var songs:[String] = []
var picts:[String] = []
var audioPlayer = AVAudioPlayer()
var thisSong = 0

class TableViewCell: UITableViewCell{
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var audioCount: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.myImage.image = UIImage(named: picts[indexPath.row]+".jpg")
        cell.myLabel.text = songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            self.performSegue(withIdentifier: "listToPlay", sender: self)
            audioPlayer.play()
            thisSong = indexPath.row
        }
        catch {
            print("ERROR!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gettingSongName()
        audioCount.text = String(songs.count)+" Audios"
    }
    
    func gettingSongName(){
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for song in songPath {
                var mySong = song.absoluteString
                if mySong.contains(".mp3"){
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    songs.append(mySong)
                }
            }
            for pict in songPath {
            var myPict = pict.absoluteString
                if myPict.contains(".jpg"){
                    let findString = myPict.components(separatedBy: "/")
                    myPict = findString[findString.count-1]
                    myPict = myPict.replacingOccurrences(of: "%20", with: " ")
                    myPict = myPict.replacingOccurrences(of: ".jpg", with: "")
                    picts.append(myPict)
                    print(myPict)
                }
            }
            myTableView.reloadData()
        } catch {
            print("ERROR!")
        }
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
