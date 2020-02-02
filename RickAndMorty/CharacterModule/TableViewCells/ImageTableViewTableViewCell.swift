//
//  ImageTableViewTableViewCell.swift
//  RickAndMorty
//
//  Created by Johann Werner on 02.02.20.
//  Copyright © 2020 Johann Werner. All rights reserved.
//

import UIKit

final class ImageTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var mainImageView: UIImageView

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        mainImageView = UIImageView(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        mainImageView = UIImageView(frame: .zero)
        super.init(coder: aDecoder)
        setUpViews()
    }
}

// MARK: - Public
extension ImageTableViewCell {
    func fill(with url: String) {
        mainImageView.setRemoteImage(with: url)
    }
}

// MARK: - Private
private extension ImageTableViewCell {
    func setUpViews() {
        addSubview(mainImageView)
        mainImageView.autoPinEdgesToSuperviewEdges()
    }
}
