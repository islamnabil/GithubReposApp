//
//  Repository.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 09/05/2021.
//

import Foundation

struct RepositoryModel:Codable {
    let id: Int
    let nodeId: String
    let name: String
    let fullName: String
    let isPrivate: Bool
    let owner: OwnerModel
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nodeId = "node_id"
        case name = "name"
        case fullName = "full_name"
        case isPrivate = "private"
        case owner = "owner"
    }
    
}

struct OwnerModel: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let received_eventsUrl: String
    let type: String
    let siteAdmin: Bool
    
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url = "url"
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gistsUrl"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case received_eventsUrl = "received_events_url"
        case type = "type"
        case siteAdmin = "site_admin"
    }
    
}
