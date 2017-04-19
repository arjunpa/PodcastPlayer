//
//  DefaultStoryCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/11/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype


class DefaultStoryCell: BaseCollectionCell {
    
    let kinterElementSpacing:CGFloat = 8
    let kmarginPadding:CGFloat = 16
    let imageBaseUrl = "https://" + (Quintype.publisherConfig?.cdn_image)! + "/"

    
    var imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    var headerLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    var descriptionLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 4
        return label
    }()

    override func setupView() {
        let view = self.contentView
        view.addSubview(imageView)
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: kmarginPadding, leftConstant: kmarginPadding, bottomConstant: kmarginPadding, rightConstant: 0, widthConstant: 200, heightConstant: 100)
        
        headerLabel.anchor(view.topAnchor, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: kmarginPadding, leftConstant: kinterElementSpacing, bottomConstant: 0, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
        descriptionLabel.anchor(headerLabel.bottomAnchor, left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: kmarginPadding, leftConstant: kinterElementSpacing, bottomConstant: kmarginPadding, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
    }
    
    override func configure(data: Any?) {
        let story = data as? Story
        
        headerLabel.text = story?.sections.first?.display_name
        descriptionLabel.text = story?.headline
        
       if let imageKey = story?.hero_image_s3_key{
        self.imageView.loadImage(url:  self.imageBaseUrl + imageKey + "?w=\(200)", targetSize: CGSize.init(width: 200, height: 100), imageMetaData: nil)
        
        }
        
    }
    

    
}
