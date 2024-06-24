//
//  HomeViewController+UICollectionView.swift
//  AQIApp
//
//  Created by Michael Gable on 6/24/24.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getAQIDataCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AQICollectionViewCell.reuseIdentifier, for: indexPath) as! AQICollectionViewCell
        if let data = viewModel.getAQIData(for: indexPath.item) {
            let title = indexPath.item == 0 ? "Yesterday" : indexPath.item == 1 ? "Today" : "Tomorrow"
            cell.configure(with: title, city: viewModel.aqiData?.city.name ?? "", aqi: data.avg, date: data.day, latitude: viewModel.aqiData?.city.geo.first ?? 0.0, longitude: viewModel.aqiData?.city.geo.last ?? 0.0, rating: data.rating)
        }
        return cell
    }
}
