//
//  APICall.swift
//  TechnicalTestTemplate
//
//  Created by George Joseph Kristian on 31/05/22.
//

import Foundation



struct Constants {
    public static let BASEURL : String = "https://saurav.tech/NewsAPI"
    public static let TOPHEADLINES: String = "top-headlines"
    public static let CATEGORY: String = "category"
    public static let TECHNOLOGY: String = "technology"
}

class APICall {
    func getRequest <T: Codable>(
            endpoint: String,
            parameters: [String: Any],
            completion: @escaping(T?, URLResponse?, Error?) -> Void
        ) {
            guard let url = URL(string : Constants.BASEURL + endpoint) else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

                
//            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
//                return
//            }
//            
//            request.httpBody = httpBody
           
            
            request.timeoutInterval = 20
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(nil, response, error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    completion(nil, response, error)
                    return
                }
                
                completion(try? self.newJSONDecoder().decode(T.self, from: data), response, nil)
                
                }.resume()
        
    }
    
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
    
    func getNews(parameters: [String : Any] = [:], completion: @escaping (NewsModel?, URLResponse?, Error?) -> Void) -> Void {
        let urlString: String = "/\(Constants.TOPHEADLINES)/\(Constants.CATEGORY)/\(Constants.TECHNOLOGY)/us.json"
        getRequest(endpoint: urlString, parameters: parameters, completion: completion)
    }
}
