//
//  UIImageViewExtension.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/19/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import KingfisherWebP
import Quintype

enum imageType:String{
    
    case webp = "webp"
    case gif = "gif"
    
    
}


extension UIImageView{
    
    func foucsPointConverter(image:UIImage,metaData:ImageMetaData,targetSize:CGSize) -> UIImage{
        
        
        let originalImageSize = CGSize(width: (metaData.width?.intValue)!, height: (metaData.height?.intValue)!)
        let originalFocusPoints = CGPoint(x: (metaData.focus_point?[0].intValue)!, y: (metaData.focus_point?[1].intValue)!)
        
        let downloadedImageSize = image.size
        let downloadedScaleWidth = downloadedImageSize.width / originalImageSize.width
        let downloadedScaleHeight = downloadedImageSize.height / originalImageSize.height
        let downloadedScale = max(downloadedScaleWidth, downloadedScaleHeight)
        
        let downloadedFocusPoint = CGPoint(x: downloadedScale * originalFocusPoints.x, y: downloadedScale * originalFocusPoints.y)
        let drawingRect = CGRect(x: 0.0, y: 0.0, width: downloadedImageSize.width, height: downloadedImageSize.height)
        
        if (drawingRect.width < targetSize.width) || (drawingRect.height < targetSize.height) {
            //size of the image is less than target window, delegate to super
            return image
        }
        
        UIGraphicsBeginImageContext(downloadedImageSize)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        //we need to flip the image because core graphics and image have different origins
        let flip: CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: -1.0);
        let flipThenShift: CGAffineTransform = flip.translatedBy(x: 0, y: -downloadedImageSize.height);
        context.saveGState()
        context.concatenate(flipThenShift);
        
        //draw image
        context.draw(image.cgImage!, in: drawingRect)
        context.restoreGState()
        
        let downloadedImageWithFocusPoint = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        var cropRect = CGRect(x: downloadedFocusPoint.x - (targetSize.width)/2, y: downloadedFocusPoint.y - (targetSize.height)/2, width: targetSize.width, height: targetSize.height)
        
        //is crop rect going beyong left edge ?
        if cropRect.origin.x < 0 {
            cropRect.origin.x = 0
        }
        if ((cropRect.origin.x +  cropRect.width) > drawingRect.width) {
            cropRect.origin.x = cropRect.origin.x + (drawingRect.width - (cropRect.origin.x +  cropRect.width))
        }
        
        if cropRect.origin.y < 0 {
            cropRect.origin.y = 0
        }
        if ((cropRect.origin.y +  cropRect.height) > drawingRect.height) {
            cropRect.origin.y = cropRect.origin.y + (drawingRect.height - (cropRect.origin.y +  cropRect.height))
        }
        
        let imageRef: CGImage? =  downloadedImageWithFocusPoint?.cgImage?.cropping(to: cropRect)
        let cropped: UIImage = UIImage(cgImage: imageRef!, scale: 0.0, orientation: downloadedImageWithFocusPoint!.imageOrientation)
        return cropped
        
    }
    
    public func loadImage(url:String,targetSize:CGSize,imageMetaData:ImageMetaData? = nil,placeholder:UIImage? = nil,animation:ImageTransition = .none){
        
        self.kf.indicatorType = .activity
        let url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "about:blank"
        let convertedUrl = URL(string: url)!
        var componetns:URLComponents = URLComponents.init(url: convertedUrl, resolvingAgainstBaseURL: false)!
        componetns.fragment = nil
        componetns.query = nil
        if let mineType = componetns.url?.pathExtension.lowercased(){
            
            
            
            
            switch mineType{
                
            case imageType.gif.rawValue :
                self.kf.setImage(with: convertedUrl, options: [.transition(animation)], completionHandler: { (image, error, cache, url) in
                    
                    
                    
                })
                
                break
                
            case imageType.webp.rawValue :
                self.kf.setImage(with: convertedUrl, options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)], completionHandler: { (image, error, cache, url) in
                    
                    
                    
                })
                
                break
                
            default:
                
                if let imageDetails = imageMetaData{
                    
                    if (imageDetails.width != nil) && (imageDetails.height != nil){
                        
                        if let focusPoints = imageDetails.focus_point{
                            
                            if focusPoints.count == 2{
                                
                                if convertedUrl != nil{
                
                                    let imageView = UIImageView()
                                    imageView.kf.setWebPImage(with: convertedUrl, placeholder: nil, options:  [.transition(animation)], progressBlock: nil, completionHandler: { (image, error, cache, url) in
                                        
                                        if let downloadedImage = image{
                                         self.image = self.foucsPointConverter(image:downloadedImage, metaData: imageMetaData!, targetSize: targetSize)
                                        }
                                        
                                    })

                                }
                                
                            }else{
                                let resize = ResizingImageProcessor(targetSize: targetSize)
                                self.kf.setImage(with: convertedUrl, placeholder: placeholder, options: [.transition(animation),.processor(resize)], completionHandler: { (image, error, cache, url) in})
                            }
                            
                        }else{
                            let resize = ResizingImageProcessor(targetSize: targetSize)
                            self.kf.setImage(with: convertedUrl, placeholder: placeholder, options: [.transition(animation),.processor(resize)], completionHandler: { (image, error, cache, url) in })
                        }
                        
                        
                    }else{
                        let resize = ResizingImageProcessor(targetSize: targetSize)
                        self.kf.setImage(with: convertedUrl, placeholder: placeholder, options: [.transition(animation),.processor(resize)], completionHandler: { (image, error, cache, url) in })
                    }
                    
                    
                    
                }else{
                    let resize = ResizingImageProcessor(targetSize: targetSize)
                    self.kf.setImage(with: convertedUrl, placeholder: placeholder, options: [.transition(animation),.processor(resize)], completionHandler: { (image, error, cache, url) in })
                }
                
                self.kf.indicatorType = .activity
                
                break
                
                
            }
        }
    }
    
    
}


extension UIViewController{
    
    public func clearUnusedImagesfromCache(){
        
        ImageCache.default.clearMemoryCache()
        ImageCache.default.cleanExpiredDiskCache()
        
    }
    
}
