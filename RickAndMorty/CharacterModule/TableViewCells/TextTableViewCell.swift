//
//  TextTableViewCell.swift
//  RickAndMorty
//
//  Created by Johann Werner on 02.02.20.
//  Copyright © 2020 Johann Werner. All rights reserved.
//

import UIKit

struct TextTableViewCellModel {
    var title: String
    var subtitle: String
}

final class TextTableViewCell: UITableViewCell {
    
    // MARK: - Properties

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
extension TextTableViewCell {
    func fill(with text: String) {
        textLabel?.text = text
    }
    
    func fill(with location: (location: CharacterModel.Location, name: String)) {
        let attributedText = AttributedStringManager.convertStringToAttributedString("<u>\(location.name): \(location.location.name)</u>")
        textLabel?.attributedText = attributedText
    }
}

// MARK: - Private
private extension TextTableViewCell {
    func setUpViews() {
        backgroundColor = .black
        textLabel?.textColor = .systemBlue
        textLabel?.numberOfLines = 2
    }
}
