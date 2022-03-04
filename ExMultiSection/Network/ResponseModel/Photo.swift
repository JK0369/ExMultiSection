//
//  Photo.swift
//  ExMultiSection
//
//  Created by Jake.K on 2022/03/04.
//

import KeyedCodable

struct Photo: Codable {
  enum CodingKeys: String, KeyedKey {
    case id
    case description
    case url = "urls.regular"
  }
  let id: String
  let description: String?
  let url: String
}
