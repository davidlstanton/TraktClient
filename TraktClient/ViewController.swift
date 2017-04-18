//
//  ViewController.swift
//  TraktClient
//
//  Created by David on 06/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
import IGListKit
import Alamofire

class ViewController: UIViewController, IGListAdapterDataSource, UIScrollViewDelegate {
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView = IGListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var items: [StandardMediaObject] = []
    var loading = false
    let spinToken = "spinner"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
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
            return LabelSectionController()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !loading && distance < 200 {
            loading = true
            adapter.performUpdates(animated: true, completion: nil)
            let itemCount = items.count
            let itemsPerPage = 10
            let page = Pagination(page: (itemCount/itemsPerPage) + 1, limit: itemsPerPage)
            Alamofire.request(TraktRouter.moviesTrending(pagination: page, extendedInfo: .full)).responseCollection {
                (response: DataResponse<[StandardMediaObject]>) in
                if let standardMediaObjects = response.result.value {
                    self.items.append(contentsOf: standardMediaObjects)
                    DispatchQueue.main.async {
                        self.loading = false
                        self.adapter.performUpdates(animated: true, completion: nil)
                    }
//                    standardMediaObjects.forEach {
//                        Alamofire.request(FanArtRouter.movie(ids: $0.ids)).responseObject {
//                            (response: DataResponse<MovieMediaObjectImages>) in
//                            if let mediaObjects = response.result.value {
//                                print(mediaObjects.description)
//                            }
//                        }
//                    }
                    
                }
            }
            
            
//            DispatchQueue.global(qos: .default).async {
//                // fake background loading task
//                sleep(2)
//                DispatchQueue.main.async {
//                    self.loading = false
//                    let itemCount = self.items.count
//                    self.items.append(contentsOf: Array(itemCount..<itemCount + 5))
//                    self.adapter.performUpdates(animated: true, completion: nil)
//                }
//            }
        }
    }
    
}

final class LabelSectionController: IGListSectionController, IGListSectionType {
    
    private var object: StandardMediaObject?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: LabelCell.self, for: self, at: index) as! LabelCell
        cell.text = object?.title
        return cell
    }
    
    func didUpdate(to object: Any) {
        if let object = object as? StandardMediaObject {
            self.object = object
        }
    }
    
    func didSelectItem(at index: Int) {}
}

final class LabelCell: UICollectionViewCell {
    
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
    fileprivate static let font = UIFont.systemFont(ofSize: 17)
    
    static var singleLineHeight: CGFloat {
        return font.lineHeight + insets.top + insets.bottom
    }
    
    static func textHeight(_ text: String, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: width - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [ NSFontAttributeName: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height) + insets.top + insets.bottom
    }
    
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = LabelCell.font
        return label
    }()
    
    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1).cgColor
        return layer
    }()
    
    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.layer.addSublayer(separator)
        contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        label.frame = UIEdgeInsetsInsetRect(bounds, LabelCell.insets)
        let height: CGFloat = 0.5
        let left = LabelCell.insets.left
        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
    
}

