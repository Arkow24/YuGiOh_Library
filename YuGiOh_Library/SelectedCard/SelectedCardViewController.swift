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
        title = "Selected Panel"
    }
    
    func setupBindings() {
        guard let selectedCard = selectedCard else {return }
        
        contentView.nameLabel.text = selectedCard.name
        contentView.imageCard.af.setImage(withURL: selectedCard.cardImages[0].imageURL)
        contentView.typeLabel.text = selectedCard.type
        contentView.descLabel.text = selectedCard.desc
    }
}
