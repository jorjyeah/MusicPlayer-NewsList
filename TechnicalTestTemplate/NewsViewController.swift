//
//  NewsViewController.swift
//  TechnicalTestTemplate
//
//  Created by George Joseph Kristian on 30/05/22.
//

import UIKit


class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var articles: [Articles] = []
    
    lazy var newsTableView: UITableView  = {
        let tableView: UITableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews(){
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(NewsCellView.self, forCellReuseIdentifier: NewsCellView().cellId)
    }
    
    private func setupLayouts(){
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

extension NewsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellView().cellId, for: indexPath) as! NewsCellView
        cell.article = articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(articles[indexPath.row].author ?? "")")
    }
}
