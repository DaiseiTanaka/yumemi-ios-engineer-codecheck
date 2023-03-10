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
    @IBOutlet private weak var titleButton: UIButton!
    // 説明文用ラベル
    @IBOutlet private weak var DiscriptionLabel: UILabel!
    // レポジトリのサイトへ移動するためのボタン
    @IBAction func GoWebSite(_ sender: Any) {
        goWebSite()
    }
    
    @IBOutlet private weak var starImageView: UIImageView!{
        didSet {
            starImageView.setImage(systemName: "star", tintColor: UIColor.orange)
        }
    }
    
    @IBOutlet private weak var watchImageView: UIImageView!{
        didSet {
            watchImageView.setImage(systemName: "eye", tintColor: UIColor.blue)
        }
    }
    
    @IBOutlet private weak var forkImageView: UIImageView!{
        didSet {
            forkImageView.setImage(systemName: "arrow.triangle.branch", tintColor: UIColor.green)
        }
    }
    
    @IBOutlet private weak var issuesImageView: UIImageView!{
        didSet {
            issuesImageView.setImage(systemName: "smallcircle.filled.circle", tintColor: UIColor.red)
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

    //MARK: - 表示されるレポジトリの詳細表示
    func getLabelText(repository: Repository) {

        LangLbl.text = "Language:  \(repository.language ?? "")"
        StrsLbl.text = "\(repository.stargazersCount)"
        WchsLbl.text = "\(repository.watchersCount)"
        FrksLbl.text = "\(repository.forksCount)"
        IsssLbl.text = "\(repository.openIssuesCount)"
        DiscriptionLabel.text = repository.description

    }

    //MARK: - 表示されるレポジトリの画像表示
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
    
    //MARK: - URL先へ移動
    func goWebSite() {
        guard let selectedIndex = searchVC.idx else { return }
        let repository = searchVC.repositories[selectedIndex]
        let urlString = "https://github.com/\(repository.fullName)"
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }

}
