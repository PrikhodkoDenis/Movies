//
//  DetailedViewController.swift
//  Movies
//
//  Created by Denis on 18.05.2022.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var filmCoverImageView = UIImageView()
    var filmTitleLabel = UILabel()
    var filmInfoTextView = UITextView()
    
    private let activityIndicator = UIActivityIndicatorView()
    private lazy var coverHeight = view.bounds.height / 2
    private let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, inColor: .darkGray, toColor: .black)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(gradientView)
        gradientView.addSubview(filmCoverImageView)
        gradientView.addSubview(filmTitleLabel)
        gradientView.addSubview(filmInfoTextView)
        gradientView.addSubview(activityIndicator)
    }
    
    private func configureSubviews() {
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        filmCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        filmTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        filmInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        filmCoverImageView.contentMode = .scaleAspectFit
        filmTitleLabel.textAlignment = .center
        filmTitleLabel.numberOfLines = 0
        filmInfoTextView.isSelectable = false
        filmInfoTextView.backgroundColor = .clear
        filmInfoTextView.textAlignment = .justified
        activityIndicator.color = .white
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            gradientView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            gradientView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gradientView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: gradientView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
            
            filmCoverImageView.leftAnchor.constraint(equalTo: gradientView.leftAnchor),
            filmCoverImageView.topAnchor.constraint(equalTo: gradientView.topAnchor),
            filmCoverImageView.rightAnchor.constraint(equalTo: gradientView.rightAnchor),
            filmCoverImageView.heightAnchor.constraint(equalToConstant: coverHeight),
            
            filmTitleLabel.leftAnchor.constraint(equalTo: gradientView.leftAnchor),
            filmTitleLabel.topAnchor.constraint(equalTo: filmCoverImageView.bottomAnchor, constant: 15),
            filmTitleLabel.rightAnchor.constraint(equalTo: gradientView.rightAnchor),
            
            filmInfoTextView.leftAnchor.constraint(equalTo: gradientView.leftAnchor),
            filmInfoTextView.topAnchor.constraint(equalTo: filmTitleLabel.bottomAnchor, constant:  15),
            filmInfoTextView.rightAnchor.constraint(equalTo: gradientView.rightAnchor),
            filmInfoTextView.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor),
        ])
    }
}

extension DetailedViewController {
    
    func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        [filmCoverImageView, filmTitleLabel, filmInfoTextView].forEach {
            $0.isHidden = true
        }
    }
    
    func hideLoader() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        [filmCoverImageView, filmTitleLabel, filmInfoTextView].forEach {
            $0.isHidden = false
        }
    }
}
