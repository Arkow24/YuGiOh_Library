//
//  MainView.swift
//  YuGiOh_Library
//
//  Created by Arkow on 20/10/2022.
//

import Foundation
import UIKit


final class MainView: BaseView {
    
    //MARK: - Subviews

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
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
