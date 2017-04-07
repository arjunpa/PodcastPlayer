//
//  BaseViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 04/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit


protocol BaseControllerProtocol:class{
    var qtObject:QTGlobalProtocol{
        get set
    }
     init(_ qtObject:QTGlobalProtocol, nibName:String?, bundle:Bundle?)
}

class BaseViewController: UIViewController, BaseControllerProtocol {
    internal var qtObject: QTGlobalProtocol
    var playerControls:BasePlayerControlView

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    required init(_ qtObject: QTGlobalProtocol = QTGlobalInstance.init(tdAttributes: nil), nibName: String?, bundle: Bundle?)
        
    {
        self.qtObject = qtObject
//        self.playerControls = PlayerControlsView.loadFromNib()
        self.playerControls = qtObject.playerManager.playerControls!
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.playerControls.superview == nil{
//            self.loadPlayerView()
//            self.view.frame = CGRect.init(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.bounds.width, height: self.view.bounds.height - self.playerControls.sizeFit().height)
        }
    }
    
    func loadPlayerView(){
       
        self.view.window?.addSubview(playerControls)
        playerControls.trailingAnchor.constraint(equalTo: self.view.window!.trailingAnchor).isActive = true
        playerControls.leadingAnchor.constraint(equalTo: self.view.window!.leadingAnchor).isActive = true
        playerControls.bottomAnchor.constraint(equalTo: self.view.window!.bottomAnchor).isActive = true
        
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
