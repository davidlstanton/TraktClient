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
    @IBOutlet private weak var titleLabel: UILabel!
    
    func setCell(with mediaObject: MediaObjectViewModel) {
        imageView.af_setImage(withURLRequest: FanArtAssetRouter.preview(urlString: mediaObject.thumbUrlString))
    }
}
