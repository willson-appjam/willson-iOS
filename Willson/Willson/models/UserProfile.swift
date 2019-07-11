//
//  UserProfile.swift
//  Willson
//
//  Created by 박지수 on 11/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - UserProfile
struct UserProfile: Codable {
    let code: Int
    let message: String
    let data: UserProfileData
}

// MARK: - DataClass
struct UserProfileData: Codable {
    let user: User
    let userPersonality: [Personality]
    let question: UserQuestion
    
    enum CodingKeys: String, CodingKey {
        case user
        case userPersonality = "user_personality"
        case question
    }
}

// MARK: - Question
struct UserQuestion: Codable {
    let categoryName, categoryListName: String
    let weight: Int
    let content, helperGender: String
    let advise, emotion, experience: Int
    let questionPersonality: [Personality]
    let questionFeeling: [QuestionFeeling]
    let questionExperience: [QuestionExperience]
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case categoryListName = "categoryList_name"
        case weight, content
        case helperGender = "helper_gender"
        case advise, emotion, experience
        case questionPersonality = "question_personality"
        case questionFeeling = "question_feeling"
        case questionExperience = "question_experience"
    }
}

// MARK: - QuestionExperience
struct QuestionExperience: Codable {
    let experienceName: String
    
    enum CodingKeys: String, CodingKey {
        case experienceName = "experience_name"
    }
}

// MARK: - QuestionFeeling
struct QuestionFeeling: Codable {
    let feelingName: String
    
    enum CodingKeys: String, CodingKey {
        case feelingName = "feeling_name"
    }
}

// MARK: - Personality
struct Personality: Codable {
    let personalityName: String
    
    enum CodingKeys: String, CodingKey {
        case personalityName = "personality_name"
    }
}

// MARK: - User
struct User: Codable {
    let nickname, gender, age: String
}
