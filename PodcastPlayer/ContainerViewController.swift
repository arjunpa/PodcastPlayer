//
//  ContainerViewController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/20/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class ContainerViewController: BaseViewController {
    
    private var animator : ARNTransitionAnimator?
    fileprivate var modalVC : NextControllerViewController!
    
    var podController:PodcastPlayerViewController!
    var layerController : MusicLayerController!
    var miniPlayerView : UIView!
    
    var tabBar :UIToolbar = {
       let tool = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50))
        
        return tool
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layerController = MusicLayerController.init(qtObject, nibName: "MusicLayerController", bundle: nil)

        
        podController = PodcastPlayerViewController.init(qtObject, nibName: "PodcastPlayerViewController", bundle: nil)
        
        podController.musicLayerController = layerController
        self.musicLayerController = layerController
        miniPlayerView = layerController.view
        let nc = UINavigationController(rootViewController: podController)
        addViewController(anyController: nc)
        
        
        
        addViewController(anyController: layerController)
        
        self.view.addSubview(tabBar)
        
        
        setupAnimator()
    }
    
    
    override func loadView() {
        super.loadView()
        self.view = UIView(frame: UIScreen.main.bounds)
        
    }
    
    func setupAnimator() {
        modalVC = NextControllerViewController.init(nibName:"NextControllerViewController", bundle:nil) as? NextControllerViewController
        
        self.modalVC.modalPresentationStyle = .overFullScreen
        
        let animation = MusicPlayerTransitionAnimation(rootVC: self, modalVC: self.modalVC)
        
        animation.completion = { [weak self] isPresenting in
            if isPresenting {
                guard let _self = self else { return }
                let modalGestureHandler = TransitionGestureHandler(targetVC: _self, direction: .bottom)
                modalGestureHandler.registerGesture(_self.modalVC.view)
                modalGestureHandler.panCompletionThreshold = 15.0
                _self.animator?.registerInteractiveTransitioning(.dismiss, gestureHandler: modalGestureHandler)
            } else {
                self?.setupAnimator()
            }
        }
        
        let gestureHandler = TransitionGestureHandler(targetVC: self, direction: .top)
        gestureHandler.registerGesture((self.musicLayerController?.toolbar)!)
        gestureHandler.panCompletionThreshold = 15.0
        
        self.animator = ARNTransitionAnimator(duration: 0.5, animation: animation)
        self.animator?.registerInteractiveTransitioning(.present, gestureHandler: gestureHandler)
        
        self.modalVC.transitioningDelegate = self.animator
    }
  }
