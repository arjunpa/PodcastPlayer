//
//  PlayerToolbar.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/3/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import UIKit

class PlayerToolbar:UIView{
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    
    let kToolBarHeight:Int = 72
    
    class func loadToolbar(){
        let toolBar = Bundle.main.loadNibNamed("PlayerToolbar", owner: self, options: nil)?[0] as! PlayerToolbar
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(toolBar)
        appdelegate.window?.addSubview(toolBar)
        
        toolBar.bottomAnchor.constraint(equalTo: (appdelegate.window?.bottomAnchor)!, constant: 0).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: (appdelegate.window?.leadingAnchor)!, constant: 0).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: (appdelegate.window?.trailingAnchor)!, constant: 0).isActive = true
        
        
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
    }
    
}
