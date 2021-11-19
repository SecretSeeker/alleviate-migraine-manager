//
//  ViewController.swift
//  WelcomeScreens
//
//  Created by Gurleen Kaur on 08/11/21.
//

import UIKit

struct PageContainerModel {
    var reuseIdentifier: String
    var nibName: String
    var className: AnyClass

    init(reuseIdentifier: String, nibName: String, className: AnyClass) {
        self.reuseIdentifier = reuseIdentifier
        self.nibName = nibName
        self.className = className
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageControllerView: PageControllerView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    var welcomePageDataprovider: WelcomePageDataProviderType = WelcomePageDataProvider()
    var dataSource = [AppTourModel]()
    
    let WelcomeCollectionViewCellID = "WelcomeCollectionViewCell"


    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = welcomePageDataprovider.getData(fileName: "AppTourScreens",
                                                     bundle: Bundle(for: type(of: self)))
        setupUI()

    }
    
    private func setupUI() {
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        let pageContent = [PageContainerModel(reuseIdentifier: "WelcomeCollectionViewCell",
                                                    nibName: "WelcomeCollectionViewCell",
                                                    className: WelcomeCollectionViewCell.self)]
        pageControllerView?.setPageViewDataSource(dataSource: self,
                                                        delegate: self,
                                                        collectionViewCells: pageContent,
                                                        itemsCount: dataSource.count,
                                                        withCouroselEffectSpacing: 0,
                                                        edgeInsets: .zero)

        pageControl.numberOfPages = dataSource.count
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "UserEntires", bundle: nil)
//        guard let symptomsViewController = storyboard.instantiateViewController(withIdentifier:
//            "SymptomsViewController") as? SymptomsViewController else {
//            return
//        }
//        symptomsViewController.provider = SymptomsDataProvider()
//        self.navigationController?.pushViewController(symptomsViewController, animated: true)
//    }
        let storyboard = UIStoryboard(name: "UserEntires", bundle: nil)
                guard let symptomsViewController = storyboard.instantiateViewController(withIdentifier:
                    "SymptomsViewController") as? SymptomsViewController else {
                    return
}

                let navigationController = UINavigationController(rootViewController: symptomsViewController)



        //        let appdelegate = UIApplication.shared.delegate as! AppDelegate


        //        appdelegate.window?.rootViewController = navigationController

                symptomsViewController.provider = SymptomsDataProvider()



                UIApplication.shared.windows.first?.rootViewController = navigationController



                UIApplication.shared.windows.first?.makeKeyAndVisible()



               // self.navigationController?.pushViewController(symptomsViewController, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WelcomeCollectionViewCellID,
            for: indexPath
            ) as? WelcomeCollectionViewCell else {
                return UICollectionViewCell()
        }
        collectionCell.setCellDetails(dataSource[indexPath.row])
        return collectionCell
    }
}

extension ViewController: PageControllerViewDelegate {
    func didPageChangedWithPageCount(pageCount: Int, isPrevious: Bool, isNext: Bool) {
        pageControl.currentPage = pageCount
    }
}

