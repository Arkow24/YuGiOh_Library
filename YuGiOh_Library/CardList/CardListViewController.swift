
//  StartViewController.swift
//  YuGiOh_Library
//
//  Created by Arkow on 26/10/2022.
//

import Foundation
import UIKit
import AlamofireImage
import Combine

final class CardListViewController: UIViewController {
    
    //MARK: - Properties
    
    let viewModel: CardListViewModelType
    var cancellables = [AnyCancellable]()
    private lazy var dataSource = makeDataSource()
    
    var contenView: CardListView {
        return view as! CardListView
    }
    
    //MARK: - Initialization
    
    init(viewModel: CardListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = CardListView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupView()
        setupBindings()
    }

    //MARK: - Setup
    
    func setupView() {
        title = "YGO Library"
    }
    
    func setupBindings() {
        contenView.tableView.register(CardListViewCell.self, forCellReuseIdentifier: CardListViewCell.identifier)
        contenView.tableView.delegate = self
        contenView.nameTextField.delegate = self
        
        viewModel.outputs.filteredCards
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cards in
                var snapshot = NSDiffableDataSourceSnapshot<Section, Card>()
                snapshot.appendSections([.main])
                snapshot.appendItems(cards, toSection: .main)
                self?.dataSource.apply(snapshot)
            }
            .store(in: &cancellables)

        viewModel.outputs.selectedCard
            .receive(on: DispatchQueue.main)
            .sink { card in
                let selected = CardDetailsViewController()
                selected.selectedCard = card
                self.navigationController?.pushViewController(selected, animated: true)
            }
            .store(in: &cancellables)
    }
}

extension CardListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.selectCard(for: indexPath.row)
    }
}

extension CardListViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contenView.nameTextField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.text!.count > 3 {
            viewModel.inputs.fetchTargerData(for: textField.text ?? "")
        }
        return true
    }
}

extension CardListViewController {

    func makeDataSource() -> UITableViewDiffableDataSource<Section, Card> {
        
        let dataSource = UITableViewDiffableDataSource<Section,Card>( tableView: contenView.tableView,
                cellProvider: { (tableView, indexPath, card) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: CardListViewCell.identifier,
                                                     for: indexPath) as? CardListViewCell

            cell?.cardNameLabel.text = card.name
            if !card.cardImages.isEmpty {
                cell?.imageCard.af.setImage(withURL: card.cardImages[0].imageURLSmall)
            }
            return cell
        })
        return dataSource
    }
}

extension CardListViewController {
    enum Section: CaseIterable {
        case main
    }
}
