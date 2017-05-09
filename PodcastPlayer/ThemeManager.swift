//
//  ThemeManager.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/3/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import UIKit

public protocol Theme {
    var backgroundColor: UIColor { get }
    var tintColor: UIColor { get }
    
    var navigationBarTintColor: UIColor? { get }
    var navigationBarTranslucent: Bool { get }
    
    var navigationTitleFont: UIFont { get }
    var navigationTitleColor: UIColor { get }
    
    var primaryColor:UIColor{get}
    
    //MARK:- DashBoard Screen(Read Screen)
    
    //Header
    var sectionTitleColor:UIColor {get}
     var sectionTitleFont:UIFont {get}
     
    
     var headerTitleColor:UIColor {get}
     var headerTitleFont:UIFont {get}
    
    //List
     var normalListTitleFont:UIFont {get}
     var normalListSectionColor:UIColor {get}
    
     var normalListSectionFont:UIFont{get}
     var normalListTitleColor:UIColor{get} 
    
    //Dedication View
    var dedicationViewGradientColors:[UIColor]{get}
    
    var dedicationTitleColor:UIColor{get}
    var dedicationTitleFont:UIFont{get}
    
    var dedicationRequestButtonColor:UIColor{get}
    var dedicationRequestButtonTitle:UIFont{get}
    
    //DetailScreen
    var storyHeadlineColor:UIColor{get}
    var storyHeadlineFont:UIFont{get}
    
    var storySubheadlineColor:UIColor{get}
    var storySubheadlineFont:UIFont{get}
    
    var storyHtmlTextColor:UIColor{get}
    var storyHtmlTextFont:UIFont{get}
    var storyHtmlHyperLinkTextColor:UIColor{get}
    
    var imageCaptionFont:UIFont{get}
    var imageCaptionTextColor:UIColor{get}
    
    var blockquoteElementFont:UIFont{get}
    var blockQuoteElementColor:UIColor{get}
    
    var quoteAttributtionColor:UIColor{get}
    
    var blurbElementFont:UIFont{get}
    var blurbElementColor:UIColor{get}
    
    var questionElementFont:UIFont{get}
    var questionElementColor:UIColor{get}
    
    var answerElementFont:UIFont{get}
    var answerElementColor:UIColor{get}
    
    var commentBackgroundCollor:UIColor{get}
    
    
    var relatedStoriesSectionTitleFont:UIFont{get}
    
    
}

extension Theme{
    public var backgroundColor: UIColor { return UIColor(hexString: "#ffffff") }
    public var tintColor: UIColor { return UIColor(hexString : "#007aff") }
    
    public var navigationBarTintColor: UIColor? { return nil }
    public var navigationBarTranslucent: Bool { return true }
    
    public var navigationTitleFont: UIFont { return UIFont.boldSystemFont(ofSize: 17.0) }
    public var navigationTitleColor: UIColor { return UIColor.black }
    
    public var primaryColor:UIColor{return UIColor(hexString:"#121212")}
    
    //MARK:- DashBoard Screen(Read Screen)
    
    //Header
    public var sectionTitleColor:UIColor { return UIColor(hexString: "#000000")}
    public var sectionTitleFont:UIFont { return UIFont.boldSystemFont(ofSize: 14.0)}
    
    
    public var headerTitleColor:UIColor { return UIColor(hexString: "#000000")}
    public var headerTitleFont:UIFont { return UIFont.boldSystemFont(ofSize: 18.0)}
    
    //List
    
    public var normalListSectionColor:UIColor  {  return UIColor(hexString: "#000000")}
    public var normalListSectionFont:UIFont  { return UIFont.boldSystemFont(ofSize: 12.0)}
    
    public var normalListTitleColor:UIColor  {  return UIColor(hexString: "#000000")}
    public var normalListTitleFont:UIFont { return UIFont.boldSystemFont(ofSize: 12.0)}
    
    //Dedication View
    public var  dedicationViewGradientColors:[UIColor]{return [UIColor(hexString: "#ffffff"), UIColor(hexString: "#000000")]}
    
    
    //Detail Screen
   public var storyHeadlineColor:UIColor{  return UIColor(hexString: "#000000")}
   public var storyHeadlineFont:UIFont{ return UIFont.boldSystemFont(ofSize: 12.0)}
    
   public var storySubheadlineColor:UIColor{  return UIColor(hexString: "#000000")}
   public var storySubheadlineFont:UIFont{ return UIFont.boldSystemFont(ofSize: 12.0)}
    
    public var storyHtmlTextColor:UIColor{  return UIColor(hexString: "#000000")}
   public var storyHtmlTextFont:UIFont{ return UIFont.boldSystemFont(ofSize: 12.0)}
    
    
    public var blockquoteElementFont:UIFont { return Fonts.storyBoldQuoteElementFont}
    
    public var blurbElementFont:UIFont {return Fonts.blurbElementFont}
    
    public var questionElementFont:UIFont{return Fonts.questionElementFont}
    public var questionElementColor:UIColor{return UIColor(hexString:"#000000")}
    
    public var answerElementFont:UIFont {return Fonts.answerElementFont}
    public var answerElementColor:UIColor{return UIColor(hexString:"#000000")}
    
    public var commentBackgroundCollor:UIColor{return UIColor.white}
    
    public var relatedStoriesSectionTitleFont:UIFont{return Fonts.relatedStoryTitle}
    
    
    
    public func applyBackgroundColor(views:[UIView]){
        views.forEach({
            $0.backgroundColor = backgroundColor
        })
    }
    
    public func applyHeadlineStyle(labels: [UILabel]) {
        labels.forEach {
            $0.font = sectionTitleFont
            $0.textColor = sectionTitleColor
        }
    }
    
    public func applyBodyTextStyle(labels: [UILabel]) {
        labels.forEach {
            $0.font = normalListTitleFont
            $0.textColor = normalListSectionColor
        }
    }
    
    
}
