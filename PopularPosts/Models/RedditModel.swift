//
//  RedditModel.swift
//  PopularPosts
//
//  Created by Ismael Bautista on 11/8/22.
//

import Foundation

struct ResultsPosts: Decodable {
    let kind: String
    let data:ResultChildren
}

struct ResultChildren: Decodable{
    let after: String
    let children:[Posts]
}

struct Posts: Decodable{
    let kind:String
    let data:Post
}

struct Post: Decodable{
    let title:String
    let author:String
    let created:Int
    let subredditNamePrefixed:String
    let url:URL
    let thumbnail:URL
    let postHint:String?
    let numComments: Int
}

