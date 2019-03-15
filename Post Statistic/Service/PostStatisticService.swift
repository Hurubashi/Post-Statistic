//
//  PostStatisticService.swift
//  Post Statistic
//
//  Created by Max Rybak on 3/11/19.
//  Copyright © 2019 Max Rybak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostStatisticService {
 
    // Request for BasicPostInfo
    func requestBasicInfo(withId id: String, completion: @escaping (BasicPostInfo) -> Void) {
        
        let request     = PostRouter.basicInfo(id)
        makeRequest(request: request) { json in
            
            var basicInfo = BasicPostInfo()
            
            basicInfo.views         = json["views_count"].intValue
            basicInfo.likes         = json["likes_count"].intValue
            basicInfo.comments      = json["comments_count"].intValue
            basicInfo.reposts       = json["reposts_count"].intValue
            basicInfo.bookmarks     = json["bookmarks_count"].intValue
            
            completion(basicInfo)
        }
        
    }
    
    // Request for Users of any Category (likers, reposters etc.)
    func requestUsers(with request: PostRouter, completion: @escaping ([User]) -> Void) {
        
        makeRequest(request: request) { json in
            
            var result      = [User]()
            let array       = json["data"].arrayValue
            for elem in array {
                
                let imgUrlString    = elem["avatar_image"]["url_small"].stringValue
                let userId          = elem["id"].intValue
                let user            = User(id: userId, imgUrl: imgUrlString, imgData: nil)
                result              .append(user)
            }
            completion(result)
        }
    }
    
    func requestForImageData(urlString: String, completion: @escaping (Data) -> Void) {
        
        Alamofire.request(urlString).responseData { responce in
            
            if responce.response?.statusCode == 200, let value = responce.value {
                completion(value)
            }
            
        }
    }
    
    // Fucn that take request and return JSON result if it successful
    private func makeRequest(request: PostRouter, completion: @escaping (JSON) -> Void) {
        
        Alamofire.request(request).responseJSON { responce in
            
            if responce.response?.statusCode == 200, let value = responce.value {
                let json            = JSON(value)
                completion(json)
            }
        }
    }
    
}

