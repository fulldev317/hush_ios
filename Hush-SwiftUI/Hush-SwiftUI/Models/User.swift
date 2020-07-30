//
//  UserCodable.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 6/10/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct User: Codable {

    init() {
        id = "0"
    }
    var questions: [Question]?
    var id: String?
    var email: String?
    var payout: Int?
    var pendingPayout: String?
    var gender: String?
    var app: String?
    var superlike: String?
    var guest: String?
    var bioUrl: String?
    var moderator: String?
    var subscribe: String?
    var facebookId: String?
    var firstName: String?
    var name: String?
    var profilePhoto: String?
    var profilePhotoBig: String?
    var randomPhoto: String?
    var unreadMessagesCount: String?
    var story: String?
    var stories: String? //TODO
    var totalPhotos: String?
    var totalPhotosPublic: String?
    var totalPhotosPrivate: String?
    var totalLikers: String?
    var totalNoLikers: String?
    var myLikes: String?
    var totalLikes: Int?
    var totalFans: String?
    var likesPercentage: Int?
    var galleria: [Gallery]? //TODO
    var total_likes: String? //TODO repeated?
    var extended: Extended?
    var interest: [String]? //TODO
    var statusInfo: Int?
    var status: String?
    var city: String?
    var emailVerified: String?
    var country: String?
    var address: String?
    var age: String?
    var paypal: String?
    var latitude: String?
    var longitude: String?
    var birthday: String?
    var registerReward: String?
    var lastAccess: String?
    var admin: String?
    var username: String?
    var lang: String?
    var language: String?
    var looking: String?
    var hereFor: String?
    var premium: String?
    var newFans: String?
    var newVisits: String?
    var totalVisits: String?
    var totalMyLikes: String?
    var totalMatches: Int?
    var ip: String?
    //var premiumCheck: Int?
    var verified: String?
    var popular: String?
    var credits: String?
    var link: String?
    var online: String?
    var fake: String?
    var joinDate: String?
    var bio: String?
    var meet: String?
    var discover: String?
    var sGender: String?
    var sRadius: String?
    var sAge: String?
    var twitterId: String?
    var googleId: String?
    var instagramId: String?
    var onlineDay: String?
    var slike: String?
    var sage: String?
    var photos: [Photo]?
    var liked: Bool?
    var isFan: Int?
    var notifications: Notifications?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case questions = "question"
        case payout
        case pendingPayout
        case gender
        case app
        case superlike
        case guest
        case bioUrl = "bio_url"
        case moderator
        case subscribe
        case facebookId = "facebook_id"
        case firstName = "first_name"
        case name
        case profilePhoto = "profile_photo"
        case profilePhotoBig = "profile_photo_big"
        case randomPhoto = "random_photo"
        case unreadMessagesCount
        case story
        case stories
        case totalPhotos = "total_photos"
        case totalPhotosPublic = "total_photos_public"
        case totalPhotosPrivate = "total_photos_private"
        case totalLikers = "total_likers"
        case totalNoLikers = "total_nolikers"
        case myLikes = "mylikes"
        case totalLikes
        case likesPercentage = "likes_percentage"
        case galleria
        case total_likes
        case extended
        case interest
        case statusInfo = "status_info"
        case status
        case city
        case emailVerified = "email_verified"
        case country
        case address
        case age
        case paypal
        case latitude
        case longitude
        case birthday
        case registerReward
        case lastAccess = "last_access"
        case admin
        case username
        case lang
        case language
        case looking
        case hereFor = "here_for"
        case premium
        case newFans
        case newVisits
        case totalVisits
        case totalMyLikes
        case totalFans
        case totalMatches
        case ip
        //case premiumCheck = "premium_check"
        case verified
        case popular
        case credits
        case link
        case online
        case fake
        case joinDate = "join_date"
        case bio
        case meet
        case discover
        case sGender = "s_gender"
        case sRadius = "s_radius"
        case sAge = "s_age"
        case twitterId = "twitter_id"
        case googleId = "google_id"
        case instagramId = "instagram_id"
        case onlineDay = "online_day"
        case slike
        case sage
        case photos
        case isFan
        case notifications = "notification"
    }
   
    struct Extended: Codable {
        var uid: String?
        var field1: String?
        var field2: String?
        var field3: String?
        var field4: String?
        var field5: String?
        var field6: String?
        var field7: String?
        var field8: String?
        var field9: String?
        var field10: String?
    }
}

struct Gallery: Codable {
    var image: String?
    var photoId: String?
    var privated: String?
   
    enum CodingKeys: String, CodingKey {
        case image
        case photoId
        case privated = "private"
    }
}

struct Question: Codable {
     var id: String?
     var method: String?
     var question: String?
     var gender: String?
     var q_order: String?
     var userAnswer: String?
     var answers: [Answer]?

 }
 
 struct Answer: Codable {
    var id: String?
    var answer: String?
    var text: String?
}
