//
//  PodcastPlayerViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 03/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Soundcloud
import IGListKit


class PodcastPlayerViewController: BaseViewController {
    
    var presentInteractor:MiniToMusicInteractor = {
       let interactor = MiniToMusicInteractor.init()
       return interactor
    }()
    var dismissInteractor:MiniToMusicInteractor = {
        let interactor = MiniToMusicInteractor.init()
        return interactor
    }()
    var tracks:[TrackWrapper] = []
    fileprivate var _index:Int = 0
    @IBOutlet weak var collection_view:IGListCollectionView!
    lazy var igAdaptor:IGListAdapter = {
        return IGListAdapter.init(updater: IGListAdapterUpdater.init(), viewController: self, workingRangeSize: 0)
    }()
    required init(_ qtObject:QTGlobalProtocol = QTGlobalInstance.init(tdAttributes: nil), nibName:String?, bundle:Bundle?){
        super.init(qtObject, nibName: nibName, bundle: bundle)
        self.configureSCClient()
        
    }
    
    
    func configurCollectionView(){
        self.collection_view.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        self.collection_view.collectionViewLayout = UICollectionViewFlowLayout()
        igAdaptor.collectionView = self.collection_view
        igAdaptor.dataSource = self
    }
    
    func configureSCClient(){
        SoundcloudClient.clientSecret = "esv5NccmUd0wRgyFgUojqMiNBwM9nZhl"
        SoundcloudClient.clientIdentifier = "fs2FkPBdYj7aNns0zJqgi8ZmR7CAXaBw"
        SoundcloudClient.redirectURI = ""
        
        let queries: [SearchQueryOptions] = [
            .queryString("malayalam"),
            .types([TrackType.live, TrackType.demo])
        ]
        Track.search(queries: queries) {[weak self] (response:PaginatedAPIResponse<Track>) in
            
            guard let weakSelf = self else{return}
           let tracksd = response.response.result ?? []
            weakSelf.tracks = tracksd.map({ (track:Track) -> TrackWrapper in
                return TrackWrapper.init(track: track)
            })
            DispatchQueue.main.async(execute: { 
                self?.igAdaptor.reloadData(completion: nil)
            })
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.configurCollectionView()
        self.qtObject.playerManager.dataSource = self
          self.prepare()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
    func prepare(){
        let nextViewController = NextControllerViewController.init(nibName:"NextControllerViewController", bundle:nil)
        nextViewController.rootViewController = self
        nextViewController.transitioningDelegate = self
        nextViewController.modalPresentationStyle = .fullScreen
        
        presentInteractor = MiniToMusicInteractor()
        presentInteractor.attachToViewController(viewController: self, withView: self.musicLayerController!.view, presentViewController: nextViewController)
//        dismissInteractor = MiniToMusicInteractor()
//        dismissInteractor.attachToViewController(nextViewController, withView: nextViewController.view, presentViewController: nil)
    }
    


}
extension PodcastPlayerViewController:IGListAdapterDataSource{
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return self.tracks
    }
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        
        let controller = TracksSectionController.init()
        controller.delegate = self
        return controller
    }
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}

extension PodcastPlayerViewController:TracksSectionControllerDelegate{
    func sectionIndexSelected(controller: IGListSectionController, index: Int) {
        self._index = index
    }
}

extension PodcastPlayerViewController:PlayerManagerDataSource{
    func playerManagerDidReachEndOfCurrentItem(manager:PlayerManager){
    
    }
    func playerManagerShoulMoveToNextItem(manager:PlayerManager) -> Bool{
        if _index < self.tracks.count - 1{
            return true
        }
        return false
    }
    
     func playerManagerShoulMoveToPreviousItem(manager:PlayerManager) -> Bool{
        
        if _index > 0{
            return true
        }
        return false
    }
    
    func playerManagerDidAskForNextItem(manager:PlayerManager) -> URL?{
        _index += 1
        return tracks[_index].track.streamURL
    }
    func playerManagerDidAskForPreviousItem(manager:PlayerManager) -> URL?{
        _index -= 1
         return tracks[_index - 1].track.streamURL
    }
}
extension PodcastPlayerViewController:UIViewControllerTransitioningDelegate{
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        let animator = MiniToMusicAnimator.init()
        let snapshotView = snapShot()
        animator.initialY = self.musicLayerController?.toolbar.sizeFit().height ?? 0
        animator.transitionType = .Present
        animator.snapshotCompletion = {(animator) -> UIView in
            return snapshotView
        }
        return animator
    }
    
    func snapShot()->UIView{
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.main.scale)
        self.musicLayerController!.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageView:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.musicLayerController?.toolbar.sizeFit().height ?? 0))
        imageView.image = image
        return imageView
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        let animator = MiniToMusicAnimator.init()
        animator.initialY = self.musicLayerController?.toolbar.sizeFit().height ?? 0
        animator.transitionType = .Dismiss
        animator.snapshotCompletion = {(animator) -> UIView in
            UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.main.scale)
            self.musicLayerController!.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let imageView:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.musicLayerController?.toolbar.sizeFit().height ?? 0))
            imageView.image = image
            return imageView
        }
        return animator
        
    }
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        
        presentInteractor.layerWindow = self.musicLayerController!.view.window!
        presentInteractor.toolbar = self.musicLayerController!.toolbar
        return presentInteractor
    }
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        
        return nil
    }
}

