//
//  Music.swift
//  AroraMusic
//
//  Created by Mandy on 10/29/22.
//

import Foundation


//this is an interface file in the original project on android
protocol ItemClicked {
    
    func itemClicked(position: Int)
    
}

struct Music {
    
    
    var artistName : String?
    
    var songName : String?
    
    var songUrl : URL?
    
    
    var delegate : ItemClicked?
    
    
    
    
    
}
