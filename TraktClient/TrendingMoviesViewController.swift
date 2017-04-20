//
//  TrendingMoviesViewController.swift
//  TraktClient
//
//  Created by David on 18/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
import IGListKit

class TrendingMoviesViewController:  UIViewController, IGListAdapterDataSource, UIScrollViewDelegate {
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView = IGListCollectionView(frame: .zero, collectionViewLayout: IGListGridCollectionViewLayout())
    lazy var items: [MediaObjectViewModel] = []
    var loading = false
    let spinToken = "spinner"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trending Movies"
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        getData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    //MARK: IGListAdapterDataSource
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        
        var objects = items as [IGListDiffable]
        
        if loading {
            objects.append(spinToken as IGListDiffable)
        }
        
        return objects
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if let obj = object as? String, obj == spinToken {
            return spinnerSectionController()
        } else {
            return ThumbMediaObjectSectionView()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !loading && distance < 200 {
            loading = true
            adapter.performUpdates(animated: true, completion: nil)
            getData()
        }
    }
   
    func getData() {
        let itemCount = items.count
        let itemsPerPage = 10
        let page = Pagination(page: (itemCount/itemsPerPage) + 1, limit: itemsPerPage)
        TrendingMovieService.trendingMovies(page: page, callback: { (mediaObjects) in
            self.items.append(contentsOf: mediaObjects)
            DispatchQueue.main.async {
                self.loading = false
                self.adapter.performUpdates(animated: true, completion: nil)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailMediaViewController" ,
            let detailView = segue.destination as? DetailMediaViewController ,
            let sectionView = sender as? ThumbMediaObjectSectionView {
            if let viewModel = sectionView.viewModel {
                detailView.viewModel = viewModel
            }
        }
    }
    
}
