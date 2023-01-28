//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // メイン画像
    @IBOutlet private weak var ImgView: UIImageView!{
        didSet {
            ImgView.layer.cornerRadius = 10
            ImgView.clipsToBounds = true
        }
    }
    // 使用言語
    @IBOutlet private weak var LangLbl: UILabel!
    //　スターの数
    @IBOutlet private weak var StrsLbl: UILabel!
    //　Wathcersの数
    @IBOutlet private weak var WchsLbl: UILabel!
    //　Forksの数
    @IBOutlet private weak var FrksLbl: UILabel!
    //　Issuesの数
    @IBOutlet private weak var IsssLbl: UILabel!
    // リンク付きのタイトル
    @IBOutlet weak var titleButton: UIButton!
    // 説明文用ラベル
    @IBOutlet weak var DiscriptionLabel: UILabel!
    // レポジトリのサイトへ移動するためのボタン
    @IBAction func GoWebSite(_ sender: Any) {
        goWebSite()
    }
    
    @IBOutlet private weak var starImageView: UIImageView!{
        didSet {
            starImageView.setImage(systemName: "star", tintColor: UIColor.systemGray)
        }
    }
    
    @IBOutlet private weak var watchImageView: UIImageView!{
        didSet {
            watchImageView.setImage(systemName: "eye", tintColor: UIColor.systemGray)
        }
    }
    
    @IBOutlet private weak var forkImageView: UIImageView!{
        didSet {
            forkImageView.setImage(systemName: "arrow.triangle.branch", tintColor: UIColor.systemGray)
        }
    }
    
    @IBOutlet private weak var issuesImageView: UIImageView!{
        didSet {
            issuesImageView.setImage(systemName: "smallcircle.filled.circle", tintColor: UIColor.systemGray)
        }
    }
    
    
    var searchVC: SearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let selectedRowIndex = searchVC.idx else { return }
        let repository = searchVC.repositories[selectedRowIndex]
        print(repository)
        getLabelText(repository: repository)
        getImage(repository: repository)
    }

    // 表示されるレポジトリの詳細表示
    func getLabelText(repository: Repository) {

        LangLbl.text = "Language:  \(repository.language ?? "")"
        StrsLbl.text = "\(repository.stargazersCount ) stars"
        WchsLbl.text = "\(repository.watchersCount ) watchers"
        FrksLbl.text = "\(repository.forksCount) forks"
        IsssLbl.text = "\(repository.openIssuesCount) open issues"
        DiscriptionLabel.text = repository.description

    }

    // 表示されるレポジトリの画像表示
    func getImage(repository: Repository) {

        titleButton.setTitle(repository.fullName, for: UIControl.State.normal)

        let owner = repository.owner
        let imgURLString = owner.avatarUrl
        guard let imgURL = URL(string: imgURLString) else { return }

        URLSession.shared.dataTask(with: imgURL) { (data, res, err) in

            guard let data = data else { return }
            guard let img = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.ImgView.image = img
            }

        }.resume()
    }
    
    func goWebSite() {
        guard let selectedIndex = searchVC.idx else { return }
        let repository = searchVC.repositories[selectedIndex]
        let urlString = "https://github.com/\(repository.fullName)"
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }

}
