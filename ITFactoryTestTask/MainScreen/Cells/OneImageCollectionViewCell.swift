//
//  OneImageCollectionViewCell.swift
//  ITFactoryTestTask
//
//  Created by Артем Соколовский on 22.01.2023.
//

import UIKit

class OneImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "OneImageCollectionViewCell"
    
    var itemSelected = false
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: Constants.fontSizeForTitleInCell, weight: .bold)
        return title
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(imageView)
        contentView.addSubview(blurView)
        contentView.addSubview(title)
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.masksToBounds = true

        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect
       
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViewConstraints = [
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ]
        
        let titleConstraints = [
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.bounds.width * 0.1),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.bounds.width * 0.1),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -contentView.bounds.width * 0.1),
        ]
        
        let blurConstraints = [
            blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            blurView.topAnchor.constraint(equalTo: title.topAnchor)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(blurConstraints)
    }
    
    func showBorder() {
        contentView.layer.borderWidth = Constants.borderWidthWhenItemSelected
        contentView.layer.borderColor = Constants.borderColor
    }
    
    func hideBorder() {
        contentView.layer.borderWidth = Constants.borderWidthWhenItemDeselected
        contentView.layer.borderColor = nil
    }
    
    func configureCell(item: Item) {
        title.text = item.title
        NetworkManager.shared.downloadData(urlString: item.image.the1X, expectingType: Data.self, completion: { [weak self] result in 
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    guard let image = image as? Data else { print("error when casting data"); return }
                    self?.imageView.image = UIImage(data: image)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        })
    }
}
