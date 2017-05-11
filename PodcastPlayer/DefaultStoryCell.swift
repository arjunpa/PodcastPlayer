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
    
    let kinterElementSpacing:CGFloat = 15
    let kmarginPadding:CGFloat = 15
    let imageBaseUrl = "https://" + (Quintype.publisherConfig?.cdn_image)! + "/"
    
    
    var imageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage()
        image.clipsToBounds = true
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
    
    var currentTheam : Theme!
    
    override func setupViews() {
        super.setupViews()
        
        //added for themeing
        ThemeService.shared.addThemeable(themable: self,applyImmediately: true)
        
        let view = self.contentView
        view.addSubview(imageView)
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: kmarginPadding, leftConstant: kmarginPadding, bottomConstant: kmarginPadding, rightConstant: 0, widthConstant: 120, heightConstant: 90)
        
        headerLabel.anchor(view.topAnchor, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: kmarginPadding, leftConstant: kinterElementSpacing, bottomConstant: 0, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
        
        descriptionLabel.anchor(headerLabel.bottomAnchor, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 6, leftConstant: kinterElementSpacing, bottomConstant: 0, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
    }
    
    override func configure(data: Any?) {
        let story = data as? Story
        
        headerLabel.text = story?.sections.first?.name?.uppercased()
        descriptionLabel.text = story?.headline
        
        headerLabel.setLineSpacing(spacing: 1.5)
        headerLabel.addTextSpacing(spacing: 1.7)
        descriptionLabel.setLineSpacing(spacing: 1.5)
        
        if let imageKey = story?.hero_image_s3_key{
          
            self.imageView.loadImage(url: self.imageBaseUrl + imageKey + "?w=\(120)", targetSize: CGSize.init(width: 120, height: 90), imageMetaData: (story?.hero_image_metadata),placeholder: #imageLiteral(resourceName: "image_pholder"))
        }
    }
    
    override func prepareForReuse() {
        
        self.imageView.image = nil
        super.prepareForReuse()
    }

    deinit{
        ThemeService.shared.removeThemeable(themable: self)
        print("DefaultStoryCell denit called")
    }
}

extension DefaultStoryCell : Themeable{
    func applyTheme(theme: Theme) {
        if currentTheam == nil || type(of:theme) != type(of:currentTheam!){
            self.currentTheam = theme
            headerLabel.font = theme.normalListSectionFont
            headerLabel.textColor = theme.normalListSectionColor
            
            descriptionLabel.font = theme.normalListTitleFont
            descriptionLabel.textColor = theme.normalListTitleColor
        }
    }
}
