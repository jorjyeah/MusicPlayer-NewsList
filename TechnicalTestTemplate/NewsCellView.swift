//
//  NewsCellView.swift
//  TechnicalTestTemplate
//
//  Created by George Joseph Kristian on 30/05/22.
//

import UIKit

class NewsCellView: UITableViewCell {
    public var cellId: String = "NewsCell"
    
    var article: Articles? {
        didSet {
            if let article = article {
                
                if let imageUrlString = article.urlToImage {
                    uiImageView.downloaded(from: imageUrlString)
                } else {
                    uiImageView.image = UIImage()
                }
                
                if let descriptionValue = article.description {
                    descriptionLabel.text = descriptionValue
                } else {
                    descriptionLabel.text = "-"
                }
                
                if let authorValue = article.author {
                    authorLabel.text = "Author: \(authorValue)"
                } else {
                    authorLabel.text = "Author: -"
                }
                
                setNeedsLayout()
            }
        }
    }

    lazy var uiImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var vStackView: UIStackView = {
        var stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = thinMargin
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var hStackView: UIStackView = {
        var stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = mainMargin
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupViews(){
        backgroundColor = .white
        self.addSubview(hStackView)
        hStackView.addArrangedSubview(uiImageView)
        hStackView.addArrangedSubview(vStackView)
        vStackView.addArrangedSubview(descriptionLabel)
        vStackView.addArrangedSubview(authorLabel)
    }
    
    private func setupLayouts(){
        NSLayoutConstraint.activate([
            hStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: thinMargin),
            hStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -thinMargin),
            hStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: thinMargin),
            hStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -thinMargin),
            
            uiImageView.heightAnchor.constraint(equalToConstant: 90),
            uiImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
}
