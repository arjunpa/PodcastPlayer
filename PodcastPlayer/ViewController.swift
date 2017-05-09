//
//  ViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 03/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    let kPlayerPlusTabHeight:CGFloat = 155
    var tabbar : TabBarController!
    var musicPlayer : MusicLayerController!
    
    var disableInteractivePlayerTransitioning = false
    
    var nextViewController: NextControllerViewController!
    var presentInteractor: MiniToLargeViewInteractive!
    var dismissInteractor: MiniToLargeViewInteractive!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpChildViewControllers()
      
    }
    
    func setUpChildViewControllers(){
         tabbar = TabBarController(nibName: "TabBarController", bundle: nil)
        addViewController(anyController: tabbar)
        
        prepareMusicPlayerView()
    }
    
    func prepareMusicPlayerView(){
        //add music player
        musicPlayer = MusicLayerController.init(qtObject, nibName: "MusicLayerController", bundle: nil)
        self.addViewController(anyController: self.musicPlayer)
       
//        let taprecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnMusicPlayer(_:)))
//        musicPlayer.toolbar.playerTappableArea.addGestureRecognizer(taprecognizer)
        
        //configureNextController
//        nextViewController = NextControllerViewController.init(nibName:"NextControllerViewController", bundle:nil)
        
        nextViewController = NextControllerViewController.init(qtObject, nibName: "NextControllerViewController", bundle: nil)
        nextViewController.rootViewController = self
        nextViewController.transitioningDelegate = self
        nextViewController.modalPresentationStyle = .fullScreen
        
        presentInteractor = MiniToLargeViewInteractive()
        
        presentInteractor.attachToViewController(viewController: self, withView: musicPlayer.toolbar.playerTappableArea, presentViewController: nextViewController)
        
        dismissInteractor = MiniToLargeViewInteractive()
        
        dismissInteractor.attachToViewController(viewController: nextViewController, withView: nextViewController.view, presentViewController: nil)
        
    }
    
    func didTapOnMusicPlayer(_ sender:UITapGestureRecognizer){
        disableInteractivePlayerTransitioning = true
        self.present(nextViewController, animated: true) { 
            self.disableInteractivePlayerTransitioning = false
        }
    }
}

extension ViewController:UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = MiniToMusicAnimator()
        
        animator.tabBarFrame = self.tabbar.tabBar.frame
        animator.initialY = kPlayerPlusTabHeight
        animator.transitionType = .Present
        let snapshot = snapShot()
        
        animator.musicSnapShot = { () -> UIView in
                return snapshot
        }
        
        return animator
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = MiniToMusicAnimator()
        
        animator.tabBarFrame = self.tabbar.tabBar.frame
        animator.initialY = kPlayerPlusTabHeight
        animator.transitionType = .Dismiss
        let snapshot = snapShot()
        
        animator.musicSnapShot = { () -> UIView in
            return snapshot
        }
        
        return animator
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard !disableInteractivePlayerTransitioning else { return nil }
        return presentInteractor
    }
    
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard !disableInteractivePlayerTransitioning else { return nil }
        return dismissInteractor
    }
    
    func snapShot() -> UIView{
        
        UIGraphicsBeginImageContextWithOptions(self.musicPlayer.view.frame.size, false, UIScreen.main.scale)
        self.musicPlayer.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageView:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.musicPlayer?.toolbar.sizeFit().height ?? 0))
        imageView.image = image
        return imageView
        
    }
}
