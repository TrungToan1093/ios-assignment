//
//  ViewController.swift
//  Assignment
//
//  Created by ToanHT on 18/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var waitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView(isReady: false)
        self.loadInitData()

    }
    
    
    private func setupView(isReady: Bool) {
        isReady ? self.activityView.stopAnimating() : self.activityView.startAnimating()
        self.activityView.isHidden = isReady
        self.testButton.isHidden = !isReady
        self.waitLabel.isHidden = isReady
    }
    
    private func loadInitData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SuffixReferenceService.shared.loadData() { [weak self] status in
                print("loadData \(status)")
                guard let self = self else { return }
                self.setupView(isReady: true)
            }
        }
    }
    
    
    @IBAction func testButtonTapped() {
//        let searchService: SearchCityProtocol = SearchDefaultImplement(cities: SearchService.shared.cities)
        let searchService: SearchCityProtocol = SearchSufixImplement(cities: SuffixReferenceService.shared.cities)
        let vc = CitiesViewController(searchService: searchService)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
