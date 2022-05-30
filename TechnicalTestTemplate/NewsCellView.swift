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
                
                if let authorValue = article.description {
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
        return imageView
    }()
    
    lazy var VStackView: UIStackView = {
        var stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = thinMargin
        return stackView
    }()
    
    lazy var HStackView: UIStackView = {
        var stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = thinMargin
        return stackView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
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
        self.addSubview(HStackView)
        HStackView.addArrangedSubview(uiImageView)
        HStackView.addArrangedSubview(VStackView)
        VStackView.addArrangedSubview(descriptionLabel)
        VStackView.addArrangedSubview(authorLabel)
    }
    
    private func setupLayouts(){
        NSLayoutConstraint.activate([
            HStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: thinMargin),
            HStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -thinMargin),
            HStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: thinMargin),
            HStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -thinMargin),
        ])
    }
    
//    open func setData(image: UIImage, descriptionValue: String, authorValue: String){
//        self.image = image
//        self.descriptionValue = descriptionValue
//        self.authorValue = authorValue
//
//        imageView?.image = self.image
//        descriptionLabel.text = self.descriptionValue
//        authorLabel.text = "Author: \(self.authorValue)"
//    }
}
