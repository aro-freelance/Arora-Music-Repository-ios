//
//  ViewController.swift
//  AroraMusic
//
//  Created by Mandy on 10/28/22.
//

import UIKit
import AVFoundation
import MediaPlayer


class MusicController: UITableViewController {
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var timeElapsedLabel: UILabel!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var randomButton: UIButton!
    
    
    
    
    var music = Music()
    
    var musicList : [Music] = []
    
    var currentPosition : Int = 0
    var isPlaying : Bool = false
    var isShuffling : Bool = false
    
    var mediaPlayer = AVAudioPlayer()
    
    var randomPosition : Int = 0
    var songPercent : Float = 0.00
    var timer: Timer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MusicCell")
        
        
        //TODO: ads?
        
        //TODO: keep the screen awake (so that it doesn't stop playing midsong while idle)?
        
        getSongs()
        
        
        
        
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        previous()
    }
    
    
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        play(currentPosition)
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        next()
    }
    
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        shufflePlay()
    }
    
    
    
    
    func next(){
        
        if(isShuffling){
            stop()
            randomPosition = Int.random(in: 0..<musicList.count)
            play(randomPosition)
        }
        else if (currentPosition < musicList.endIndex){
            print("next block: current pos = \(currentPosition)")
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
            randomPosition = Int.random(in: 0..<musicList.count)
            play(randomPosition)
        }
        else if (currentPosition > 0){
            print("previous block: current pos = \(currentPosition)")
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
            timer?.invalidate()
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
            timer?.invalidate()
            isPlaying = false
            
            //TODO: set play button to play arrow
            //playButton.setTitle("Play", for: .normal)
        }
    }
    
    func shufflePlay(){
        
        if(!isShuffling){
            //TODO: set random button to shuffle on icon
            //randomButton.setTitle("Turn off Shuffle", for: .normal)
            isShuffling = true
        } else {
            //TODO: set random button to shuffle off icon
            //randomButton.setTitle("Turn on Shuffle", for: .normal)
            isShuffling = false
        }
        
        //if it is not currently playing a song, then start playing a random song
        if(!isPlaying && songPercent == 0){
            //random position will be picked inside play method when isShuffling is turned on
            stop()
            play(currentPosition)
        }
        //turned this off so the button is just a shuffle toggle
//        else {
//            print("shuffle button pause.")
//            pause()
//        }
        
    }
    
    
    func play(_ position: Int){
        
        //TODO: setup on click for the tableview to pass the pos to this method
        
        var pos = position
        
        
        //if not currently playing
        if(!isPlaying && songPercent == 0){
            
            timerStart()
            
            //TODO: set play button to pause icon
            //TODO: this gave a nil error for the button saying the button was optional at the time it was called
            //playButton.setTitle("Pause", for: .normal)
            isPlaying = true
            if(isShuffling){
                
                randomPosition = Int.random(in: 0..<musicList.count)
                pos = randomPosition
                
            }
            
            print("play position: \(pos)")
            
            if(pos >= musicList.endIndex){
                //TODO: give user feedback that this is out of scope
                print("index too high")
                return
            }
            if(pos < musicList.startIndex){
                //TODO: give user feedback that this is out of scope
                print("index too low")
                return
            }
            
            print("musicList size: \(musicList.count)")

            if let url = musicList[pos].songUrl {
                print("url \(url)")
                
                do {
                    //TODO: convert string to url
                    mediaPlayer = try AVAudioPlayer(contentsOf: url )
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
            print("is not playing and song percent is >0. cont from paused pos.")
            timerStart()
            
            
        }
        //pause currently playing song
        else {
            print("pause the song")
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
                    
                    //TODO: test this to fix it blocking all the itunes stuff.. only the manual adds make it to the list now...
                    
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
        
        pause()
        
        songPercent = Float(sender.value / 1000)
        
        var time = mediaPlayer.duration * (Double(songPercent))
        
        mediaPlayer.currentTime = time
        mediaPlayer.play()
        timerStart()
        
        
    }
    
    //call slider match to song method each 0.0001
    func timerStart(){
        //TODO: fix this function so that it doesn't conflict with the play/pause and seek functionality
        
//        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.sliderMatchProgress), userInfo: nil, repeats: true)
    }
    
    //match the slider to the song progress
    @objc func sliderMatchProgress(){
        
        slider.value = Float(mediaPlayer.currentTime)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        pause()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stop()
    }
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }

    //set the array to the tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
        
        let artistString = musicList[indexPath.row].artistName ?? "No Artist"
        let titleString = musicList[indexPath.row].songName ?? "No Title"
        
        cell.textLabel?.text = "\(artistString)   ||   \(titleString)"
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    //do something when a row is clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        stop()
        
        currentPosition = indexPath.row
        
        if(isShuffling){
            
            isShuffling = false
            play(currentPosition)
            isShuffling = true
            
        }
        else {
            
            play(currentPosition)
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    


}

