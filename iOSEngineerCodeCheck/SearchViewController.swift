//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {

    // UI関連
    @IBOutlet weak var SchBr: UISearchBar!
    
    // レポジトリ
    var repo: [[String: Any]]=[]
    // タスク
    var task: URLSessionTask?
    // 検索ワード
    var word: String?
    // GitHubのレポジトリ検索用url
    var url: String?
    // タップされた検索結果のindex
    var idx: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SchBr.text = "GitHubのリポジトリを検索できるよー"
        SchBr.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchedWord = searchBar.text else { return }
        // searchBarに文字が入っているか確認
        if searchedWord.isEmpty { return }
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchedWord)") else { return }
        
        task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            // データの型をそれぞれ確認
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data) else { return }
            guard let obj = json as? [String: Any] else { return }
            guard let items = obj["items"] as? [[String: Any]] else { return }
            
            self.repo = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            guard let dtl = segue.destination as? DetailViewController else {
                return
            }
            dtl.searchVC = self
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let rp = repo[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        idx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
    
}
