//
//  MiniToMusicAnimator.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 11/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class MiniToMusicAnimator: BaseAnimator {
    
    
    var initialY : CGFloat = 0
    var tabBarFrame : CGRect!
    
    var musicSnapShot : (() -> (UIView))?
    
    
    override func animatePresentingInContext(context: UIViewControllerContextTransitioning, sourceController: UIViewController, destinationController: UIViewController) {
        
        let fromRect = context.initialFrame(for: sourceController)
        var toRect = fromRect
        toRect.origin.y = toRect.size.height - initialY
        
        destinationController.view.frame = toRect
        
        let container = context.containerView
        
//        var playerView : UIView!
        
//        if let unwrappedPlayerView = musicSnapShot?(){
//            destinationController.view.addSubview(unwrappedPlayerView)
//            playerView = unwrappedPlayerView
//        }
        
        container.addSubview(sourceController.view)
        container.addSubview(destinationController.view)
        
        
        
        let animationOption:UIViewAnimationOptions = context.isInteractive ? [UIViewAnimationOptions.curveLinear] : []
        
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, options: animationOption, animations: {
            destinationController.view.frame = fromRect
//            playerView.alpha = 0
            
            
        }) { (isFinished) in
//            playerView.removeFromSuperview()
            
            if context.transitionWasCancelled{
                context.completeTransition(false)
            }else{
                context.completeTransition(true)
            }
        }
    }
    
    override func animateDismissingInContext(context: UIViewControllerContextTransitioning, sourceController: UIViewController, destinationController: UIViewController) {
        
        var fromRect = context.initialFrame(for: sourceController)
        fromRect.origin.y = fromRect.size.height - initialY
        
        let container = context.containerView
        
        var playerView :UIView!
        
        if let unwrappedPlayerView = musicSnapShot?(){
            sourceController.view.addSubview(unwrappedPlayerView)
            unwrappedPlayerView.alpha = 0
            playerView = unwrappedPlayerView
        }
        
        container.addSubview(destinationController.view)
        container.addSubview(sourceController.view)
        
        let animationOption:UIViewAnimationOptions = context.isInteractive ? [UIViewAnimationOptions.curveLinear] : []
        
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, options: animationOption, animations: {
            sourceController.view.frame = fromRect
            playerView.alpha = 1
            
        }) { (isFinished) in
            playerView.removeFromSuperview()
            if context.transitionWasCancelled{
                context.completeTransition(false)
            }else{
                context.completeTransition(true)
            }
        }
    }
    
    
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionContext!.isInteractive ? 0.4 : 0.3
    }

}
