//
//  StartViewModel.swift
//  YuGiOh_Library
//
//  Created by Arkow on 26/10/2022.
//

import Foundation
import Combine
import UIKit

protocol CardListViewModelInputs {
    func fetchData()
    func fetchTargerData(for query: String)
    func selectCard(for index: Int)
}

protocol CardListViewModelOutputs {
    var filteredCards: AnyPublisher<[Card], Never> { get }
    var selectedCard: AnyPublisher<Card, Never> { get }
}

protocol CardListViewModelType: AnyObject {
    var inputs: CardListViewModelInputs { get }
    var outputs: CardListViewModelOutputs { get }
}

final class CardListViewModel: CardListViewModelInputs, CardListViewModelOutputs {
    
        //MARK: - Properties
    private let apiClient: ApiClientType
    private let filteredCardsSubject: CurrentValueSubject<[Card], Never> = .init([])
    private let selectedCardSubject: PassthroughSubject<Card, Never> = .init()
        
        //MARK: - Inputs
    func fetchData() {
        apiClient.getCards { [weak self] cards in
            self?.cards = cards
            self?.filteredCardsSubject.send(cards)
        }
    }
 
    func fetchTargerData(for query: String) {
        if query.isEmpty {
            filteredCardsSubject.send(cards)
        } else {
            filteredCardsSubject.send(cards.filter { $0.name.contains(query) })
        }
    }

    func selectCard(for index: Int) {
        let card = filteredCardsSubject.value[index]
        selectedCardSubject.send(card)
    }
    
        //MARK: - Outputs
    var cards: [Card] = []

    var filteredCards: AnyPublisher<[Card], Never> {
        filteredCardsSubject.eraseToAnyPublisher()
    }

    var selectedCard: AnyPublisher<Card, Never> {
        selectedCardSubject.eraseToAnyPublisher()
    }

    // MARK: - Initialization

    init(apiClient: ApiClientType) {
        self.apiClient = apiClient
    }
}

extension CardListViewModel: CardListViewModelType {
    
    var inputs: CardListViewModelInputs { self }
    var outputs: CardListViewModelOutputs { self }
}
