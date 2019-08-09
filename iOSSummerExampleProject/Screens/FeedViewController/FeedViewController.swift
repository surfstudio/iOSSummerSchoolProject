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
}

class FeedViewController: UIViewController {
    
    private enum Sections: Int {
        case headerCell
        case categoriesCell
    }
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello World"
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let feedSegue = FeedSegue(rawValue: segue.identifier ?? "") else {
            return
        }
        switch feedSegue {
        case .photo:
            let vc = segue.destination as? PhotoViewController
            vc?.indexPath = tableView.indexPathForSelectedRow
        }
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FeedHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FeedHeaderView")
    }

}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = Sections(rawValue: section) else {
            return 0
        }
        switch sectionType {
        case .headerCell, .categoriesCell:
            return 1
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
        case .categoriesCell:
            return 66.0
        }
    }
}
