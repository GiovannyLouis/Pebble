//
//  AddTaskModel.swift
//  Pebble
//
//  Created by Deny Wahyudi Asaloei  on 09/04/26.
//

import Foundation

struct Task: Identifiable{
    var id = UUID() //untuk id unik tiap object
    var name: String
    var notes: String
    var dueDate: Date
    var category: Category
}

enum Category:String,CaseIterable, Identifiable{
    case none = "None"
    case healthcare = "Healthcare"
    case scienceMath = "Science & Math"
    case creativeArtDesign = "Creative Art & Design"
    case socialBehavioural = "Social & Behavioural"
    case businessFinance = "Business & Finance"
    case educationTeaching = "Education & Teaching"
    case law = "Law"
    case engineering = "Engineering"
    
    var id: Self { self }
}
