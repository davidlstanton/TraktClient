//
//  ImageService.swift
//  TraktClient
//
//  Created by David on 19/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import AlamofireImage

class ImageService {

    let downloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache())
    
    func setImage(with urlRequest: URLRequest, imageView: UIImageView, filter: ImageFilter?, completion: ((BackendError?)->())?) throws {
        
        downloader.download(urlRequest,
                            receiptID: "",
                            filter: filter,
                            progress: nil,
                            progressQueue: .main) { response in
                                
                                if let error = response.error {
                                    if let completion = completion {
                                        completion(error as? BackendError)
                                    }
                                }
                                
                            let toImage = UIImage(named:"myname.png")
                            UIView.transition(with: imageView,
                                              duration: 0.3,
                                              options: .transitionCrossDissolve,
                                              animations: {
                                                imageView.image = toImage
                            },
                                              completion: nil)
                                if let completion = completion {
                                    completion(nil)
                                }
                            }
        var array = ["d", "b"]
        array.removeLast()
        }
    
}
