//
//  StartViewCell.swift
//  YuGiOh_Library
//
//  Created by Arkow on 31/10/2022.
//

import Foundation
import UIKit
import AlamofireImage

final class CardListViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self.self)
    }
    
    //MARK: - Subviews
    
    let cardNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let imageCard: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .left
        return image
    }()
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupSubviews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    func setupView() {
        backgroundColor = .white
    }
    
    func setupSubviews() {
        [imageCard,cardNameLabel].forEach(addSubview)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            imageCard.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            cardNameLabel.leadingAnchor.constraint(equalTo: imageCard.trailingAnchor, constant: 20),
            cardNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            cardNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cardNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            cardNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
