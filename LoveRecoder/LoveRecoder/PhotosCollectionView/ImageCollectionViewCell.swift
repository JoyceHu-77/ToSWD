//
//  ImageCollectionViewCell.swift
//  collectionViewTest
//
//  Created by Blacour on 2021/10/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = { () -> UIImageView in
        var value = UIImageView()
        value.backgroundColor = .brown
        value.contentMode = .scaleAspectFit
        return value
    }()
    
    lazy var descriptionLabel: UILabel = {() -> UILabel in
        var descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .black
        return descriptionLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
//        addDesLable()
    }
    
    private func addDesLable() {
        contentView.addSubview(descriptionLabel)
        let constraints = [
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
