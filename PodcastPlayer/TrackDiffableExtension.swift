//
//  TrackDiffableExtension.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 05/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import Soundcloud
import IGListKit

extension NSObject:IGListDiffable{
    public func diffIdentifier() -> NSObjectProtocol{
        return self
    }
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool{
        return isEqual(object)
    }
    
}
