//
//  NewsViewController.swift
//  TechnicalTestTemplate
//
//  Created by George Joseph Kristian on 30/05/22.
//

import UIKit
import SwiftUI


class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var articles: [Articles] = []
    var newsViewModel = NewsViewModel()
    
    lazy var newsTableView: UITableView  = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsViewModel.fetchData { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews(){
        self.view.addSubview(newsTableView)
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(NewsCellView.self, forCellReuseIdentifier: NewsCellView().cellId)
    }
    
    private func setupLayouts(){
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

extension NewsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellView().cellId, for: indexPath) as! NewsCellView
        cell.article = newsViewModel.articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(newsViewModel.articles[indexPath.row].author ?? "")")
    }
}
