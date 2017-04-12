//
//  NextControllerViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 11/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class NextControllerViewController: BaseViewController {

    var rootViewController: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.musicLayerController?.toolbar.isHidden = false
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
