//
//  PrimaryTheme.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/3/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation

public struct PrimaryTheme:Theme{
    
    public var backgroundColor: UIColor = UIColor(hexString: "#ffffff")
    public var tintColor: UIColor = UIColor(hexString: "#FFCF00")
    public var navigationBarTintColor: UIColor? = UIColor(hexString: "#404040")
    public var navigationBarTranslucent: Bool = false
    
    public var navigationTitleColor: UIColor = UIColor.white
    public var headlineColor: UIColor { return UIColor.white }
    public var bodyTextColor: UIColor { return UIColor.white }
    
    //MARK:- DashBoard Screen(Read Screen)
    
    //Header
    public var sectionTitleColor:UIColor = UIColor(hexString:"#f95f00")
    public var sectionTitleFont:UIFont = Fonts.listTopSectionFont
    
    
    public var headerTitleColor:UIColor = UIColor(hexString:"#121212")
    public var headerTitleFont:UIFont = Fonts.listTopHeadlineFont
    
    //List
    public var normalListSectionColor:UIColor = UIColor(hexString:"#f95f00")
    public var normalListSectionFont:UIFont = Fonts.listNormalSectionFont
    
    public var normalListTitleColor:UIColor = UIColor(hexString:"#121212")
    public var normalListTitleFont:UIFont = Fonts.listNormalHeadlineFont
    
    
    
    
    
    //MARK:- Functions
    
  
    //MARK:- Dedication
   public var dedicationViewGradientColors:[UIColor] = [UIColor(hexString: "#fad961").withAlphaComponent(0.62),UIColor(hexString:"#f76b1c").withAlphaComponent(0.49)]
    
    public var dedicationTitleColor:UIColor = UIColor(hexString:"#232323")
    public var dedicationTitleFont:UIFont = Fonts.RequestDedicationTitle
    
    public var dedicationRequestButtonColor:UIColor = UIColor(hexString:"#f95f00")
    public var dedicationRequestButtonTitle:UIFont = Fonts.ButtonTitle
    
    //MARK:- Detail Screen(Story Detail Screen)
    
    public var storyHeadlineColor: UIColor = UIColor(hexString:"#121212")
    public var storyHeadlineFont: UIFont = Fonts.listTopHeadlineFont
    
    public var storySubheadlineColor: UIColor = UIColor(hexString:"#4a4a4a")
    public var storySubheadlineFont: UIFont = Fonts.subheadLineFont
    
    public var storyHtmlTextColor:UIColor = UIColor(hexString:"#4a4a4a")
    public var storyHtmlTextFont: UIFont = Fonts.storyHtmlBodyTextFont
    public var storyHtmlHyperLinkTextColor:UIColor = UIColor(hexString:"#f44807")
    
    public var imageCaptionFont:UIFont = Fonts.CaptionElementFont
    public var imageCaptionTextColor:UIColor = UIColor(hexString:"#858585")
    
    public var blockQuoteElementColor:UIColor = UIColor(hexString:"#fb7f32")
    
    
    public var quoteAttributtionColor:UIColor = UIColor(hexString:"#fb7f32")
    
    public var blurbElementColor: UIColor = UIColor(hexString:"#4a4a4a")
    
    public var questionElementColor: UIColor = UIColor(hexString:"#4a4a4a")
    
    public var answerElementColor: UIColor = UIColor(hexString:"#4a4a4a")
    
    public var relatedStoriesSectionTitleFont: UIFont = Fonts.relatedStoryTitle
    
    
    //MARK:- Initializers
    public init() {}
    
}

