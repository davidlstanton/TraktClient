//
//  ThumbMediaObjectSectionView.swift
//  TraktClient
//
//  Created by David on 18/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
import IGListKit

class ThumbMediaObjectSectionView: IGListSectionController, IGListSectionType {
    
    var viewModel: MediaObjectViewModel?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        let ccw = collectionContext!.containerSize.width
        let width = (ccw/2.0)
        return CGSize(width: width, height: width * 0.66)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: "ThumbMediaObjectCell", bundle: nil, for: self, at: index) as! ThumbMediaObjectCell
        if let viewModel = viewModel {
            cell.setCell(with: viewModel)
        }
        return cell
    }
    
    func didUpdate(to object: Any) {
        if let object = object as? MediaObjectViewModel {
            self.viewModel = object
        }
    }
    
    func didSelectItem(at index: Int) {
        self.viewController!.performSegue(withIdentifier: "detailMediaViewController", sender: self)
    }
}
