//
//  HtmlRender.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/2/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation
import UIKit
import DTCoreText
import DTFoundation

extension UITextView{
    
    func convert(toHtml html:String,textOption:textOption){
        
        let options = textOption.value
        
//      let cleanString = html.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let cleanString = "<p>Here's what's true in Ron Howard's movie <em>A Beautiful Mind</em>—or, at least, here's what corresponds to Sylvia Nasar's biography of the same name: The mathematician John Forbes Nash Jr. attended graduate school at Princeton, where he was arrogant, childish, and brilliant. His doctoral thesis on the so-called \"<a href=\"http://william-king.www.drexel.edu/top/eco/game/nash.html\"><strong>Nash equilibrium</strong></a>\" revolutionized economics. Over time, he began to suffer delusions. He was hospitalized for paranoid schizophrenia, administered insulin shock therapy, and released. Afterward, Nash became a mysterious, ghostlike figure at Princeton. Eventually, through the support of his loving wife, his friends, and the force of his own will, he experienced a dramatic remission. In 1994, he won the Nobel Prize in economics, and to this day he keeps an office at Princeton.</p><p>A few things in the movie, of course, are just plain wrong—characters and scenes are compressed, events prettied up—but the fudges are mostly forgivable, given the difficulty of whittling a nearly 400-page book into a two-hour biopic. Nasar herself <a href=\"http://www.geocities.com/Hollywood/Cinema/1501/beautifulmind/sylvianasar.html\"><strong>believes</strong></a> that the filmmakers have \"invented a narrative that, while far from a literal telling, is true to the spirit of Nash's story.\" More troubling, though, are the filmmakers' lies of omission. Among the many important events from Nash's life they dropped:</p><p><strong>1. Homosexual experiences.</strong> Nash had recurring liaisons with other men. As an undergraduate, he once climbed into a friend's bed while the friend was sleeping and \"made a pass at him,\" Nasar writes. Nash also made a sexual overture toward John Milnor, a fellow mathematician with whom Nash lived one summer while working for the RAND Corporation think tank in Santa Monica, Calif. According to Nasar, \"What Nash felt toward Milnor may have been something very close to love.\"</p><p>Nash's first loves were one-sided infatuations with other men. He once kissed another friend, Donald Newman, on the mouth. According to Newman, \"He tried fiddling around with me. I was driving my car when he came on to me.\" Nash also had \"special friendships,\" in his own words, with two men. One of these was Nash's \"first experience of mutual attraction,\" Nasar writes. Of the other, she writes that they were \"friends—and then more than friends.\"</p><h2><strong>Get</strong> <em><strong>Slate</strong></em> <strong>in your inbox.</strong></h2><p>In 1954, Nash was arrested for indecent exposure in a bathroom in Santa Monica, which cost him his position at RAND. (He told his bosses that he was \"merely observing behavioral characteristics.\")</p><p><strong>2. An illegitimate child.</strong> Nash's other \"special friendship\" was with Eleanor Stier, a Boston nurse. In 1953, when Nash was 25, Eleanor bore him a son, John David Stier. (Nash's other son, who is depicted in the movie, is also named John.) Though single, Nash was unwilling to care for Eleanor or John, and John had to be placed in foster care for a time. In 1956, Eleanor was forced to hire a lawyer in order to get Nash to pay child support.</p><p>Nash saw John David occasionally until the child was six. Around John's senior year of high school, he and Nash began communicating by letter. Six years later, they met in person. Nash was still ill at the time and thought John Stier would play \"an essential and significant personal role in my personal long-awaited 'gay liberation,' \" according to a letter Nash wrote to a friend. The reunion \"petered out,\" Stier told Nasar. \"Having a mentally ill father was rather disturbing.\"</p><p>After a 17-year estrangement, John Stier and Nash met again. Nash criticized Stier's decision to become a nurse and urged him to go to medical school. He told Stier that it would be beneficial for his other son John (who also developed schizophrenia) to know his \"less intelligent older brother.\"</p><p><strong>3. Divorce.</strong> John Nash and Alicia Larde married in February 1957. Their son, John Charles Martin Nash, born May 20, 1959, remained nameless for a year.On the day after Christmas in 1962, Alicia filed for divorce. Her papers stated that Nash blamed her for twice committing him to a mental institution. He had moved into another room and refused to have sex with her for more than two years. By 1965, she hoped to marry another math professor, John Coleman Moore.</p><p>Nash moved in with Alicia again in 1970, and it's true that her patience and concern played a critical role in his recovery from schizophrenia. But she referred to him as her \"boarder,\" Nasar writes, and \"they lived essentially like two distantly related individuals under one roof\" until he won the Nobel Prize, when they renewed their relationship.</p><p>In the movie, Nash uses his Nobel Prize acceptance speech to pay tribute to Alicia. In reality, Nash was not asked to give a Nobel lecture, presumably because of his instability. He did, however, give a short speech at a small party in Princeton. Here is Nasar's synopsis:</p><blockquote>He was not inclined to give speeches, he said, but he had three things to say. First, he hoped that getting the Nobel would improve his credit rating because he really wanted a credit card. Second, he said that one is supposed to say that one is glad he is sharing the prize, but he wished he had won the whole thing because he really needed the money badly. Third, Nash said that he had won for game theory and that he felt that game theory was like string theory, a subject of great intrinsic intellectual interest that the world wishes to imagine can be of some utility. He said it with enough skepticism in his voice to make it funny.</blockquote><p>Are these episodes the whole story of John Nash? No. But neither is the movie.</p>"
        
        let data: Data? = cleanString.data(using: String.Encoding.utf8)
        
        let attrString:NSAttributedString = NSAttributedString.init(htmlData: data!, options: options, documentAttributes: nil)
        
        
        let mutableString = attrString.mutableCopy() as? NSMutableAttributedString
        
        let charSet = CharacterSet.whitespacesAndNewlines
        
        var someString = (mutableString?.string)! as NSString
        
        var range  = someString.rangeOfCharacter(from: charSet)
        
        while (range.length != 0 && range.location == 0)
        {
            mutableString?.replaceCharacters(in: range, with: "")
            someString = (mutableString?.string)! as NSString
            range = someString.rangeOfCharacter(from: charSet)
            
        }
        
        range = someString.rangeOfCharacter(from: charSet, options: .backwards)
        
        while (range.length != 0 && NSMaxRange(range) == someString.length)
        {
            
            mutableString?.replaceCharacters(in: range, with: "")
            someString = (mutableString?.string)! as NSString
            range = someString.rangeOfCharacter(from: charSet, options: .backwards)
        }
        
        self.attributedText = mutableString
    }

}

public enum textOption {
    
    case html
    case blockquote
    case quote
    case blurb
    case question
    case answer
    
    var value: [String : Any] {
        
        get{
            switch self {
                
            case .html:
                let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.storyHtmlTextFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.storyHtmlTextFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.storyHtmlTextFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.storyHtmlTextColor,
                    DTDefaultLinkColor:ThemeService.shared.theme.storyHtmlHyperLinkTextColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                    
                    ]
                
                return html
                
            case .blockquote:
               let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.blockquoteElementFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.blockquoteElementFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.blockquoteElementFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.blockQuoteElementColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                ]
                return html
                
            case .quote:
                
                let html:[String : Any?] = [
                
                DTUseiOS6Attributes:NSNumber.init(value: true),
                DTDefaultFontFamily:ThemeService.shared.theme.storyHtmlTextFont.familyName,
                DTDefaultFontName:ThemeService.shared.theme.storyHtmlTextFont.fontName,
                DTDefaultFontSize:ThemeService.shared.theme.storyHtmlTextFont.pointSize,
                DTDefaultTextColor:ThemeService.shared.theme.storyHtmlTextColor,
                DTDefaultLinkDecoration:"#D9241C",
                DTDefaultTextAlignment:"",
                DTDefaultLineHeightMultiplier:"1.2",
                
                ]
                return html
                
            case .blurb:
                
                let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.blurbElementFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.blurbElementFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.blurbElementFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.blurbElementColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                    
                ]
                return html
                
            case .question:
                let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.questionElementFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.questionElementFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.questionElementFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.questionElementColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                    
                    ]
                return html
                
            case .answer:
                let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.answerElementFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.answerElementFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.answerElementFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.answerElementColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                    ]
                
                return html
            }
        }
        
        
    }

}
