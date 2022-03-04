//
//  API.swift
//  ExMultiSection
//
//  Created by Jake.K on 2022/03/04.
//

import Alamofire

final class API {
  static func getPhotos(page: Int? = nil, completion: @escaping ([Photo]) -> ()) {
    let parameters: [String: Any]
    if let page = page {
      parameters = ["page": page]
    } else {
      parameters = [:]
    }
    
    AF.request(
      "https://api.unsplash.com/photos",
      method: .get,
      parameters: parameters,
      encoding: URLEncoding.default,
      headers: ["Authorization": "Client-ID \(APIKey.unsplashAccessKey)"]
    ).responseDecodable(of: [Photo].self) { response in
      switch response.result {
      case .success(let photos):
        completion(photos)
      case .failure(let error):
        print(error)
      }
    }
    
  }
}
