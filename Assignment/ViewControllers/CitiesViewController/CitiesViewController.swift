//
//  CitiesViewController.swift
//  Assignment
//
//  Created by ToanHT on 18/02/2022.
//

import UIKit




class CitiesViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Properties
//    private let citisOriginal: [CityModel]
    private var citisDisplay: [CityModel]
    
    private var searchService: SearchCityProtocol
    
    init(searchService: SearchCityProtocol) {
        self.searchService = searchService
        self.citisDisplay = searchService.citisOriginal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configSearchBar()
        self.configTableView()
        // Do any additional setup after loading the view.
    }

    private func configSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.searchTextField.clearButtonMode = .whileEditing
        self.searchBar.showsCancelButton = true
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell else { return  UITableViewCell()}
        let item = citisDisplay[indexPath.row]
        cell.configure(city: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citisDisplay.count
    }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = self.citisDisplay[indexPath.row]
        let vc = MapViewController(city: city)
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchService.search(text: searchText) { cities in
            self.citisDisplay = cities
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
