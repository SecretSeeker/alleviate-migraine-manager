//
//  PageControllerView.swift
//  WelcomeScreens
//
//  Created by Gurleen Kaur on 08/11/21.
//

import UIKit

/// Protocol used to provide state of page in PageControllerView
@objc protocol PageControllerViewDelegate {
    @objc func didPageChangedWithPageCount(pageCount: Int, isPrevious: Bool, isNext: Bool)
}

/// Custom class which is used to enable the functionality of Pagview.
/// Collection view is used to provide pagination effect.
class PageControllerView: UIView {

    /// Collection View used for adding pagination as cells
    var collectionView: UICollectionView!
    /// Instance of PageControllerViewDelegate used for giving event of page chnaged
    private weak var delegate: PageControllerViewDelegate?
    /// Get number of items that is used. This will be used to make logic for buttons state
    private  var itemsCount: Int = 0
    // for courosel effect spacing, default is with no courosel effect i.e 0
    private var distanceBetweenPages: CGFloat = 0
    var currentPageCount = 0

    /// This will be used to initialize pageview
    ///
    /// - Parameters:
    ///   - _dataSource: Datasource used for collectionview which is passed from parent view
    ///   - _delegate: Instance of PageControllerViewDelegate used for giving event of page chnaged
    ///   - _itemsCount: Get number of items that is used
    ///   - collectionViewCells: Array of PageContainerModel which contains details of Collectionview Cells
    func setPageViewDataSource(dataSource: UICollectionViewDataSource,
                               delegate: PageControllerViewDelegate,
                               collectionViewCells: [PageContainerModel],
                               itemsCount: Int,
                               withCouroselEffectSpacing: CGFloat = 0,
                               edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)) {
        distanceBetweenPages = withCouroselEffectSpacing
        addCollectionView(edgeInsets: edgeInsets)
        collectionView.dataSource = dataSource
        self.delegate = delegate
        self.itemsCount = itemsCount
       _ =  collectionViewCells.map { (cell) in
        let nibFile = UINib(nibName: cell.nibName, bundle: nil)
            collectionView.register(nibFile, forCellWithReuseIdentifier: cell.reuseIdentifier)
        }
        collectionView.reloadData()
    }

    /// function used to add collection view
    private func addCollectionView(edgeInsets: UIEdgeInsets) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = -distanceBetweenPages
        layout.minimumLineSpacing = -distanceBetweenPages
        layout.sectionInset = edgeInsets
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = self.backgroundColor
        self.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
    }

    /// This func will to used to scroll collection view to specific page
    ///
    /// - Parameter indexValue: Index value to which collection view need to scrolled
    func scrolltoIndexValue(indexValue: Int, isAnimated: Bool) {
        guard indexValue >= 0, indexValue < itemsCount  else {
            return
        }
        let indexPath = IndexPath(row: indexValue, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: isAnimated)
        collectionView.isPagingEnabled = true
        collectionViewScrolledWithPageValue(currentPage: indexValue)
    }

    /// This func will be used to calling the delegate when pagination happened
    ///
    /// - Parameter currentPage: Page to which collection view is scrolled
    fileprivate func collectionViewScrolledWithPageValue(currentPage: Int) {
        currentPageCount = currentPage
        if currentPage <= 0 {
            delegate?.didPageChangedWithPageCount(pageCount: currentPage, isPrevious: false, isNext: true)
        } else if currentPage >= itemsCount-1 {
            delegate?.didPageChangedWithPageCount(pageCount: currentPage, isPrevious: true, isNext: false)
        } else {
            delegate?.didPageChangedWithPageCount(pageCount: currentPage, isPrevious: true, isNext: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout and UICollectionViewDelegate functions
extension PageControllerView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width-(4*distanceBetweenPages), height: self.frame.height)
    }

    internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = lroundf(Float(scrollView.contentOffset.x / scrollView.frame.width))
        collectionViewScrolledWithPageValue(currentPage: currentPage)
        scrolltoIndexValue(indexValue: currentPage, isAnimated: true)
    }
}
