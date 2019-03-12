//
//  ViewController.swift
//  Post Statistic
//
//  Created by Max Rybak on 3/9/19.
//  Copyright © 2019 Max Rybak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let tableViewSections = ["Просмотры", "Лайки", "Комментаторы", "Отметки", "Репосты", "Закладки"]
    var postStatistic = PostStatistic()
    
    let id = "2720"
    override func viewDidLoad() {
        super.viewDidLoad()

        UIScreen.main.bounds.height
        
        let service = PostStatisticService()
        service.requestBasicInfo(withId: id) { [weak self] basicInfo in
            self?.postStatistic.basicInfo = basicInfo
            self?.tableView.reloadData()
        }
        
        service.request(for: .likers(id)){ [weak self] result in
            
            for elem in result {
                
                if !(self?.postStatistic.likersId.contains(elem.id) ?? true) {
                    self?.postStatistic.users.append(elem)
                }
                self?.postStatistic.likersId.append(elem.id)
            }
            
            print(self?.postStatistic.likersId)
        }
        
        service.request(for: .commentators(id)){ [weak self] users in
            
            for elem in users {
                if !(self?.postStatistic.commentatorsId.contains(elem.id) ?? true) {
                    self?.postStatistic.users.append(elem)
                }
                self?.postStatistic.commentatorsId.append(elem.id)
            }
            print(self?.postStatistic.commentatorsId)
        }
        
    }
    
    func addUsers(with: [User], to array: PostStatistic) {
        
    }

}

// MARK: - TableView Datasource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
//        cell.bounds = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: view.bounds.height / 4))
        cell.textLabel?.text = tableViewSections[indexPath.row]
        return cell
    }
    
    
    
    
}

