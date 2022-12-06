//
//  ApiClient.swift
//  YuGiOh_Library
//
//  Created by Arkow on 20/10/2022.
//

import Foundation

protocol ApiClientType: AnyObject {
    func getCards(completion: @escaping ([Card]) -> Void)
}

final class ApiClient: ApiClientType {
    
    //MARK: - Properties
    
    private let session: URLSession = .shared
    private let baseURL: String = "https://db.ygoprodeck.com/api/v7"
    
    //MARK: - Methods
    
    func getCards(completion: @escaping ([Card]) -> Void ) {
      
        guard let url = URL(string: baseURL + "/cardinfo.php") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let dataAll = try JSONDecoder().decode(BaseCards.self, from: data)
                    completion(dataAll.data)
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
