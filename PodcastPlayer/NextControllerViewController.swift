//
//  NextControllerViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 11/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit

class NextControllerViewController: BaseViewController {
    @IBOutlet weak var rewindButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var displaylabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var rootViewController: ViewController?
    var isSeeking:Bool = false
    
    
    let tableView:UITableView = {
        let view = UITableView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
     
    }
    
    func setUpTableView(){
        self.view.addSubview(tableView)
        tableView.fillSuperview()
        
        tableView.tableHeaderView = PLayerHeaderView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300), qtObject: self.qtObject)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension NextControllerViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}



