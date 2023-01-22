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
        title.font = .systemFont(ofSize: 14, weight: .bold)
        return title
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.layer.cornerRadius = 20
        //view.clipsToBounds = true
        //view.translatesAutoresizingMaskIntoConstraints = false
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
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        
        
        let blurEffect = UIBlurEffect(style: .light)
        //contentView.addSubview(blurView)
        blurView.effect = blurEffect
        
        
        /*
        let blur = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = title.bounds
        imageView.sendSubviewToBack(blurView)
        */
        
        /*
        // Add the `UIVisualEffectView` to the view hierarchy.
        let visualEffectView = UIVisualEffectView(effect: nil)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(visualEffectView)
        // Add appropriate constraints for the `visualEffectView`.

        // Add your content to the visual effect view.
        //let contentView = makeMyFancyPrimaryContentView()
        //visualEffectView.contentView.addSubview(contentView)
        // Add constraints for your `contentView`.

        // Finally, set the appropriate blur effect for the visual effect view.
        visualEffectView.effect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        title.sendSubviewToBack(visualEffectView)
        */
        
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
            //title.heightAnchor.constraint(equalToConstant: title.bounds.height)
        ]
        
        let blurConstraints = [
            blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            blurView.topAnchor.constraint(equalTo: title.topAnchor)
        ]
        
        //blurView.frame = title.bounds
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(blurConstraints)
    }
    
    func showBorder() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
    }
    
    func hideBorder() {
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = nil
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
