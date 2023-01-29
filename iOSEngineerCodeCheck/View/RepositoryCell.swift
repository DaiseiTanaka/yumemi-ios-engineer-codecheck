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
    
    // MARK: - UI関連
    // レポジトリの作成者の画像を表示
    @IBOutlet private weak var ownerImageView: UIImageView!{
        didSet {
            ownerImageView.layer.cornerRadius = 10
            ownerImageView.clipsToBounds = true
        }
    }
    
    //　レポジトリの名前を表示
    @IBOutlet private weak var repositoryNameLabel: UILabel!{
        didSet{
            repositoryNameLabel.textColor = UIColor.link
        }
    }
    
    //　星の画像を表示
    @IBOutlet private weak var starImageView: UIImageView!{
        didSet {
            starImageView.setImage(systemName: "star", tintColor: UIColor.systemGray)
        }
    }
    
    //　観覧者数の画像を表示
    @IBOutlet private weak var watchImageView: UIImageView!{
        didSet {
            watchImageView.setImage(systemName: "eye", tintColor: UIColor.systemGray)
        }
    }
    
    //　フォークの画像の表示
    @IBOutlet private weak var forkImageView: UIImageView!{
        didSet {
            forkImageView.setImage(systemName: "arrow.triangle.branch", tintColor: UIColor.systemGray)
        }
    }
    
    // 言語用の画像を表示
    @IBOutlet private weak var languageImageView: UIImageView!{
        didSet {
            languageImageView.setImage(systemName: "pencil", tintColor: UIColor.systemGray)
        }
    }
    
    // レポジトリの作成者の名前
    @IBOutlet private weak var ownerNameLabel: UILabel!
    
    // レポジトリの説明分の表示
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
    
    // 保持の数を表示
    @IBOutlet private weak var starCountLabel: UILabel!
    
    // 使用言語の表示
    @IBOutlet private weak var languageLabel: UILabel!
    
    // 観覧者数の表示
    @IBOutlet private weak var watchCountLabel: UILabel!
    
    // フォーク数の表示
    @IBOutlet private weak var forkCountLabel: UILabel!
    
    
    // MARK: - CellIdentifier
    static let cellIdentifier = String(describing: RepositoryCell.self)
    
    //MARK: - セルのラベルとイメージを変更
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
        watchCountLabel.text = "\(repository.watchersCount)"
        forkCountLabel.text = "\(repository.forksCount)"
        accessoryType = .disclosureIndicator
    }
}
