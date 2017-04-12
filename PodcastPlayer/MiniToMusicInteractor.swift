//
//  MiniToMusicInteractor.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 11/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

//
//  MiniToLargeViewInteractive.swift
//  DraggableViewController
//
//  Created by Jiri Ostatnicky on 18/05/16.
//  Copyright © 2016 Jiri Ostatnicky. All rights reserved.
//

import UIKit

class MiniToMusicInteractor: UIPercentDrivenInteractiveTransition {
    
    var viewController: UIViewController?
    var presentViewController: UIViewController?
    var pan: UIPanGestureRecognizer!
    var bottomHeight:CGFloat = 0
    var shouldComplete = false
    var lastProgress: CGFloat?
    var layerWindow:UIWindow?
    var toolbar:UIView?
    
    func attachToViewController(viewController: UIViewController, withView view: UIView, presentViewController: UIViewController?) {
        self.viewController = viewController
        self.presentViewController = presentViewController
        pan = UIPanGestureRecognizer(target: self, action: #selector(self.onPan(pan:)))
        view.addGestureRecognizer(pan)
    }
    
    func onPan(pan: UIPanGestureRecognizer) {
        
        let translation = pan.translation(in: pan.view?.superview)
        
        //Represents the percentage of the transition that must be completed before allowing to complete.
        let percentThreshold: CGFloat = 0.2
        //Represents the difference between progress that is required to trigger the completion of the transition.
        let automaticOverrideThreshold: CGFloat = 0.03
        
        let screenHeight: CGFloat = UIScreen.main.bounds.size.height - bottomHeight
        let dragAmount: CGFloat = (presentViewController == nil) ? screenHeight : -screenHeight
        var progress: CGFloat = translation.y / dragAmount
        
        progress = fmax(progress, 0)
        progress = fmin(progress, 1)
        
        switch pan.state {
        case .began:
            if let presentViewController = presentViewController {
                viewController?.present(presentViewController, animated: true, completion: nil)
            } else {
                viewController?.dismiss(animated: true, completion: nil)
            }
            toolbar?.isHidden = true
          
        case .changed:
            guard let lastProgress = lastProgress else {return}
            
            // When swiping back
            if lastProgress > progress {
                shouldComplete = false
                // When swiping quick to the right
            } else if progress > lastProgress + automaticOverrideThreshold {
                shouldComplete = true
            } else {
                // Normal behavior
                shouldComplete = progress > percentThreshold
            }
  
            update(progress)
            
        case .ended, .cancelled:
            if pan.state == .cancelled || shouldComplete == false {
                cancel()
                toolbar?.isHidden = false
          
            } else {
                finish()
            }
            
        default:
            break
        }
        
        lastProgress = progress
    }
}

