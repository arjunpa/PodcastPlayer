//
//  ImageViewController.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/1/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class ImageViewController: BaseViewController {
    
    
    let screenBounds  = UIScreen.main.bounds

    var url:String?
    var imageMeta:ImageMetaData?
    
    let imageView:UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return imageView
        
    }()
    
    override func loadView() {
        super.loadView()
        self.view = UIView.init(frame: screenBounds)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.backgroundColor = .black
        imageView.fillSuperview()
        
        if let imageUrl = url{
            
            imageView.loadImage(url: imageUrl, targetSize: CGSize(width: imageView.bounds.width, height: imageView.bounds.height))
        }
        
    }
    
    
}
