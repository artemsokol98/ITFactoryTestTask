//
//  NetworkManager.swift
//  ITFactoryTestTask
//
//  Created by Артем Соколовский on 22.01.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let sessionConfig = URLSessionConfiguration.default
    
    func downloadData<T: Decodable>(urlString: String, expectingType: T.Type, completion: @escaping (Result<Any,Error>) -> Void) {
        sessionConfig.timeoutIntervalForRequest = Constants.timeWaitingForLoading
        let session = URLSession(configuration: sessionConfig)
        guard let url = URL(string: urlString) else { return }
        
        session.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                if let decodedData = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(decodedData))
                } else {
                    completion(.success(data))
                }
            } else {
                guard let error = error else { return }
                completion(.failure(error))
            }
        }.resume()
    }
}
