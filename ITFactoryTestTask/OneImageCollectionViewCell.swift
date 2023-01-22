//
//  OneImageCollectionViewCell.swift
//  ITFactoryTestTask
//
//  Created by Артем Соколовский on 22.01.2023.
//

import UIKit

class OneImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "OneImageCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = contentView.bounds.width * 0.1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViewConstraints = [
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ]
        
        let titleConstraints = [
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleConstraints)
    }
    
    func configureCell(item: Item) {
        title.text = item.title
        NetworkManager.shared.downloadData(urlString: item.image.the1X, expectingType: Data.self, completion: { result in // choose between 1x 2x 3x
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    guard let image = image as? Data else { print("error when casting data"); return }
                    self.imageView.image = UIImage(data: image)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        })
    }
}
