//
//  API.swift
//  ExMultiSection
//
//  Created by Jake.K on 2022/03/04.
//

import Alamofire
import KeyedCodable

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
      headers: ["Authorization": "Client-ID \(APIKey.unsplashAccessKey)"],
      interceptor: nil,
      requestModifier: nil
    ).responseData { dataResponse in
      guard let data = dataResponse.data else { return }
      do {
        let model = try [Photo].keyed.fromJSON(data)
        completion(model)
      } catch {
        print(error)
      }
    }
    
  }
}
