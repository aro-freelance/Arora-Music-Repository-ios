//
//  ViewController.swift
//  AroraMusic
//
//  Created by Mandy on 10/28/22.
//

import UIKit
import AVFoundation
import MediaPlayer


class MusicController: UIViewController, ItemClicked {
    
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
        
        
        
        
        //TODO: ads?
        
        //TODO: keep the screen awake (so that it doesn't stop playing midsong while idle)
        
        checkPermissions()
        
        
        
        
        
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
        
        //TODO: implement
        
    }
    
    func previous(){
        
        //TODO: implement
        
    }
    
    func stop(){
        //TODO: implement
    }
    
    func pause(){
        //TODO: implement
    }
    
    func shufflePlay(){
        //TODO: implement
    }
    
    
    func play(_ position: Int){
        //TODO: implement
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
                
                let music = Music(artistName: item.artist, songName: item.title, songUri: item.assetURL)
                
                musicList.append(music)
                
                print("song name : \(music.songName ?? "nil")")
                
            }
            
            
        }
        
        //TODO: sort the array
        
        //set the array to the tableview
        
        
        //if list is empty give user feedback to let them know
        
        
    }
    
    
    
    
    //TODO: do whatever we need to do to get permissions to view/access user music files (external files access in android project)
    func checkPermissions(){
        
        //TODO:get permission
        
        getSongs()
        
    }
    
    //TODO: seekbar change listener... set it up so the user can move thr seekbar to a position and update the song to start playing at that location
    
    
    
    @IBAction func seekbarChanged(_ sender: UISlider) {
        
        
        songPercent = Int(slider.value)
        
        print("songPercent = \(songPercent)")
        
        
        //TODO: translate this to go to songPercent in the player. mediaPlayer?.seekTo(songPercent * 1000)
        
    }
    
    
    
    
    //TODO: onstop and onpause should call pause method. ondestroy should end the mediaplayer.
    
    
    //TODO: implement the adapter in this file. In the original android project it is in the MusicListAdapter file.
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
        
        cell.textLabel?.text = musicList[indexPath.row].artistName ?? "No Artist"
        cell.textLabel?.text = musicList[indexPath.row].songName ?? "No Title"
        
        
        return cell
    }
    


}

