//
//  GalleryElementCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/8/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype

class MetaImage{
    
    var imageMeta:ImageMetaData?
    var image:String?
    var imageDescription:String?
    
}

class GalleryElementCell: BaseCollectionCell {
    
    var collectionView: UICollectionView = {
        let layout = CenterCellCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.decelerationRate = UIScrollViewDecelerationRateFast
        return view
    }()
    
    var cardElement:CardStoryElement?
    var imageArray:[MetaImage] = []
    
    override func setupViews() {
        let view = self.contentView
        collectionView.backgroundColor = UIColor(hexString:"#f9f9f9")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        collectionView.register(StoryDetailImageElementCell.self, forCellWithReuseIdentifier: "StoryDetailImageElementCell")
        collectionView.fillSuperview()
        
    }
    
    override func configure(data: Any?) {
        self.cardElement = data as? CardStoryElement
        
        for (_,card) in (cardElement?.story_elements.enumerated())!{
            
            let imageDataHolder = MetaImage()
            imageDataHolder.image = card.image_s3_key
            imageDataHolder.imageMeta = card.image_metadata
            imageDataHolder.imageDescription = card.title
            imageArray.append(imageDataHolder)
            
        }
    }
    
}

extension GalleryElementCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryDetailImageElementCell", for: indexPath) as! StoryDetailImageElementCell
        
        imageCell.configure(data: imageArray[indexPath.row])
        return imageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 245)
//        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
