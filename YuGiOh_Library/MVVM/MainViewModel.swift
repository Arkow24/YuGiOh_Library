//
//  StartViewModel.swift
//  YuGiOh_Library
//
//  Created by Arkow on 26/10/2022.
//

import Foundation
import Combine
import UIKit

protocol MainViewModelInputs {
    func fetchData()
    func fetchTargerData(for query: String)
}

protocol MainViewModelOutputs {
    var cards: [Card] { get }
    var reloadTableView: AnyPublisher<Void,Never> { get}
}

protocol MainViewModelType: AnyObject {
    var inputs: MainViewModelInputs { get }
    var outputs: MainViewModelOutputs { get }
}

final class MainViewModel: MainViewModelInputs, MainViewModelOutputs {
    
        //MARK: - Properties
    private let apiConnection:  ApiClient = .shared
    private let reloadTableViewSubject: PassthroughSubject<Void, Never> = .init()
        
        //MARK: - Inputs
    func fetchData() {
        apiConnection.allData() { [weak self] cards in
            self?.cards = cards
            self?.reloadTableViewSubject.send()
        }
    }
 
    func fetchTargerData(for query: String) {
        var tab: [Card] = []
       
        apiConnection.allData() { [weak self] queryCards in
            for card in queryCards {
                if card.name.contains("\(query)") {
                    tab.append(card)
                }
            }
            self?.cards = tab
            self?.reloadTableViewSubject.send()
        }
    }
    
        //MARK: - Outputs
    var cards: [Card] = []
    
    var reloadTableView: AnyPublisher<Void, Never> {
        reloadTableViewSubject.eraseToAnyPublisher()
    }
    
}

extension MainViewModel: MainViewModelType {
    
    var inputs: MainViewModelInputs { self }
    var outputs: MainViewModelOutputs { self }
    
}
