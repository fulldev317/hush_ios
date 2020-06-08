//
//  User.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 28/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    internal var questions: [Question]!
    internal var blockedProfiles: [String]! //TODO
    internal var id: String!
    internal var email: String!
    internal var payout: Int!
    internal var pendingPayout: String!
    internal var gender: String!
    internal var app: String!
    internal var superlike: String!
    internal var guest: String!
    internal var bioUrl: String!
    internal var moderator: String!
    internal var subscribe: String!
    internal var facebookId: String!
    internal var firstName: String!
    internal var name: String!
    internal var profilePhoto: String!
    internal var profilePhotoBig: String!
    internal var randomPhoto: String!
    internal var unreadMessagesCount: String!
    internal var story: String!
    internal var stories: [String]! //TODO
    internal var totalPhotos: String!
    internal var totalPhotosPublic: String!
    internal var totalPhotosPrivate: String!
    internal var totalLikers: String!
    internal var totalNoLikers: String!
    internal var myLikes: String!
    internal var totalLikes: Int!
    internal var likesPercentage: Int!
    internal var galleria: [String]! //TODO
    internal var total_likes: String! //TODO repeated?
    internal var extended: Extended!
    internal var interest: [String]! //TODO
    internal var statusInfo: Int!
    internal var status: String!
    internal var city: String!
    internal var emailVerified: String!
    internal var country: String!
    internal var age: String!
    internal var paypal: String!
    internal var latitude: String!
    internal var longitude: String!
    internal var birthday: String!
    internal var registerReward: String!
    internal var lastAccess: String!
    internal var admin: String!
    internal var username: String!
    internal var lang: String!
    internal var language: String!
    internal var looking: String!
    internal var premium: String!
    internal var newFans: String!
    internal var newVisits: String!
    internal var totalVisits: String!
    internal var totalMyLikes: String!
    internal var totalFans: String!
    internal var totalMatches: Int!
    internal var ip: String!
    internal var premiumCheck: Int!
    internal var verified: String!
    internal var popular: String!
    internal var credits: String!
    internal var link: String!
    internal var online: String!
    internal var fake: String!
    internal var joinDate: String!
    internal var bio: String!
    internal var meet: String!
    internal var discover: String!
    internal var sGender: String!
    internal var sRadius: String!
    internal var sAge: String!
    internal var twitterId: String!
    internal var googleId: String!
    internal var instagramId: String!
    internal var onlineDay: String!
    internal var slike: String!
    internal var sage: String!
    internal var photos: [Photo]!
    internal var notifications: Notifications!

    static func parseFromJson(_ json: JSON) -> User {
        let user = User()
        for (_, subJson):(String, JSON) in json["question"] {
            let question = Question.parseFromJson(subJson)
            user.questions.append(question)
        }
        //user.blockedProfiles = json["id"].string //TODO
        user.id = json["id"].string
        user.email = json["email"].string
        user.payout = json["payout"].int
        user.pendingPayout = json["pendingPayout"].string
        user.gender = json["gender"].string
        user.app = json["app"].string
        user.superlike = json["superlike"].string
        user.guest = json["guest"].string
        user.bioUrl = json["bio_url"].string
        user.moderator = json["moderator"].string
        user.subscribe = json["subscribe"].string
        user.facebookId = json["facebook_id"].string
        user.firstName = json["first_name"].string
        user.name = json["name"].string
        user.profilePhoto = json["profile_photo"].string
        user.profilePhotoBig = json["profile_photo_big"].string
        user.randomPhoto = json["random_photo"].string
        user.unreadMessagesCount = json["unreadMessagesCount"].string
        user.story = json["story"].string
        //user.stories = json["id"].string //TODO
        user.totalPhotos = json["total_photos"].string
        user.totalPhotosPublic = json["total_photos_public"].string
        user.totalPhotosPrivate = json["total_photos_private"].string
        user.totalLikers = json["total_likers"].string
        user.totalNoLikers = json["total_nolikers"].string
        user.myLikes = json["mylikes"].string
        user.totalLikes = json["totalLikes"].int
        user.likesPercentage = json["likes_percentage"].int
        //user.galleria = json["id"].string //TODO
        user.total_likes = json["total_likes"].string
        user.extended = Extended.parseFromJson(json["extended"])
        //user.interest = json["id"].string //TODO
        user.statusInfo = json["status_info"].int
        user.status = json["status"].string
        user.city = json["city"].string
        user.emailVerified = json["email_verified"].string
        user.country = json["country"].string
        user.age = json["age"].string
        user.paypal = json["paypal"].string
        user.latitude = json["lat"].string
        user.longitude = json["lng"].string
        user.birthday = json["birthday"].string
        user.registerReward = json["registerReward"].string
        user.lastAccess = json["last_access"].string
        user.admin = json["admin"].string
        user.username = json["username"].string
        user.lang = json["lang"].string
        user.language = json["language"].string
        user.looking = json["looking"].string
        user.premium = json["premium"].string
        user.newFans = json["newFans"].string
        user.newVisits = json["newVisits"].string
        user.totalVisits = json["totalVisits"].string
        user.totalMyLikes = json["totalMyLikes"].string
        user.totalFans = json["totalFans"].string
        user.totalMatches = json["totalMatches"].int
        user.ip = json["ip"].string
        user.premiumCheck = json["premium_check"].int
        user.verified = json["verified"].string
        user.popular = json["popular"].string
        user.credits = json["credits"].string
        user.link = json["link"].string
        user.online = json["online"].string
        user.fake = json["fake"].string
        user.joinDate = json["join_date"].string
        user.bio = json["bio"].string
        user.meet = json["meet"].string
        user.discover = json["discover"].string
        user.sGender = json["s_gender"].string
        user.sRadius = json["s_radius"].string
        user.sAge = json["s_age"].string
        user.twitterId = json["twitter_id"].string
        user.googleId = json["google_id"].string
        user.instagramId = json["instagram_id"].string
        user.onlineDay = json["online_day"].string
        user.slike = json["slike"].string
        user.sage = json["sage"].string
        for (_, subJson):(String, JSON) in json["photos"] {
            let photo = Photo.parseFromJson(subJson)
            user.photos.append(photo)
            if (user.photos.count == 3) {
                break
            }
        }
        user.notifications = Notifications.parseFromJson(json["notification"])
        return user
    }

    class Question {
        
        internal var id: String!
        internal var method: String!
        internal var gender: String!
        internal var qOrder: String!
        internal var userAnswer: String!
        internal var answers: [Answer]!
        
        static func parseFromJson(_ json: JSON) -> Question {
            let question = Question()
            question.id = json["id"].string
            question.method = json["method"].string
            question.gender = json["gender"].string
            question.qOrder = json["q_order"].string
            question.userAnswer = json["userAnswer"].string
            for (_, subJson):(String, JSON) in json["answers"] {
                let answer = Answer.parseFromJson(subJson)
                question.answers.append(answer)
            }
            return question
        }
        
        class Answer {
            
            internal var id: String!
            internal var answer: String!
            internal var text: String!
            
            static func parseFromJson(_ json: JSON) -> Answer {
                let answer = Answer()
                answer.id = json["id"].string
                answer.answer = json["answer"].string
                answer.text = json["text"].string
                return answer
            }
        }
    }
    
    class Extended {
        
        internal var uid: String!
        internal var field1: String!
        internal var field2: String!
        internal var field3: String!
        internal var field4: String!
        internal var field5: String!
        internal var field6: String!
        internal var field7: String!
        internal var field8: String!
        internal var field9: String!
        internal var field10: String!

        static func parseFromJson(_ json: JSON) -> Extended {
            let extended = Extended()
            extended.uid = json["uid"].string
            extended.field1 = json["field1"].string
            extended.field2 = json["field2"].string
            extended.field3 = json["field3"].string
            extended.field4 = json["field4"].string
            extended.field5 = json["field5"].string
            extended.field6 = json["field6"].string
            extended.field7 = json["field7"].string
            extended.field8 = json["field8"].string
            extended.field9 = json["field9"].string
            extended.field10 = json["field10"].string
            return extended
        }
    }
}
