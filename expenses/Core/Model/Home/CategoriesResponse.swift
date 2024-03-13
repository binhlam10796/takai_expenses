//
//  CategoriesResponse.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation

struct CategoriesResponse: Codable {
    
    var categories : [String]? = []
    
    enum CodingKeys: String, CodingKey {
        
        case categories = "categories"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        categories = try values.decodeIfPresent([String].self , forKey: .categories )
        
    }
    
    init() {
        
    }
    
}
