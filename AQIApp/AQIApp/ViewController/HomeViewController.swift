//
//  ViewController.swift
//  AQIApp
//
//  Created by Michael Gable on 6/23/24.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    let viewModel = HomeViewModel()
    
    // MARK: - UI Components
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Air Quality Index"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter city"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 320, height: 480)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .background
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        return collectionView
    }()
    
    let locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Use Current Location", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        if let locationIcon = UIImage(systemName: "location.fill") {
            button.setImage(locationIcon, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tintColor = .blue
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        searchBar.delegate = self
        
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
        setupLocationManager()
        setupCollectionView()
        setupUI()
        
        if let coordinates = locationManager.location?.coordinate {
            viewModel.fetchAQI(for: coordinates)
        }
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .background
        view.addSubview(headerLabel)
        view.addSubview(searchBar)
        view.addSubview(locationButton)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            searchBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            locationButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            locationButton.widthAnchor.constraint(equalToConstant: 200),
            
            collectionView.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func setupCollectionView() {
        collectionView.register(AQICollectionViewCell.self, forCellWithReuseIdentifier: AQICollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Button Functionality
    @objc private func locationButtonTapped() {
        if let coordinates = locationManager.location?.coordinate {
            viewModel.fetchAQI(for: coordinates)
        }
    }
}

// MARK: - Searchbar
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let city = searchBar.text, !city.isEmpty {
            viewModel.fetchAQI(for: city)
        }
    }
}
