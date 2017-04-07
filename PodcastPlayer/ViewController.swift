//
//  ViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 03/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var toolbar:PlayerControlsView = {
        let controlView = PlayerControlsView.loadFromNib()
        return controlView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      //  PlayerToolbar.loadToolbar()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      //  self.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 72)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

