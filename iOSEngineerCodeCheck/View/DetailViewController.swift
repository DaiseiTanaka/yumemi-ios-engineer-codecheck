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
    @IBOutlet private weak var ImgView: UIImageView!
    //　タイトル
    @IBOutlet private weak var TtlLbl: UILabel!
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

        LangLbl.text = "Written in \(repository.language ?? "")"
        StrsLbl.text = "\(repository.stargazersCount ) stars"
        WchsLbl.text = "\(repository.watchersCount ) watchers"
        FrksLbl.text = "\(repository.forksCount) forks"
        IsssLbl.text = "\(repository.openIssuesCount) open issues"

    }

    // 表示されるレポジトリの画像表示
    func getImage(repository: Repository) {

        TtlLbl.text = repository.fullName

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

}
