//
//  CreateExpensesRequest.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation

struct CreateExpensesRequest: Codable {
    
    var title    : String? = nil
    var date     : String? = nil
    var amount   : Int?    = nil
    var category : String? = nil
    var location : String? = nil
    var notes    : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case title    = "title"
        case date     = "date"
        case amount   = "amount"
        case category = "category"
        case location = "location"
        case notes    = "notes"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title    = try values.decodeIfPresent(String.self , forKey: .title    )
        date     = try values.decodeIfPresent(String.self , forKey: .date     )
        amount   = try values.decodeIfPresent(Int.self    , forKey: .amount   )
        category = try values.decodeIfPresent(String.self , forKey: .category )
        location = try values.decodeIfPresent(String.self , forKey: .location )
        notes    = try values.decodeIfPresent(String.self , forKey: .notes    )
        
    }
    
    init() {
        
    }
    
}
