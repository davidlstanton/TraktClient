//
//  ThumbMediaObjectCell.swift
//  TraktClient
//
//  Created by David on 18/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
import AlamofireImage

class ThumbMediaObjectCell: UICollectionViewCell {
        
    @IBOutlet private weak var imageView: UIImageView!
    
    func setCell(with mediaObject: MediaObjectViewModel) {
        
        translatesAutoresizingMaskIntoConstraints = true;
        imageView.contentMode = .scaleAspectFit
        
        imageView.af_setImage(withURLRequest: FanArtAssetRouter.preview(urlString: mediaObject.thumbUrlString), placeholderImage: UIImage(), filter: nil, progress: nil, progressQueue: .global(qos: .default), imageTransition: UIImageView.ImageTransition.crossDissolve(0.2), runImageTransitionIfCached: false) { (_) in
            DispatchQueue.main.async {
                
            }
        }
    }
    
}
