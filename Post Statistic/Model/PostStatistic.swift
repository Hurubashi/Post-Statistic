//
//  PostStatistic.swift
//  Post Statistic
//
//  Created by Max Rybak on 3/11/19.
//  Copyright © 2019 Max Rybak. All rights reserved.
//

import Foundation
    
struct PostStatistic {
    
    // All users that have relation to PostStatistic
    var users                        : [User]    = []
    // Arrays with usersId by Categorie
    private(set) var likersId        : [Int]     = []
    private(set) var repostersId     : [Int]     = []
    private(set) var commentatorsId  : [Int]     = []
    private(set) var mentionedId     : [Int]     = []
    
    // Struct that contains basic info about post
    var basicInfo                    = BasicPostInfo()

    // Categories
    enum Caterorie {
        case likers
        case reposters
        case commentators
        case mentioned
    }
    
    // Func to add users that PostStatistic not yet have
    mutating func addUsers(with users: [User], to categorie: Caterorie) {
        
        var newUsersID : [Int] = []
        
        for user in users {
            if !self.users.contains(where: { $0.id == user.id }) {
                self.users.append(user)
            }
            newUsersID.append(user.id)
        }
        
        switch categorie {
        case .likers :
            likersId.append(contentsOf: newUsersID)
        case .reposters:
            repostersId.append(contentsOf: newUsersID)
        case .commentators:
            repostersId.append(contentsOf: newUsersID)
        case .mentioned:
            repostersId.append(contentsOf: newUsersID)
        }

    }
    
    func getUsers(ofCategory: Caterorie) -> [User] {
        switch ofCategory {
        case .likers :
            return usersWith(id: likersId)
        case .reposters:
            return usersWith(id: repostersId)
        case .commentators:
            return usersWith(id: commentatorsId)
        case .mentioned:
            return usersWith(id: mentionedId)
        }
    }
    
    private func usersWith(id array: [Int]) -> [User] {
        var result: [User] = []
        
        for user in users {
            if array.contains(user.id) {
                result.append(user)
            }
        }
        return result
    }
    
    
}

// Basic Post Info
struct BasicPostInfo {
    var views           : Int       = 0
    var likes           : Int       = 0
    var comments        : Int       = 0
    var marks           : Int       = 0
    var reposts         : Int       = 0
    var bookmarks       : Int       = 0
}

// Info about user
struct User {
    let id              : Int
    let imgUrl          : String
    var imgData         : Data?
}
