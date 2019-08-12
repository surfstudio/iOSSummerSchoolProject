//
//  FeedViewController.swift
//  iOSSummerExampleProject
//
//  Created by xcode on 08.08.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

enum FeedSegue: String {
    case photo = "showDetails"
    case collection = "showCollection"
}

class FeedViewController: UIViewController {

    // MARK: - Nested types

    private enum Constants {
        static let headerHeight: CGFloat = 250
        static let navBarHiddenBreakpoint: CGFloat = 200
    }
    
    private enum Sections: Int {
        case headerCell
        case categoriesCell
        case photosCell
    }
    
    @IBOutlet weak var tableView: UITableView!

    var isStatusBarLight: Bool = true
    
    var collections: [CollectionEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationController?.designTransparent()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let offset = tableView.contentOffset.y
        navigationController?.setNavigationBarHidden(offset >= Constants.navBarHiddenBreakpoint, animated: false)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isStatusBarLight ? .lightContent : .default
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let feedSegue = FeedSegue(rawValue: segue.identifier ?? "") else {
            return
        }
        switch feedSegue {
        case .photo:
            break
        case .collection:
            break
        }
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FeedHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FeedHeaderView")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FeedHeaderCell {
            cell.handleScroll(offset: offset)
        }
        isStatusBarLight = offset < Constants.headerHeight
        setNeedsStatusBarAppearanceUpdate()

        navigationController?.setNavigationBarHidden(offset >= Constants.navBarHiddenBreakpoint, animated: true)
    }
    
    func loadData() {
        let service = BaseService()
        service.getFeaturedCollections(
            onCompleted: { (collections) in
                DispatchQueue.main.async {
                    self.collections = collections
                    self.tableView.reloadData()
                }
            },
            onError: { (error) in
                print("error: \(error)")
            }
        )
    }

}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = Sections(rawValue: section) else {
            return 0
        }
        switch sectionType {
        case .headerCell, .categoriesCell:
            return 1
        case .photosCell:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = Sections(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch sectionType {
        case .headerCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedHeaderCell", for: indexPath) as? FeedHeaderCell else {
                return UITableViewCell()
            }
            return cell
        case .categoriesCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCategoriesCell", for: indexPath) as? FeedCategoriesCell else {
                return UITableViewCell()
            }
            cell.configure(collections: collections)
            return cell
        case .photosCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? ImageTableCell else {
                return UITableViewCell()
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sectionType = Sections(rawValue: indexPath.section) else {
            return 0.0
        }
        switch sectionType {
        case .headerCell:
            return 250.0
        case .categoriesCell:
            return 138.0
        case .photosCell:
            return 250.0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = Sections(rawValue: section) else {
            return nil
        }
        switch sectionType {
        case .categoriesCell:
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FeedHeaderView") as? FeedHeaderView else {
                return nil
            }
            view.configure(title: "Explore")
            return view
        case .photosCell:
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FeedHeaderView") as? FeedHeaderView else {
                return nil
            }
            view.configure(title: "New")
            return view
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionType = Sections(rawValue: section) else {
            return 0.0
        }
        switch sectionType {
        case .headerCell:
            return 0.0
        case .categoriesCell, .photosCell:
            return 66.0
        }
    }
}
