//
//  PostStatisticVC.swift
//  Post Statistic
//
//  Created by Max Rybak on 3/9/19.
//  Copyright © 2019 Max Rybak. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class PostStatisticVC: UIViewController {
  
    // Outlets
    @IBOutlet var oneLineStatisticView          : [OneLineStatisticView]!
    @IBOutlet var usersCollectionView           : [UsersHorizontalCollectionView]!
    
    // Variables
    let id          = "2720"
    var statistic   = PostStatistic()
    let group       = DispatchGroup()
    let service     = PostStatisticService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillTextLabels()
        service.requestBasicInfo(withId: id) { [weak self] basicInfo in
            
            self?.statistic.basicInfo = basicInfo
  
            self?.loadLikers()
            self?.loadCommentators()
            self?.loadMentioned()
            
            self?.group.notify(queue: .main) {
                self?.loadUserImages()
            }
        }
        
    }

    func fillTextLabels() {
        oneLineStatisticView[0].statsticName.text = "Просмотры" + " " + "\(statistic.basicInfo.views)"
        oneLineStatisticView[1].statsticName.text = "Репосты" + " " + "\(statistic.basicInfo.reposts)"
        oneLineStatisticView[2].statsticName.text = "Закладки" + " " + "\(statistic.basicInfo.bookmarks)"
        
        usersCollectionView[0].oneLineStatisticView.statsticName.text = "Лайки" + " " + "\(statistic.basicInfo.likes)"
        usersCollectionView[1].oneLineStatisticView.statsticName.text = "Комментаторы" + " " + "\(statistic.commentatorsId.count)"
        usersCollectionView[2].oneLineStatisticView.statsticName.text = "Отметки" + " " + "\(statistic.basicInfo.marks)"
    }
    
    func loadLikers() {
        group.enter()
        service.requestUsers(with: .likers(id)){ [weak self] result in
            self?.statistic.addUsers(with: result, to: .likers)
            self?.group.leave()
        }
    }
    
    func loadCommentators() {
        group.enter()
        service.requestUsers(with: .commentators(id)){ [weak self] result in
            self?.statistic.addUsers(with: result, to: .commentators)
            self?.group.leave()
        }
    }
    
    func loadMentioned() {
        group.enter()
        service.requestUsers(with: .mentions(id)){ [weak self] result in
            self?.statistic.addUsers(with: result, to: .mentioned)
            self?.group.leave()
        }
    }
    
    func loadUserImages() {
        
        let gg = statistic.users.count
        var i = 0
        for user in statistic.users {
            service.requestForImageData(urlString: user.imgUrl) { data in
                self.statistic.users[i].imgData = data
                i += 1
                if i == gg {
                    self.usersCollectionView[0].users = self.statistic.getUsers(ofCategory: .likers)
                    self.usersCollectionView[0].collectionView.reloadData()
                    
                    self.usersCollectionView[1].users = self.statistic.getUsers(ofCategory: .commentators)
                    self.usersCollectionView[1].collectionView.reloadData()
                    
                    self.usersCollectionView[2].users = self.statistic.getUsers(ofCategory: .mentioned)
                    self.usersCollectionView[2].collectionView.reloadData()
                    
                    self.fillTextLabels()
                }
            }
        }

    }

}


