//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import JGProgressHUD

class SearchViewController: UITableViewController {
    
    //MARK: - UI関連
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "Search repositories"
            searchBar.delegate = self
        }
    }
    
    // レポジトリ一覧
    var repositories: [Repository] = []
    
    // タップされた検索結果のindex
    var idx: Int!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: RepositoryCell.cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RepositoryCell.cellIdentifier)
        
        tableView.rowHeight = 180
    }
    
    //MARK: - アラート処理
    private func showAlert(title: String, message: String = "") -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: title, message : message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(defaultAction)
        return alert
    }
    
    private func wrongError() -> UIAlertController {
        return showAlert(title: "不正なワードの入力", message: "検索ワードの確認を行ってください")
    }
    
    private func networkError() -> UIAlertController {
        return showAlert(title: "インターネットの非接続", message: "接続状況の確認を行ってください")
    }
    
    private func parseError() -> UIAlertController {
        return showAlert(title: "データの解析に失敗しました")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        idx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.cellIdentifier, for: indexPath) as! RepositoryCell
        
        let repository = repositories[indexPath.row]
        cell.configure(repository: repository)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            guard let dtl = segue.destination as? DetailViewController else {
                return
            }
            dtl.searchVC = self
        }
    }
    
}

//MARK: - UISearchBarDelegate
extension SearchViewController:UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        GitHubAPI.taskCancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard !(searchBar.text?.isEmpty ?? true) else { return }
        searchBar.resignFirstResponder()
        
        // ローディング画面の表示
        let progressHUD = JGProgressHUD()
        progressHUD.show(in: self.view)
        
        if let word = searchBar.text{
            GitHubAPI.fetchRepository(text: word) { result in
                DispatchQueue.main.async {
                    progressHUD.dismiss()
                }
                
                switch result {
                // 通信成功
                case .success(let items):
                    self.repositories = items
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                // 通信失敗
                case .failure(let error):
                    DispatchQueue.main.async {
                        switch error {
                        case .wrong :
                            let alert = self.wrongError()
                            self.present(alert, animated: true, completion: nil)
                            return
                        case .network:
                            let alert = self.networkError()
                            self.present(alert, animated: true, completion: nil)
                            return
                        case .parse:
                            let alert = self.parseError()
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                    }
                }
            }
        }
        return
    }
}
