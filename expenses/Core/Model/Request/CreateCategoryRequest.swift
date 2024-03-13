//
//  CreateCategoryRequest.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation

struct CreateCategoryRequest: Codable {

  var category : String? = nil

  enum CodingKeys: String, CodingKey {

    case category = "category"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    category = try values.decodeIfPresent(String.self , forKey: .category )
 
  }

  init() {

  }

}
