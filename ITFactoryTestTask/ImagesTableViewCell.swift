//
//  ImagesTableViewCell.swift
//  ITFactoryTestTask
//
//  Created by Артем Соколовский on 22.01.2023.
//

import UIKit

class ImagesTableViewCell: UITableViewCell {
    
    private let spacing: CGFloat = 10.0
    
    static let identifier = "ImagesTableViewCell"
    
    var viewModel = [Item]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OneImageCollectionViewCell.self, forCellWithReuseIdentifier: OneImageCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(collectionView)
        //collectionView.frame = contentView.bounds
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(collectionViewConstraints)
        
    }
    
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     */
    func configureCell(section: Section) {
        viewModel = section.items
    }
}

extension ImagesTableViewCell: UICollectionViewDelegate {
    
}

extension ImagesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OneImageCollectionViewCell.identifier, for: indexPath) as? OneImageCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(item: viewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? OneImageCollectionViewCell {
            cell.showBorder()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? OneImageCollectionViewCell {
            cell.hideBorder()
        }
    }
    
}

extension ImagesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 10.0
        let totalSpacing = self.spacing * 2 + ((numberOfItemsPerRow - 1) * spacingBetweenCells) // Amount of total spacing in a row
        let width = floor((collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow)
        return CGSize(width: width, height: width * 1.5)
    }
}
