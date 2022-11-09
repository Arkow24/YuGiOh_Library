//
//  StartView.swift
//  YuGiOh_Library
//
//  Created by Arkow on 26/10/2022.
//

import Foundation
import UIKit

final class MainView: BaseView {
   
    //MARK: - Subviews
    
    let nameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter FULL NAME card.. "
        field.font = .systemFont(ofSize: 26)
       return field
    }()
    
    let allCardsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemCyan
        button.setTitle("Refresh data", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsMultipleSelection = false
        table.backgroundColor = .white
        return table
    }()
    
    //MARK: - Setup
    
    override func setupView() {
        backgroundColor = .lightGray
    }
    
    override func setupSubviews() {
        addSubview(nameTextField)
        addSubview(allCardsButton)
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            allCardsButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,constant: 15),
            allCardsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            allCardsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            tableView.topAnchor.constraint(equalTo: allCardsButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
