//
//  FacebookAPIManager.swift
//  LoginScreen
//
//  Created by Florian Marcu on 1/15/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import UIKit

import FacebookCore
import FacebookLogin

let kGraphPathMe = "me"
let kGraphPathMePageLikes = "me/likes"

class FacebookAPIManager {

    let accessToken: AccessToken
    let networkingManager = NetworkingManager()

    init(accessToken: AccessToken) {
        self.accessToken = accessToken
    }

    func requestFacebookUser(completion: @escaping (_ facebookUser: FacebookUser) -> Void) {
        let graphRequest = GraphRequest(graphPath: kGraphPathMe, parameters: ["fields":"id,email,last_name,first_name,picture"], accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion)
        graphRequest.start { (response: HTTPURLResponse?, result: GraphRequestResult<GraphRequest>) in
            switch result {
            case .success(let graphResponse):
                if let dictionary = graphResponse.dictionaryValue {
                    completion(FacebookUser(dictionary: dictionary))
                }
                break
            default:
                print("Facebook request user error")
            }
        }
    }

    func requestFacebookUserPageLikes() {
        let graphRequest = GraphRequest(graphPath: kGraphPathMePageLikes, parameters: [:], accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion)
        graphRequest.start { (response: HTTPURLResponse?, result: GraphRequestResult<GraphRequest>) in
            print (result)
        }
    }

    func requestWallPosts(completion: @escaping (_ posts: [FacebookPost]) -> Void) {
        let graphRequest = GraphRequest(graphPath: "me/posts", parameters: ["fields":"link,created_time,description,picture,name","limit":"500"], accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion)

        graphRequest.start { (response: HTTPURLResponse?, result: GraphRequestResult<GraphRequest>) in
            switch result {
            case .success(let graphResponse):
                if let dictionary = graphResponse.dictionaryValue {
                    self.processWallPostResponse(dictionary: dictionary, posts: [], completion: completion)
                    return
                }
            default: break
            }
            completion([])
        }
    }

    private func processWallPostResponse(dictionary: [String: Any?], posts: [FacebookPost], completion: @escaping (_ posts: [FacebookPost]) -> Void) {
        var newPosts = [FacebookPost]()
        if let array = dictionary["data"] as? [[String: String]] {
            for dict in array {
                let fbPost = FacebookPost(dictionary: dict)
                newPosts.append(fbPost)
            }
        }
        guard let paging = dictionary["paging"] as? [String: String], let next = paging["next"] as String?, next.characters.count > 0 else {
            completion(posts + newPosts)
            return
        }
        networkingManager.get(path: next, params: [:], completion: { (jsonResponse, responseStatus) in
            switch responseStatus {
            case .success:
                guard let jsonResponse = jsonResponse, let dictionary = jsonResponse as? [String: Any] else {
                    completion(posts + newPosts)
                    return
                }
                self.processWallPostResponse(dictionary: dictionary, posts: posts + newPosts, completion: completion)
            case .error(_):
                completion(posts + newPosts)
            }
        })
    }
}
