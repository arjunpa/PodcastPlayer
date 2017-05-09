//
//  DetailSectionController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/11/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import IGListKit
import Quintype



class DetailSectionController:BaseIGListSectionController,BaseCollectionCellDelegate{
    
    var data: StoryDetailLayout!
    var story : Story!
    var targetSize = CGSize.zero
    var showSummary = false
    var jsEmbedCellHeight : [Int:CGSize] = [:]
    var twitterCellheight :[Int:CGSize] = [:]
    
    var layoutEngine = [StoryDetailLayout]()
    
    var sizingCells:[String:BaseCollectionCell] = [:]

    var youtubeCellIdentifiers:[String] = []
    
    init(layout:[StoryDetailLayout],story:Story){
        super.init()
        self.layoutEngine = layout
        self.story = story
        inset = UIEdgeInsetsMake(0, 0, 0, 0)
        targetSize = (collectionContext?.containerSize)!
        createSizingCells()
    }
    
    func createSizingCells(){
        
        let storyDetailHeaderImageElementCell = StoryDetailHeaderImageElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailHeaderImageElementCell.rawValue] = storyDetailHeaderImageElementCell
        
        let storyDetailHeaderTextElementCell = StoryDetailHeaderTextElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailHeaderTextElementCell.rawValue] = storyDetailHeaderTextElementCell
        
        let storyDetailSocialShareElementCell = StoryDetailSocialShareElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailSocialShareElementCell.rawValue] = storyDetailSocialShareElementCell
        
        let storyDetailTextElementCell = StoryDetailTextElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailTextElementCell.rawValue] = storyDetailTextElementCell
        
        let storyDetailBlockkQuoteElementCell = StoryDetailBlockkQuoteElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailBlockkQuoteElementCell.rawValue] = storyDetailBlockkQuoteElementCell
        
        let storyDetailQuoteElementCell = StoryDetailQuoteElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailQuoteElementCell.rawValue] = storyDetailQuoteElementCell
        
        let storyDetailBlurbElementCell = StoryDetailBlurbElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailBlurbElementCell.rawValue] = storyDetailBlurbElementCell
        
        let storyDetailQuestionElementCell = StoryDetailQuestionElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailQuestionElementCell.rawValue] = storyDetailQuestionElementCell
        
        let storyDetailAnswerElementCell = StoryDetailAnswerElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailAnswerElementCell.rawValue] = storyDetailAnswerElementCell
        
        let storyDetailBigFactElementCell = StoryDetailBigFactElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailBigFactElementCell.rawValue] = storyDetailBigFactElementCell
        
        let storyDetailAuthorElemenCell = StoryDetailAuthorElemenCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailAuthorElemenCell.rawValue] = storyDetailAuthorElemenCell
        
        let storyDetailsTagElementCell = StoryDetailsTagElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailsTagElementCell.rawValue] = storyDetailsTagElementCell
        
        let galleryElementCell = GalleryElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.galleryElementCell.rawValue] = galleryElementCell
        
        let storyDetailImageElementCell = StoryDetailImageElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailImageElementCell.rawValue] = storyDetailImageElementCell
        
        let storyDetailSummeryElementCell = StoryDetailSummeryElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailSummeryElementCell.rawValue] = storyDetailSummeryElementCell
        
        let storyDetailTwitterElementCell = StoryDetailTwitterElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailTwitterElementCell.rawValue] = storyDetailTwitterElementCell
        
        let storyDetailYoutubeElementCell = StoryDetailYoutubeElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailYoutubeElementCell.rawValue] = storyDetailYoutubeElementCell
        
        let storyDetailJWPlayerElementCell = StoryDetailJWPlayerElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailJWPlayerElementCell.rawValue] = storyDetailJWPlayerElementCell
        
        let storyDetailCommentElementCell = StoryDetailCommentElementCell.init(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailCommentElementCell.rawValue] = storyDetailCommentElementCell
        
        let storyDetailTitleElementCell = StoryDetailTitleElementCell(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailTitleElementCell.rawValue] = storyDetailTitleElementCell
        
        let storyDetailQandAElementCell = StoryDetailQandACell(frame: CGRect.zero)
        self.sizingCells[storyDetailLayoutType.storyDetailQandACell.rawValue] = storyDetailQandAElementCell
        
    }
    
}

extension DetailSectionController: IGListSectionType{
    
    func numberOfItems() -> Int {
        return self.layoutEngine.count
//        return 3
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        
        self.data = self.layoutEngine[index]
        switch (self.data.layoutType) {
        //static top
        case .storyDetailHeaderImageElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailHeaderImageElementCell.self, for: self, at: index) as! StoryDetailHeaderImageElementCell
            cell.configure(data: self.story)
            cell.shareButton.accessibilityElements = [self.story]
            cell.shareButton.addTarget(self, action: #selector(shareButtonAction(sender:)), for: UIControlEvents.touchUpInside)
            return cell
        case .storyDetailHeaderTextElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailHeaderTextElementCell.self, for: self, at: index) as! StoryDetailHeaderTextElementCell
            cell.configure(data: self.story)
            return cell
        case .storyDetailSocialShareElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailSocialShareElementCell.self, for: self, at: index) as! StoryDetailSocialShareElementCell
            cell.configure(data: self.story)
            cell.shareButton.accessibilityElements = [self.story]
            cell.shareButton.addTarget(self, action: #selector(shareButtonAction(sender:)), for: UIControlEvents.touchUpInside)
            cell.commentButton.addTarget(self, action: #selector(commentButtonAction(sender:)), for: UIControlEvents.touchUpInside)
            cell.authorName.addTarget(self, action: #selector(authorDetailsButtonAction(sender:)), for: UIControlEvents.touchUpInside)
            
            if let authorId = story.author_id?.intValue{ cell.authorName.tag = authorId }
            if let slug = story.slug{ cell.commentButton.accessibilityLabel = slug }
            return cell
            
        //static bottom
        case .storyDetailsTagElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailsTagElementCell.self, for: self, at: index) as! StoryDetailsTagElementCell
            cell.configure(data: self.story)
            return cell
        case .storyDetailCommentElementCell :
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailCommentElementCell.self, for: self, at: index) as! StoryDetailCommentElementCell
            if let slug = self.story.slug{ cell.commentButton.accessibilityLabel = slug }
            cell.commentButton.addTarget(self, action: #selector(commentButtonAction(sender:)), for: UIControlEvents.touchUpInside)
            return cell
            
            
            //add related story section here
            
        case .storyDetailTextElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailTextElementCell.self, for: self, at: index) as! StoryDetailTextElementCell
            cell.configure(data: data.storyElement)
            return cell
            
        case .storyDetailBlockkQuoteElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailBlockkQuoteElementCell.self, for: self, at: index) as! StoryDetailBlockkQuoteElementCell
            cell.configure(data: data.storyElement)
            return cell
            
        case .storyDetailQuoteElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailQuoteElementCell.self, for: self, at: index) as! StoryDetailQuoteElementCell
            cell.configure(data: data.storyElement)
            return cell
            
        case .storyDetailBlurbElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailBlurbElementCell.self, for: self, at: index) as! StoryDetailBlurbElementCell
            cell.configure(data: data.storyElement)
            
            return cell
            
        case .storyDetailQuestionElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailQuestionElementCell.self, for: self, at: index) as! StoryDetailQuestionElementCell
            cell.configure(data: data.storyElement)
            return cell
            
        case .storyDetailAnswerElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailAnswerElementCell.self, for: self, at: index) as! StoryDetailAnswerElementCell
            cell.configure(data: data.storyElement)
            return cell
            
        case .storyDetailBigFactElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailBigFactElementCell.self, for: self, at: index) as! StoryDetailBigFactElementCell
            cell.configure(data: data.storyElement)
            return cell
            
        case .storyDetailAuthorElemenCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailAuthorElemenCell.self, for: self, at: index) as! StoryDetailAuthorElemenCell
            cell.configure(data: data.storyElement)
            return cell
            
        case .galleryElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: GalleryElementCell.self, for: self, at: index) as! GalleryElementCell
            cell.configure(data: data.storyElement)
            return cell
            
        case .storyDetailImageElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailImageElementCell.self, for: self, at: index) as! StoryDetailImageElementCell
            cell.configure(data: data.storyElement)
            let tapGestureReconizerObject =  UITapGestureRecognizer(target:self, action: #selector(openImage(sender:)))
            cell.imageView.addGestureRecognizer(tapGestureReconizerObject)
            
            return cell
            
        case .storyDetailSummeryElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailSummeryElementCell.self, for: self, at: index) as! StoryDetailSummeryElementCell
            
            cell.configure(data: self.data.storyElement)
            
            if showSummary{
                cell.minimizeButton.setImage(UIImage(named:"arrowup"), for: UIControlState.normal)
            }else{
                cell.minimizeButton.setImage(UIImage(named:"arrowdown"), for: UIControlState.normal)
            }
            cell.minimizeButton.tag = index
            cell.minimizeButton.addTarget(self, action: #selector(summarytoggleButtonPressed(sender:)), for: .touchUpInside)
            return cell
        case .storyDetailJsEmbbedElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailJsEmbbedElementCell.self, for: self, at: index) as! StoryDetailJsEmbbedElementCell
            cell.configure(data: self.data.storyElement, index: index, status: false)
            cell.delegate = self
            return cell
            
        case .storyDetailTwitterElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailTwitterElementCell.self, for: self, at: index) as! StoryDetailTwitterElementCell
            if (twitterCellheight.index(forKey: index) == nil){
                cell.configure(data: self.data.storyElement, index: index, status: true)
            }else{
                cell.configure(data: self.data.storyElement, index: index, status: false)
            }
            
            cell.delegate = self
            return cell
            
        case .storyDetailYoutubeElementCell:
            
            let id = "Youtube\(index)"
            if youtubeCellIdentifiers.contains(id){
                let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: id, for: self, at: index) as! StoryDetailYoutubeElementCell //collectionContext?.dequeueReusableCell(of: StoryDetailYoutubeElementCell.self, for: self, at: index) as! StoryDetailYoutubeElementCell
                cell.configure(data: self.data.storyElement)
                return cell
            }else{
                let vc = self.viewController as? StoryDetailController
                vc?.collectionView.register(StoryDetailYoutubeElementCell.self, forCellWithReuseIdentifier: id)
                
                self.youtubeCellIdentifiers.append(id)
                let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: id, for: self, at: index) as! StoryDetailYoutubeElementCell //collectionContext?.dequeueReusableCell(of: StoryDetailYoutubeElementCell.self, for: self, at: index) as! StoryDetailYoutubeElementCell
                cell.configure(data: self.data.storyElement)
                return cell
            }
            
            
        case .storyDetailJWPlayerElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailJWPlayerElementCell.self, for: self, at: index) as! StoryDetailJWPlayerElementCell
            cell.configure(data: self.data.storyElement)
            return cell
            
        case .storyDetailTitleElementCell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailTitleElementCell.self, for: self, at: index) as! StoryDetailTitleElementCell
            cell.configure(data: self.data.storyElement)
            return cell
        case .storyDetailQandACell:
            let cell = collectionContext?.dequeueReusableCell(of: StoryDetailQandACell.self, for: self, at: index) as! StoryDetailQandACell
            cell.configure(data: self.data.storyElement)
            return cell
            
        }
        
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        self.data = self.layoutEngine[index]
        guard  collectionContext != nil else {
            return CGSize.zero
        }
        
        switch self.data.layoutType {
        case .storyDetailHeaderImageElementCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailHeaderImageElementCell.rawValue]//StoryDetailHeaderImageElementCell(frame: CGRect.zero)
            sizingCell?.configure(data: self.story)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailHeaderTextElementCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailHeaderTextElementCell.rawValue]//StoryDetailHeaderTextElementCell(frame: CGRect.zero)
            sizingCell?.configure(data: self.story)
            
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailSocialShareElementCell :
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailSocialShareElementCell.rawValue]//StoryDetailSocialShareElementCell(frame: CGRect.zero)
            sizingCell?.configure(data:story)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailTextElementCell:
            
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailTextElementCell.rawValue]//StoryDetailTextElementCell(frame: CGRect.zero)
            
            let calculatedSize = sizingCell?.calculateTextViewHeight(data: data.storyElement?.text, targetSize: targetSize)
            
            return calculatedSize!
            
            
        case .storyDetailBlockkQuoteElementCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailBlockkQuoteElementCell.rawValue] as? StoryDetailBlockkQuoteElementCell
            
            let calculatedSize = sizingCell?.calculateTextViewHeight(data:data.storyElement?.text,targetSize:targetSize,textOption:textOption.blockquote)
            return calculatedSize!
            
        case .storyDetailQuoteElementCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailQuoteElementCell.rawValue] as? StoryDetailQuoteElementCell
            var calculatedSize = sizingCell?.calculateTextViewHeight(data: data.storyElement?.text, targetSize: targetSize,textOption:textOption.quote)
           let labelHeight = sizingCell?.authorName.heightForView(text: data.storyElement?.metadata?.attribution ?? "", font: ThemeService.shared.theme.normalListSectionFont, width: targetSize.width)
            
            calculatedSize?.height += labelHeight! + 5//padding
            return calculatedSize!
            
        case .storyDetailBlurbElementCell:
            
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailBlurbElementCell.rawValue] as? StoryDetailBlurbElementCell
            
            let calculatedSize = sizingCell?.calculateTextViewHeight(data: data.storyElement?.metadata?.content, targetSize: targetSize,textOption:textOption.blurb)
            
            return calculatedSize!
            
        case .storyDetailQuestionElementCell:
            
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailQuestionElementCell.rawValue]
            let calculatedSize = sizingCell?.calculateTextViewHeight(data: data.storyElement?.text, targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailAnswerElementCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailAnswerElementCell.rawValue]//StoryDetailAnswerElementCell(frame: CGRect.zero)
//            sizingCell?.configure(data:data.storyElement)
//            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            let calculatedSize = sizingCell?.calculateTextViewHeight(data: data.storyElement?.text, targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailBigFactElementCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailBigFactElementCell.rawValue]//StoryDetailBigFactElementCell(frame: CGRect.zero)
            sizingCell?.configure(data:data.storyElement)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailAuthorElemenCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailAuthorElemenCell.rawValue]//StoryDetailAuthorElemenCell(frame: CGRect.zero)
            sizingCell?.configure(data:story)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
        case .storyDetailsTagElementCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailsTagElementCell.rawValue]//StoryDetailsTagElementCell(frame: CGRect.zero)
            sizingCell?.configure(data:story)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
            
        case .galleryElementCell:
            
            return CGSize(width: targetSize.width, height: 275)
            
        case .storyDetailImageElementCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailImageElementCell.rawValue]//StoryDetailImageElementCell(frame: CGRect.zero)
            sizingCell?.configure(data:data.storyElement)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailCommentElementCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailCommentElementCell.rawValue]//StoryDetailCommentElementCell(frame: CGRect.zero)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailSummeryElementCell:
            if showSummary{
                let sizingCell = sizingCells[storyDetailLayoutType.storyDetailSummeryElementCell.rawValue]//StoryDetailSummeryElementCell(frame: CGRect.zero)
                sizingCell?.configure(data: self.data.storyElement)
                let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
                return calculatedSize!
            }else{
                return CGSize(width: (collectionContext?.containerSize.width)!, height: 70)
            }
        case .storyDetailJsEmbbedElementCell:
            if (jsEmbedCellHeight.index(forKey: index) != nil){
                return jsEmbedCellHeight[index]!
            }else{
                return CGSize(width: (collectionContext?.containerSize.width)!, height: 70)
                
            }
        case .storyDetailTwitterElementCell:
            if (twitterCellheight.index(forKey: index) != nil){
                return twitterCellheight[index]!
            }else{
                return CGSize(width: (collectionContext?.containerSize.width)!, height: 70)
                
            }
            
        case .storyDetailYoutubeElementCell:
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailYoutubeElementCell.rawValue]//StoryDetailYoutubeElementCell(frame: CGRect.zero)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailJWPlayerElementCell:
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailJWPlayerElementCell.rawValue]//StoryDetailJWPlayerElementCell(frame: CGRect.zero)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailTitleElementCell:
            
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailTitleElementCell.rawValue]//StoryDetailTitleElementCell(frame: CGRect.zero)
            sizingCell?.configure(data: self.data.storyElement)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            return calculatedSize!
            
        case .storyDetailQandACell:
            let sizingCell = sizingCells[storyDetailLayoutType.storyDetailQandACell.rawValue] as? StoryDetailQandACell
            
            sizingCell?.configure(data: self.data.storyElement)
            let calculatedSize = sizingCell?.calculateHeight(targetSize: targetSize)
            
            return calculatedSize!
        }
        
        //        return CGSize.zero
        
    }
    
    func didUpdate(to object: Any) {
        print("Did update DetailSection Controller called")
    }
    
    
    func didSelectItem(at index: Int) {
        print(index)
    }
    
    func commentButtonAction(sender:UIButton){
        
        if let slug = sender.accessibilityLabel{
            
            let baseUrl = (Quintype.publisherConfig?.sketches_host)! + "/" + slug
            let disqusUrl = "http://" + Constants.Comment.disqusName + ".disqus.com/" + "embed.js"
            
            let disqusHtml:String = "<div id=\"disqus_thread\"></div><script>var disqus_config = function () {this.page.url = \"\(baseUrl)\";};(function() {var d = document, s = d.createElement('script');s.src =\" \(disqusUrl)\";s.setAttribute('data-timestamp', +new Date());(d.head || d.body).appendChild(s);})();</script><noscript>Please enable JavaScript to view the <a href=\"https://disqus.com/?ref_noscript\" rel=\"nofollow\">comments powered by Disqus.</a></noscript>"
            
            let commentController = CommentController(self.baseController!.qtObject, nibName:nil, bundle:nil)
            commentController.html = disqusHtml
            self.viewController?.navigationController?.pushViewController(commentController, animated: true)
        }
        
    }
    
    func shareButtonAction(sender:UIButton){
        
        let baseUrl = Quintype.publisherConfig?.sketches_host
        
        if let storyDetail = sender.accessibilityElements?[0] as? Story{
            
            
            let firstActivityItem = storyDetail.headline ?? ""
            let slug = storyDetail.slug ?? ""
            let url = baseUrl! + "/" + slug
            
            let secondActivityItem : NSURL = NSURL(string: url)!
            // If you want to put an image
            //            let image : UIImage = UIImage(named: "news")!
            
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
            
            // This lines is for the popover you need to show in iPad
            activityViewController.popoverPresentationController?.sourceView = sender
            
            // This line remove the arrow of the popover to show in iPad
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.unknown
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivityType.postToWeibo,
                UIActivityType.print,
                UIActivityType.assignToContact,
                UIActivityType.saveToCameraRoll,
                UIActivityType.addToReadingList,
                UIActivityType.postToFlickr,
                UIActivityType.postToVimeo,
                UIActivityType.postToTencentWeibo,
                UIActivityType.airDrop,
                UIActivityType.copyToPasteboard
            ]
            
            self.viewController?.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func authorDetailsButtonAction(sender:UIButton?){
        
        //        if let autherId = sender?.tag{
        //
        //            let authorController = AuthorController(autherId: autherId)
        //            self.viewController?.navigationController?.pushViewController(commentController, animated: true)
        //
        //        }
        
    }
    
    func openImage(sender:UITapGestureRecognizer){
        
        let imageView = sender.view as? UIImageView
        let imageViewController = ImageViewController(self.baseController!.qtObject, nibName:nil, bundle:nil)
        imageViewController.url = imageView?.accessibilityLabel
        self.viewController?.navigationController?.pushViewController(imageViewController, animated: true)
        
    }
    
    func summarytoggleButtonPressed(sender : UIButton){
        print(#function)
        
        showSummary = !showSummary

        collectionContext?.reload(in: self, at: IndexSet.init(integer: sender.tag))

//        collectionContext?.reload(self)
        
    }
    
    func didCalculateSize(indexPath: Int, size: CGSize, elementType: storyDetailLayoutType) {
        if elementType.rawValue == storyDetailLayoutType.storyDetailJsEmbbedElementCell.rawValue{
            self.jsEmbedCellHeight[indexPath] = size
        }else if elementType.rawValue == storyDetailLayoutType.storyDetailTwitterElementCell.rawValue{
            twitterCellheight[indexPath] = size
        }
        collectionContext?.reload(in: self, at: IndexSet(integer:indexPath))
        
    }
    
}
