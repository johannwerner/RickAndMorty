//
//  ImagesTableViewCell.swift
//  RickAndMorty
//
//  Created by Johann Werner on 16.02.20.
//  Copyright © 2020 Johann Werner. All rights reserved.
//

import UIKit

private struct ImageModel: ImageCollectionProtocol {
    var accessibilityName: String?
    var imageUrlToShow: URL
}

final class ImagesTableViewCell: UITableViewCell {
    
    private var images: [URL] = []
    
    // MARK: - Properties
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
}

// MARK: - Public
extension ImagesTableViewCell {
    func fill(with images: [URL]) {
        self.images = images
    }
}

// MARK: - Private
private extension ImagesTableViewCell {
    func setUpViews() {
        addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.register(MainImageCollectionViewCell.self, forCellWithReuseIdentifier: MainImageCollectionViewCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


// MARK: CollectionView

extension ImagesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: MainImageCollectionViewCell.self, at: indexPath)!
        if let url = images[safe: indexPath.row] {
            cell.fill(with: ImageModel(imageUrlToShow: url))
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 100)
    }
    
}
