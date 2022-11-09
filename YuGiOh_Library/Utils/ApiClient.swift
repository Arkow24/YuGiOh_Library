//
//  ApiClient.swift
//  YuGiOh_Library
//
//  Created by Arkow on 20/10/2022.
//

import Foundation

final class ApiClient {
    
    //MARK: - Properties
    
    private let session: URLSession = .shared
    private let baseURL: String = "https://db.ygoprodeck.com/api/v7"
    static let shared: ApiClient = .init()
    
    //MARK: - Methods
    
    func allData(completion: @escaping ([Card]) -> Void ) {
      
        guard let url = URL(string: baseURL + EndURL.blueEyesModel.path) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let dataAll = try JSONDecoder().decode(BaseCards.self, from: data)
                    completion(dataAll.base)
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
}

    //MARK: - Extensions

extension ApiClient {
    enum Constants {
        static let baseURL: String = "https://db.ygoprodeck.com/api/v7"
    }
    
    enum EndURL {
        case cardList
        case blueEyesModel
        case eachCard
        
        var path: String {
            switch self {
            case .cardList: return "/cardinfo.php"
            case .blueEyesModel: return "/cardinfo.php?archetype=Blue-Eyes"
            case .eachCard: return "/cardinfo.php?name="
            }
        }
        
        var url: String {
            switch self {
            case .cardList: return "\(ApiClient.Constants.baseURL)\(path)"
            case .blueEyesModel: return "\(ApiClient.Constants.baseURL)\(path)"
            case .eachCard: return "\(ApiClient.Constants.baseURL)\(path)"
            }
        }
    }
 
}

