//
//  NetworkHandler.swift
//  Smart tasks
//
//  Created by Muhammad Faaiez Nisar on 09/06/2024.
//

import UIKit

class NetworkHandler: NSObject {

    static let shared = NetworkHandler()
    
    func fetchTask<T: Decodable>(urlString: String, completion: @escaping (Result<T,Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { completion(.failure(error)); return }
            completion( Result{ try JSONDecoder().decode(T.self, from: data!) })
        }.resume()
    }
    
}
