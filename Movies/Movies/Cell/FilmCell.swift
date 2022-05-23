//
//  FilmCell.swift
//  Movies
//
//  Created by Denis on 15.05.2022.
//

import UIKit

class FilmCell: UICollectionViewCell {
    
    static let reuseId = "FilmCell"
    private let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, inColor: .darkGray, toColor: .black)
    let filmImageView = UIImageView()
    let filmTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        addSubview(gradientView)
        gradientView.addSubview(filmImageView)
        gradientView.addSubview(filmTitle)
    }
    
    private func configureSubviews() {
        layer.cornerRadius = 4
        clipsToBounds = true
        filmTitle.textAlignment = .left
    }
    
    private func makeConstraints() {
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
        filmTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradientView.leftAnchor.constraint(equalTo: leftAnchor),
            gradientView.topAnchor.constraint(equalTo: topAnchor),
            gradientView.rightAnchor.constraint(equalTo: rightAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            filmImageView.leftAnchor.constraint(equalTo: gradientView.leftAnchor),
            filmImageView.rightAnchor.constraint(equalTo: gradientView.rightAnchor),
            filmImageView.topAnchor.constraint(equalTo: gradientView.topAnchor),
            
            filmTitle.topAnchor.constraint(equalTo: filmImageView.bottomAnchor),
            filmTitle.leftAnchor.constraint(equalTo: gradientView.leftAnchor),
            filmTitle.rightAnchor.constraint(equalTo: gradientView.rightAnchor),
            filmTitle.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor)
        ])
    }
    
    func configure(with film: Film) {
        DispatchQueue.global().async {
            guard let url = URL(string: film.image) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data) ?? UIImage()
            
            DispatchQueue.main.async {
                self.filmImageView.image = image
                self.filmTitle.attributedText = NSAttributedString(string: film.title, attributes: Text.attributes)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



