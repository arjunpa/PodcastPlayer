//
//  PodcastPlayerViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 03/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Soundcloud
import IGListKit


class PodcastPlayerViewController: BaseViewController {

    
    required init(_ qtObject:QTGlobalProtocol = QTGlobalInstance.init(tdAttributes: nil), nibName:String?, bundle:Bundle?){
        super.init(qtObject, nibName: nibName, bundle: bundle)
        self.configureSCClient()
    }
    
    
    func configureSCClient(){
        SoundcloudClient.clientSecret = "esv5NccmUd0wRgyFgUojqMiNBwM9nZhl"
        SoundcloudClient.clientIdentifier = "fs2FkPBdYj7aNns0zJqgi8ZmR7CAXaBw"
        SoundcloudClient.redirectURI = ""
        
        let queries: [SearchQueryOptions] = [
            .queryString("ed sheeran"),
            .types([TrackType.live, TrackType.demo])
        ]
        Track.search(queries: queries) { (response:PaginatedAPIResponse<Track>) in
            print(response.response.result)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
