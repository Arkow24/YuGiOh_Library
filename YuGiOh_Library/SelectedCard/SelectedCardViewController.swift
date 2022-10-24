//
//  SelectedCardViewController.swift
//  YuGiOh_Library
//
//  Created by Arkow on 24/10/2022.
//

import Foundation
import UIKit
import AlamofireImage

final class SelectedCardViewController: UIViewController {
    
    var contentView: SelectedCardView {
        return view as! SelectedCardView
    }
    
    var selectedCard: Card?

    //MARK: - Lifecycle
    
    override func loadView() {
        view = SelectedCardView()
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBindings()
    }
    
    //MARK: - Setup
    
    func setupView() {
        title = "Card View"
    }
    
    func setupBindings() {
        guard let selectedCard = selectedCard else {return }
        
        contentView.nameLabel.text = selectedCard.name
        contentView.imageCard.af.setImage(withURL: selectedCard.cardImages[0].imageURL)
        contentView.typeLabel.text = selectedCard.type
        contentView.descLabel.text = selectedCard.desc
        changeBackground(for: selectedCard.type)
    }
}

extension SelectedCardViewController {
    func changeBackground(for type: String) {

        switch type {
        case "Spell Card": return contentView.backgroundColor = .systemGreen
        case "Trap Card": return contentView.backgroundColor = .systemPink
        case "Ritual Effect Monster": return contentView.backgroundColor = .systemCyan
        case "Fusion Monster": return contentView.backgroundColor = .systemPurple
        case "Effect Monster": return contentView.backgroundColor = .systemBrown
        case "Synchro Monster": return contentView.backgroundColor = .systemGray
        default: return contentView.backgroundColor = .white
        }
    }
}
