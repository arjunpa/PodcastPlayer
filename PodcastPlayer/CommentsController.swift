//
//  CommentsController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/14/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype

class CommentController: BaseViewController,UIWebViewDelegate {
    
    var html:String?
    let screenBounds  = UIScreen.main.bounds
    
    let commentWebView:UIWebView = {
        
        let webView = UIWebView()
        return webView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        commentWebView.delegate = self
        view.addSubview(commentWebView)
        commentWebView.fillSuperview()
        
        if let htmlString = html{
            commentWebView.loadHTMLString(htmlString, baseURL: URL(string:"https://localhost"))
        }
        
    }
    
    override func loadView() {
        self.view = UIView.init(frame: screenBounds)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if webView.isLoading{
            return
        }
        
    }
}
