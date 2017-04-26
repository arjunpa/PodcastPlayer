//
//  NextControllerViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 11/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class NextControllerViewController: BaseViewController {
    @IBOutlet weak var rewindButton: UIButton!

    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    var rootViewController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
