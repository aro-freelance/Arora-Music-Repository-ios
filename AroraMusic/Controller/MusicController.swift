//
//  ViewController.swift
//  AroraMusic
//
//  Created by Mandy on 10/28/22.
//

import UIKit
import AVFoundation
import MediaPlayer


class MusicController: UIViewController, ItemClicked, UITableViewDelegate, UITableViewDataSource {
    
    func itemClicked(position: Int) {

        stop()
        
        currentPosition = position
        
        if(isShuffling){
            
            isShuffling = false
            play(currentPosition)
            isShuffling = true
            
        }
        else {
            
            play(currentPosition)
            
        }
        
    }
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var timeElapsedLabel: UILabel!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var randomButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var music = Music()
    
    var musicList : [Music] = []
    
    var currentPosition : Int = 0
    var isPlaying : Bool = false
    var isShuffling : Bool = false
    
    //TODO: initialize a mediaplayer class or whatever the alternative is in ios

    var mediaPlayer = AVAudioPlayer()
    
    
   
    
    var randomPosition : Int = 0
    var songPercent : Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        music.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //TODO: ads?
        
        //TODO: keep the screen awake (so that it doesn't stop playing midsong while idle)
        
        getSongs()
        
        
        
        
        
    }
    
    //TODO: button methods for play, next, previous and shuffleplay buttons
    
    
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        next()
    }
    
    
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        play(currentPosition)
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        previous()
    }
    
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        shufflePlay()
    }
    
    
    
    
    func next(){
        
        if(isShuffling){
            stop()
            randomPosition = 0 //TODO: get a random number from 0 to musicList.size
            play(randomPosition)
        }
        else if (currentPosition < musicList.capacity - 1){
            stop()
            currentPosition += 1
            play(currentPosition)
        }
        else {
            stop()
        }
        
    }
    
    func previous(){
        
        if(isShuffling){
            stop()
            randomPosition = 0 //TODO: get a random number from 0 to musicList.size
            play(randomPosition)
        }
        else if (currentPosition > 0){
            stop()
            currentPosition -= 1
            play(currentPosition)
        }
        else {
            stop()
        }
        
    }
    
    func stop(){
        
        if(mediaPlayer != nil){
            mediaPlayer.stop()
            isPlaying = false
            songPercent = 0
            
            //TODO: set play button image to a play arrow
            //playButton.setTitle("Play", for: .normal)
            titleLabel.text = ""
            
        }
        
    }
    
    func pause(){
        if(mediaPlayer != nil){
            mediaPlayer.pause()
            isPlaying = false
            
            //TODO: set play button to play arrow
            //playButton.setTitle("Play", for: .normal)
        }
    }
    
    func shufflePlay(){
        
        if(!isShuffling){
            //TODO: set random button to shuffle on icon
            randomButton.setTitle("Turn off Shuffle", for: .normal)
            isShuffling = true
        } else {
            //TODO: set random button to shuffle off icon
            randomButton.setTitle("Turn on Shuffle", for: .normal)
            isShuffling = false
        }
        
        //if it is not currently playing a song, then start playing a random song
        if(!isPlaying && songPercent == 0){
            //random position will be picked inside play method when isShuffling is turned on
            stop()
            play(currentPosition)
        }
        
    }
    
    
    func play(_ position: Int){
        
        var pos = position
        
        print("play position: \(pos)")
        
        //if not currently playing
        if(!isPlaying && songPercent == 0){
            
            //TODO: set play button to pause icon
            //TODO: this gave a nil error for the button saying the button was optional at the time it was called
            //playButton.setTitle("Pause", for: .normal)
            isPlaying = true
            
            if(isShuffling){
                
                randomPosition = 0 //TODO: get a random number from 0 to musicList.size
                pos = randomPosition
                
            }
            
            print("musicList size: \(musicList.capacity)")

            let url = musicList[pos].songUrl
            
            print("url \(url)")
            
            if(url != nil){
                do {
                    //TODO: convert string to url
                    mediaPlayer = try AVAudioPlayer(contentsOf: url! as! URL)
                    mediaPlayer.play()
                    titleLabel.text = musicList[pos].songName
                    print("play do block")
                }
                catch{
                    print("Failed to play")
                }
            } else {
                print("url is nil")
            }
            
            //TODO: autoplay next song
            
            
        }
        
        //TODO: continue playing where it was paused
        else if (!isPlaying && songPercent > 0){
            
            
            
        }
        //pause currently playing song
        else {
            pause()
        }
        
    }
    
    
    //TODO: method to format timer string
    func timerFormat(time: Int) -> String{
        
        //TODO:format to time 00:00 format
        let _ : String = ""
        
        var convert = ""
        
        //TODO: translate this... test in android to find out what is up
//        for (element in result)
//                convert += element
        
        
        return convert
    }
    
    
    //TODO: get the music from the user device
    func getSongs(){
        
        //get the music to add it to an array of Music Objects
        if let mediaItems = MPMediaQuery.songs().items{
            
            let mediaCollection = MPMediaItemCollection(items: mediaItems)
            
            //use this list to make my Music objects and add them to the musicList
            for item in mediaCollection.items {
                
                if let url = item.value(forProperty: MPMediaItemPropertyAssetURL) as? URL {
                    
                    
                    if(url != nil){
                        
                        let theAsset = AVAsset(url: url)
                        if theAsset.hasProtectedContent {
                         
                            print("Asset is protected")
                            
                        } else {
                            print("Asset is not protected")
                        }
                    } else {
                        print("Asset is: not available offline or must be player via MPPlayer")
                    }
                    
                    print("get songs url : \(url)")
                    
                    let music = Music(artistName: item.artist, songName: item.title, songUrl: url)
                    
                    musicList.append(music)
                    
                    print("song name : \(music.songName ?? "nil")")
                    
                    
                }
                
                
                
            }
            
            
        }
        
        //TODO: sort the array
        
        
        
        if(musicList.isEmpty){
            print("No music found.")
        }
        
    }
    
    
    
    @IBAction func seekbarChanged(_ sender: UISlider) {
        
        
        songPercent = Int(slider.value)
        
        print("songPercent = \(songPercent)")
        
        
        //TODO: translate this to go to songPercent in the player. mediaPlayer?.seekTo(songPercent * 1000)
        
    }
    
    
    
    
    //TODO: onstop and onpause should call pause method. ondestroy should end the mediaplayer.
    
    
    //TODO: implement the adapter in this file. In the original android project it is in the MusicListAdapter file.
    //MARK: - TableView Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }

    //set the array to the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
        
        let artistString = musicList[indexPath.row].artistName ?? "No Artist"
        let titleString = musicList[indexPath.row].songName ?? "No Title"
        
        cell.textLabel?.text = "\(artistString)   ||   \(titleString)"
        
        
        return cell
    }
    


}

