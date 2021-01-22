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
        fill(attributedText: text, underline: false)
    }
    
    func fill(with location: (location: CharacterModel.Location, name: String)) {
        fill(attributedText: "\(location.name): \(location.location.name)", underline: true)
    }
    
    
    func fill(with url: URL) {
        let episodeNumber = url.absoluteString.split(separator: "/").last ?? ""
        fill(attributedText: "episode \(episodeNumber)", underline: true)
    }
}

// MARK: - Private
private extension TextTableViewCell {
    func setUpViews() {
        backgroundColor = .secondarySystemBackground
        textLabel?.textColor = .systemBlue
        textLabel?.numberOfLines = 2
    }
    
    func fill(attributedText: String, underline: Bool) {
        let attributedText = underline ? attributedText.underline : attributedText.attributedText
        textLabel?.attributedText = attributedText
    }
 }
