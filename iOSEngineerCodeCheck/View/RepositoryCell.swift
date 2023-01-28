//
//  RepositoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by 田中大誓 on 2023/01/28.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryCell: UITableViewCell {
    
    @IBOutlet private weak var ownerImageView: UIImageView!{
        didSet {
            ownerImageView.layer.cornerRadius = 10
            ownerImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet private weak var repositoryNameLabel: UILabel!{
        didSet{
            repositoryNameLabel.textColor = UIColor.link
        }
    }
    
    @IBOutlet private weak var starImageView: UIImageView!{
        didSet {
            starImageView.setImage(systemName: "star", tintColor: UIColor.systemGray)
        }
    }
    
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet private weak var starCountLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    
    static let cellIdentifier = String(describing: RepositoryCell.self)
    
    func configure(repository: Repository) {
        ownerNameLabel.text = repository.owner.login
        repositoryNameLabel.text = repository.fullName
        
        if let url = repository.avatarImageUrl {
            ownerImageView.sd_setImage(with: url, completed: nil)
        } else {
            ownerImageView.image = nil
        }
        
        repositoryDescriptionLabel.text = repository.description ?? ""
        starCountLabel.text = "\(repository.stargazersCount)"
        languageLabel.text = repository.language
        accessoryType = .disclosureIndicator
    }
}
