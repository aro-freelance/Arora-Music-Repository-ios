//
//  ViewController.swift
//  AroraMusic
//
//  Created by Mandy on 10/28/22.
//

import UIKit



class MusicController: UIViewController, ItemClicked {
    
    func itemClicked(position: Int) {

        stop()
        
        
    }
    
    
    var music = Music()
    
    var musicList : [Music] = []
    
    var currentPosition : Int = 0
    var isPlaying : Bool = false
    var isShuffling : Bool = false
    
    //TODO: initialize a mediaplayer class or whatever the alternative is in ios
//    var mediaPlayer
    
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //TODO: method to format timer string
    func timerFormat(time: Int) -> String{
        
        //TODO:format to time 00:00 format
        let result : String = ""
        
        var convert = ""
        
        //TODO: translate this... test in android to find out what is up
//        for (element in result)
//                convert += element
        
        
        return convert
    }
    
    
    //TODO: get the music from the user device
    func getSongs(){
        
        //get the music using a cursor to add it to an array of Music Objects
        
        //sort the array
        
        //set the array to the tableview
        
        //if list is empty give user feedback to let them know
        
        
    }
    
    
    
    
    //TODO: do whatever we need to do to get permissions to view/access user music files (external files access in android project)
    func checkPermissions(){
        
        //TODO:
        
    }
    
    //TODO: seekbar change listener... set it up so the user can move thr seekbar to a position and update the song to start playing at that location
    
    //TODO: onstop and onpause should call pause method. ondestroy should end the mediaplayer.
    
    
    //TODO: implement the adapter in this file. In the original android project it is in the MusicListAdapter file.
    
    


}

