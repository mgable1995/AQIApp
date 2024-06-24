//
//  AQICollectionViewCell.swift
//  AQIApp
//
//  Created by Michael Gable on 6/23/24.
//

import UIKit

class AQICollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "AQICardCell"
    
    var rating: AQIProperties?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let aqiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let latitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let longitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .background
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 12
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(aqiLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(latitudeLabel)
        contentView.addSubview(longitudeLabel)
        contentView.addSubview(ratingMessageLabel)
        contentView.addSubview(ratingTitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            latitudeLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 12),
            latitudeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            longitudeLabel.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor, constant: 4),
            longitudeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            aqiLabel.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor, constant: 12),
            aqiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            ratingTitleLabel.topAnchor.constraint(equalTo: aqiLabel.bottomAnchor, constant: 16),
            ratingTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            ratingMessageLabel.topAnchor.constraint(equalTo: ratingTitleLabel.bottomAnchor, constant: 12),
            ratingMessageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ratingMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with title: String, city: String, aqi: Int, date: String, latitude: Double, longitude: Double, rating: AQIProperties) {
        titleLabel.text = title
        cityLabel.text = "\(city)"
        aqiLabel.text = "AQI: \(aqi)"
        dateLabel.text = "\(date)"
        latitudeLabel.text = "Latitude: \(latitude)"
        longitudeLabel.text = "Longitude: \(longitude)"
        
        ratingTitleLabel.text = rating.title
        ratingTitleLabel.textColor = rating.indexColor
        
        ratingMessageLabel.text = rating.message
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = rating.indexColor.cgColor
        
    }
}
