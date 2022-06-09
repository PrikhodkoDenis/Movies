//
//  MainViewController.swift
//  Movies
//
//  Created by Denis on 15.05.2022.
//

import UIKit

extension MainViewController {
    
    enum Section: String {
        case one = "1920 - 1930"
        case two = "1930 - 1940"
        case three = "1940 - 1950"
        case four = "1950 - 1960"
        case five = "1960 - 1970"
        case six = "1970 - 1980"
        case seven = "1980 - 1990"
        case eight = "1990 - 2000"
        case nine = "2000 - 2010"
        case ten = "2010 - 2022"
    }
}

class MainViewController: UIViewController {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, inColor: .darkGray, toColor: .black)
    private let activityIndicator = UIActivityIndicatorView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Film>?
    private var movies: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureSubviews()
        makeConstraints()
        showLoader()
        fetchMainData()
    }
    
    private func addSubviews() {
        view.addSubview(gradientView)
        gradientView.addSubview(activityIndicator)
        gradientView.addSubview(collectionView)
    }
    
    private func configureSubviews() {
        navigationItem.title = "Movies"
        activityIndicator.color = .white
        
        collectionView.frame = view.bounds
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(FilmCell.self, forCellWithReuseIdentifier: FilmCell.reuseId)
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reusedId)
        collectionView.delegate = self
    }
    
    private func makeConstraints() {
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradientView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            gradientView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gradientView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            collectionView.leftAnchor.constraint(equalTo: gradientView.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: gradientView.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: gradientView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor),
        ])
    }
}

extension MainViewController {
    
    private func fetchMainData() {
        NetworkManager.shared.fetchMainData() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(fetchMovies):
                    self?.hideLoader()
                    self?.movies = fetchMovies
                    self?.createDataSource()
                    self?.updateDataSource()
                    self?.collectionView.reloadData()
                case let .failure(error):
                    self?.collectionView.isHidden = true
                    self?.showAlert(error: error)
                }
            }
        }
    }
    
    private func showAlert(error: FetchError) {
        let alertController = UIAlertController(title: "Ошибка", message: error.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Повторить", style: .default) { [weak self] _ in
            self?.showLoader()
            self?.fetchMainData()
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Film>(collectionView: collectionView, cellProvider: {  (collectionView, indexPath, film) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCell.reuseId, for: indexPath) as? FilmCell
            cell?.configure(with: film)
            return cell ?? FilmCell()
        })
        
        dataSource?.supplementaryViewProvider = {
            [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reusedId, for: indexPath) as? SectionHeader else { return nil }
            guard let film = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: film) else { return nil }
            if section.rawValue.isEmpty { return nil }
            sectionHeader.title.attributedText = NSAttributedString(string: section.rawValue, attributes: Text.attributes)
            return sectionHeader
        }
    }
    
    private func updateDataSource() {
        guard let movies = self.movies else { return }
        let films = movies.items
        var snapshot = NSDiffableDataSourceSnapshot<Section, Film>()
        
        snapshot.appendSections(
            [.one,
             .two,
             .three,
             .four,
             .five,
             .six,
             .seven,
             .eight,
             .nine,
             .ten
            ])
        
        let sections = films.reduce (
            into: (section1: [Film](),
                   section2: [Film](),
                   section3: [Film](),
                   section4: [Film](),
                   section5: [Film](),
                   section6: [Film](),
                   section7: [Film](),
                   section8: [Film](),
                   section9: [Film](),
                   section10: [Film]())
        )
        { partialResult, film in
            let year = film.year
            guard let yearInt = Int(year) else { return }
            switch yearInt {
            case 1920...1929:
                partialResult.section1.append(film)
            case 1930...1939:
                partialResult.section2.append(film)
            case 1940...1949:
                partialResult.section3.append(film)
            case 1950...1959:
                partialResult.section4.append(film)
            case 1960...1969:
                partialResult.section5.append(film)
            case 1970...1979:
                partialResult.section6.append(film)
            case 1980...1989:
                partialResult.section7.append(film)
            case 1990...1999:
                partialResult.section8.append(film)
            case 2000...2009:
                partialResult.section9.append(film)
            case 2010...2022:
                partialResult.section10.append(film)
            default:
                break
            }
        }
        
        snapshot.appendItems(sections.section1, toSection: Section.one)
        snapshot.appendItems(sections.section2, toSection: Section.two)
        snapshot.appendItems(sections.section3, toSection: Section.three)
        snapshot.appendItems(sections.section4, toSection: Section.four)
        snapshot.appendItems(sections.section5, toSection: Section.five)
        snapshot.appendItems(sections.section6, toSection: Section.six)
        snapshot.appendItems(sections.section7, toSection: Section.seven)
        snapshot.appendItems(sections.section8, toSection: Section.eight)
        snapshot.appendItems(sections.section9, toSection: Section.nine)
        snapshot.appendItems(sections.section10, toSection: Section.ten)
        
        self.dataSource?.apply(snapshot)
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.1)
        )
        
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        return layoutSectionHeader
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let film = dataSource?.itemIdentifier(for: indexPath) else { return }
        let detailedVC = DetailedViewController()
        
        NetworkManager.shared.fetchDetailedData(filmId: film.id) { [weak self] result  in
            switch result {
            case let .success(film):
                guard let url = URL(string: film.image) else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                
                let image = UIImage(data: data) ?? UIImage()
                let attributedTitle = NSAttributedString(string: film.fullTitle, attributes: Text.attributes)
                let attributedFilmInfo = NSAttributedString(string: "Description: \(film.plot)" , attributes: Text.attributes)
                
                DispatchQueue.main.async {
                    detailedVC.filmTitleLabel.attributedText = attributedTitle
                    detailedVC.filmInfoTextView.attributedText = attributedFilmInfo
                    detailedVC.filmCoverImageView.image = image
                    detailedVC.hideLoader()
                }
                
            case let .failure(error):
                self?.showAlert(error: error)
            }
        }
        
        detailedVC.showLoader()
        self.navigationController?.pushViewController(detailedVC, animated: true)
    }
}

private extension MainViewController {
    
    func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        collectionView.isHidden = true
    }
    
    func hideLoader() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        collectionView.isHidden = false
    }
}
