//
//  NewsViewController.swift
//  TechnicalTestTemplate
//
//  Created by George Joseph Kristian on 30/05/22.
//

import UIKit
import SwiftUI


class NewsViewController: UIViewController {
    
    // MARK: Properties
    var articles: [Articles] = []
    var newsViewModel = NewsViewModel()
    
    // MARK: Components
    lazy var newsTableView: UITableView  = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var audioPlayerView: AudioPlayerView = {
        let audioPlayerView: AudioPlayerView = AudioPlayerView()
        audioPlayerView.view.translatesAutoresizingMaskIntoConstraints = false
        return audioPlayerView
    }()
    
    // MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews(){
        self.title = "Choose News"
        newsViewModel.fetchData { (articles) in
            self.articles = articles
            DispatchQueue.global(qos: .utility).async {
                self.newsTableView.reloadData()
            }
        }
        self.view.addSubview(newsTableView)
        self.view.addSubview(audioPlayerView.view)
        newsTableView.dataSource = self
        newsTableView.delegate = self
        audioPlayerView.audioPlayerDelegate = self
        newsTableView.register(NewsCellView.self, forCellReuseIdentifier: NewsCellView().cellId)
    }
    
    private func setupLayouts(){
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: self.audioPlayerView.view.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            audioPlayerView.view.topAnchor.constraint(equalTo: self.newsTableView.bottomAnchor),
            audioPlayerView.view.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
            audioPlayerView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            audioPlayerView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}


extension NewsViewController: UITableViewDataSource, UITableViewDelegate, AudioPlayerDelegate {
    func updateState(audioState: AudioState) {
        debugPrint("Audio \(audioState)")
    }
    
    // MARK: Extensions
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
