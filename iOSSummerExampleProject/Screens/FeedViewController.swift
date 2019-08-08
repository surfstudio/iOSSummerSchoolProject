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
    }

}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTestCell", for: indexPath) as? FeedTestCell else {
            return UITableViewCell()
        }
        cell.testLabel.text = "IndexPath: section:\(indexPath.section), row\(indexPath.row)"
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC")
////        self.present(vc, animated: true, completion: nil)
////        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
