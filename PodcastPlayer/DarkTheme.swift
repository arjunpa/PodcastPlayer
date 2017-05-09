//
//  PrimaryTheme.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/3/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation

public struct DarkTheme:Theme{
    
    public var backgroundColor: UIColor = UIColor(hexString: "#303030")
    public var tintColor: UIColor = UIColor(hexString: "#FFCF00")
    public var navigationBarTintColor: UIColor? = UIColor(hexString: "#404040")
    public var navigationBarTranslucent: Bool = false
    
    public var navigationTitleColor: UIColor = UIColor.white
    public var headlineColor: UIColor { return UIColor.white }
    public var bodyTextColor: UIColor { return UIColor.white }
    
    //MARK:- DashBoard Screen(Read Screen)
    
    //Header
    public var sectionTitleColor:UIColor = UIColor(hexString: "#000000")
    public var sectionTitleFont:UIFont = Fonts.listTopSectionFont
    
    
    public var headerTitleColor:UIColor = UIColor(hexString: "#000000")
    public var headerTitleFont:UIFont = Fonts.listTopHeadlineFont
    
    //List
    public var normalListSectionColor:UIColor = UIColor(hexString: "#000000")
    public var normalListSectionFont:UIFont = Fonts.listNormalSectionFont
    
    public var normalListTitleColor:UIColor = UIColor(hexString: "#000000")
    public var normalListTitleFont:UIFont = Fonts.listNormalHeadlineFont
    
    //MARK:- Detail Screen(Story Detail Screen)
    
    
    
    public var storyHtmlHyperLinkTextColor: UIColor = UIColor()
    
    public var imageCaptionFont:UIFont = UIFont.systemFont(ofSize: 14)
    public var imageCaptionTextColor:UIColor = UIColor()
    
    public var blockQuoteElementColor: UIColor = UIColor()
    
    public var quoteAttributtionColor:UIColor = UIColor()
    
    public var blurbElementColor: UIColor = UIColor()
    
    
    
    
    //MARK:- Functions
    
    
    
    //Dedication View
    public var dedicationViewGradientColors:[UIColor] = []
    
   public var dedicationTitleColor:UIColor = UIColor()
   public var dedicationTitleFont:UIFont = UIFont.systemFont(ofSize: 14)
    
   public var dedicationRequestButtonColor:UIColor = UIColor()
   public var dedicationRequestButtonTitle:UIFont = UIFont.systemFont(ofSize: 14)
    
    //MARK:- Initializers
    public init() {}
    
}

