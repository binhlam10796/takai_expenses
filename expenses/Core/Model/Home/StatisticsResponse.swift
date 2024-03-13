//
//  StatisticsResponse.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation

struct StatisticsResponse: Codable {
    
    var data : [String: Double]? = [:]
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try values.decodeIfPresent([String: Double].self , forKey: .data )
        
    }
    
    init() {
        
    }
    
}
