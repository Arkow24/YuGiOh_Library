//
//  SelectedCardView.swift
//  YuGiOh_Library
//
//  Created by Arkow on 24/10/2022.
//

import Foundation
import UIKit


final class SelectedCardView: BaseView {
    
    //MARK: - Subviews
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    let imageCard: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    //MARK: - Setup
        
    override func setupSubviews() {
        [nameLabel,typeLabel,descLabel,imageCard].forEach(addSubview)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageCard.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -30),
            imageCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            imageCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            typeLabel.topAnchor.constraint(equalTo: imageCard.bottomAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor),
            descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
    }
    
}
