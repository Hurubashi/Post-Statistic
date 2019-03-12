//
//  PostStatistic.swift
//  Post Statistic
//
//  Created by Max Rybak on 3/11/19.
//  Copyright © 2019 Max Rybak. All rights reserved.
//

import Foundation

struct PostStatistic {
    
    var users           : [User]    = []
    var likersId        : [Int]     = []
    var repostersId     : [Int]     = []
    var commentatorsId  : [Int]     = []
    var markedId        : [Int]     = []
    
    var basicInfo                   = BasicPostInfo()

}

struct BasicPostInfo {
    var views           : Int       = 0
    var likes           : Int       = 0
    var comments        : Int       = 0
    var marks           : Int       = 0
    var reposts         : Int       = 0
    var bookmarks       : Int       = 0
}

struct User {
    let id              : Int
    let imgUrl          : String
    var imgData         : Data?
}
