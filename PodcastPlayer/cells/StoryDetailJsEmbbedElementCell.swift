//
//  StoryDetailJsEmbbedElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/8/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation
import UIKit
import Quintype
import Darwin

class StoryDetailJsEmbbedElementCell:BaseCollectionCell,UIWebViewDelegate{
    
    //    let utility = QuintypeUtility.sharedInstance
    var status = false
    var index:Int?
    var isHeightCalculated:Bool = false
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    var contentLoaded:String = ""
    
    var jsEmbedView:UIWebView = {
        
        let webView = UIWebView()
        webView.backgroundColor = .blue
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        return webView
        
    }()
    
    
    var loadingView:UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        view.layer.borderWidth = 1
        return view
    }()
    
    var webFrameCounter:Int = 0
    
    
    override func setupViews() {
        super.setupViews()
        
        let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        self.jsEmbedView.delegate = self
        
        view.addSubview(jsEmbedView)
        jsEmbedView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(loadingView)
        loadingView.fillSuperview()
        view.bringSubview(toFront: loadingView)
        
        if !isHeightCalculated {
            showActivityIndicatory(uiView: self.contentView)
        }
        
    }
    
    override func configure(data: Any?, index: Int,status:Bool) {
        
        
        super.configure(data: data, index: index,status:status)
        self.index = index
        
        let card = data as? CardStoryElement
        
        if let base64String = card?.embed_js{
            
            if let html = base64String.decodeBase64()?.trim(){
                
                let fullHtml = "<html><head><style>body,iframe { box-shadow: none !important; width:\(UIScreen.main.bounds.width - 45); }</style> </head><body id='foo'> \(html) </body></html>"
                if contentLoaded != card!.id!{
                    jsEmbedView.loadHTMLString(fullHtml, baseURL: NSURL.init(string: "https://localhost") as URL?)
                    contentLoaded = card!.id!
                }
            }
        }
        
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if webView.isLoading {
            return
        }
        
        if self.index != nil && !self.isHeightCalculated && webView.request?.url != URL(string:"") {
            self.isHeightCalculated = true
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(4)) {
                
                if !self.status{
                    self.status = false
                    self.delegate?.didCalculateSize(indexPath:self.index!,size: CGSize(width: self.contentView.frame.width, height: self.getHeightOfWebView(webView: webView)),elementType: storyDetailLayoutType.storyDetailJsEmbbedElementCell)
                    
                    self.loadingView.alpha = 0
                    self.hideActivityIndicatory(uiView: self.loadingView)
                    
                }
                
            }
         
            
        }
        
    }
    
    fileprivate func getHeightOfWebView(webView:UIWebView)->CGFloat{
        
        
        let jsScript = "document.body.scrollHeight"
        
        let height = webView.stringByEvaluatingJavaScript(from: jsScript)
       //print("Webview height is::\(height)")
        
        if height == "" || height == nil{
            return 1
        }else{
            let finalHeight = CGFloat(Int(height!)!)
            getHeight()
            
            return finalHeight + 10
        }
        
    }
    
    func getHeight(){
        var frame = jsEmbedView.frame
        frame.size.height = 1
        jsEmbedView.frame = frame
        let fittingSize = jsEmbedView.sizeThatFits(CGSize(width: loadingView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        frame.size = fittingSize
        
        jsEmbedView.frame = frame
    }
    
    func showActivityIndicatory(uiView: UIView) {
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        actInd.color = UIColor.lightGray
        uiView.addSubview(actInd)
        //        uiView.isUserInteractionEnabled = false
        actInd.startAnimating()
        
    }
    
    func hideActivityIndicatory(uiView: UIView){
        actInd.stopAnimating()
        //        uiView.isUserInteractionEnabled = true
    }
    
    
}
