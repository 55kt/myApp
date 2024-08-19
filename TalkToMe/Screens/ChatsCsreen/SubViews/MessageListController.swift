import Foundation
import UIKit
import SwiftUI

final class MessageListController: UIViewController {
    
    // MARK: - Views LifeCycle
    // Function for setting up views
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // MARK: - Properties
    private let cellIdentifier = "MessageListControllerCells"
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    // MARK: - Methods
    
    // Function for setting up views
    private func setUpViews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

// Extension for tableView
extension MessageListController: UITableViewDelegate, UITableViewDataSource {
    
    // Function for creating cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        cell.contentConfiguration = UIHostingConfiguration {
            Text("Placeholder")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color.gray.opacity(0.1))
        }
        return cell
    }
    
    // Function for number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // Function for height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
