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
    @IBOutlet weak private var ImgView: UIImageView!
    //　タイトル
    @IBOutlet weak private var TtlLbl: UILabel!
    // 使用言語
    @IBOutlet weak private var LangLbl: UILabel!
    //　スターの数
    @IBOutlet weak private var StrsLbl: UILabel!
    //　Wathcersの数
    @IBOutlet weak private var WchsLbl: UILabel!
    //　Forksの数
    @IBOutlet weak private var FrksLbl: UILabel!
    //　Issuesの数
    @IBOutlet weak private var IsssLbl: UILabel!
    
    var searchVC: SearchViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let selectedRowIndex = searchVC.idx else { return }
        let repo = searchVC.repositories[selectedRowIndex]
        
        getLabelText(repo: repo)
        getImage(repo: repo)
        
    }
    
    // 表示されるレポジトリの詳細表示
    func getLabelText(repo: [String: Any]) {

        LangLbl.text = "Written in \(repo["language"] as? String ?? "")"
        StrsLbl.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        WchsLbl.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        FrksLbl.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        IsssLbl.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        
    }
    
    // 表示されるレポジトリの画像表示
    func getImage(repo: [String: Any]) {
        
        TtlLbl.text = repo["full_name"] as? String
        
        guard let owner = repo["owner"] as? [String: Any] else { return }
        guard let imgURLString = owner["avatar_url"] as? String else { return }
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
