//
//  DetailMediaViewController.swift
//  TraktClient
//
//  Created by David on 18/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
import IGListKit

class DetailMediaViewController:  UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MediaObjectViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(mediaObject: viewModel)
        configureTitleLabel(mediaObject: viewModel)
    }
    
    func configure(mediaObject: MediaObjectViewModel) {
        
        overviewLabel.text = mediaObject.overview
        ratingLabel.text = "Rating: \(mediaObject.rating)"
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.af_setImage(withURLRequest: FanArtAssetRouter.full(urlString: mediaObject.posterUrlString), placeholderImage: UIImage(), filter: nil, progress: nil, progressQueue: .global(qos: .default), imageTransition: UIImageView.ImageTransition.crossDissolve(0.2), runImageTransitionIfCached: false) { (_) in
            DispatchQueue.main.async {
                
            }
        }
    }
    
    func configureTitleLabel(mediaObject: MediaObjectViewModel) {
        let label = UILabel(frame: CGRect(x:0, y:0, width:480, height:50))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        //label.textColor = UIColor.white
        label.text = mediaObject.title
        self.navigationItem.titleView = label
    }
}
