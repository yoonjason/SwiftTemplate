//
//  MovieListCell.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import UIKit

class MovieListCell: UITableViewCell {

    static let reuseIdentifier = "MovieListCell"

    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupViews() {
        self.addSubview(movieTitle)
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            movieTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            movieTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            
        ])
    }

    func setData(_ movie: Movie) {
        self.movieTitle.text = movie.movieName
    }

}
