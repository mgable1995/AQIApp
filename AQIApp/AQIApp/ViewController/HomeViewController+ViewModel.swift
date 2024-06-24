//
//  HomeViewController+ViewModel.swift
//  AQIApp
//
//  Created by Michael Gable on 6/24/24.
//

import UIKit

extension HomeViewController: HomeViewModelDelegate {
    func didUpdateAQIData(_ viewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            let middleIndexPath = IndexPath(item: 1, section: 0)
            self.collectionView.scrollToItem(at: middleIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func didFailWithError(_ viewModel: HomeViewModel, error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Something went wrong. Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            print("Error fetching AQI data: \(error.localizedDescription)")
        }
    }
}
