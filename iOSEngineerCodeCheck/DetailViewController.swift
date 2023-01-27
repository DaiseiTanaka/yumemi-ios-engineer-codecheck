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
    @IBOutlet weak var ImgView: UIImageView!
    //　タイトル
    @IBOutlet weak var TtlLbl: UILabel!
    // 使用言語
    @IBOutlet weak var LangLbl: UILabel!
    //　スターの数
    @IBOutlet weak var StrsLbl: UILabel!
    //　Wathcersの数
    @IBOutlet weak var WchsLbl: UILabel!
    //　Forksの数
    @IBOutlet weak var FrksLbl: UILabel!
    //　Issuesの数
    @IBOutlet weak var IsssLbl: UILabel!
    
    
    var searchVC: SearchViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = searchVC.repo[searchVC.idx]
        
        // 表示されるレポジトリの詳細表示
        LangLbl.text = "Written in \(repo["language"] as? String ?? "")"
        StrsLbl.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        WchsLbl.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        FrksLbl.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        IsssLbl.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
    func getImage(){
        
        let repo = searchVC.repo[searchVC.idx]
        
        TtlLbl.text = repo["full_name"] as? String
        
        if let owner = repo["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.ImgView.image = img
                    }
                }.resume()
            }
        }
        
    }
    
}
