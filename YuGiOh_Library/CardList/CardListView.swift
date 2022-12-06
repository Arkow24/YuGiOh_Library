//
//  StartView.swift
//  YuGiOh_Library
//
//  Created by Arkow on 26/10/2022.
//

import Foundation
import UIKit

final class CardListView: BaseView {
   
    //MARK: - Subviews
    
    let nameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter FULL NAME card.. "
        field.font = .systemFont(ofSize: 26)
       return field
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
        [nameTextField,tableView].forEach(addSubview)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
