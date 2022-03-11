//
//  AlbumIconCollectionViewCell.swift
//  List Post
//
//  Created by Jan Sebastian on 12/03/22.
//

import UIKit

class AlbumIconCollectionViewCell: UICollectionViewCell {
    private let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 1
        flow.minimumInteritemSpacing = 1
        flow.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flow)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private let lblAlbum: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .left
        return label
    }()
    
    private var thumbnailURL: [Photo] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupCollectionView()
    }
    
    
    private func setup() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        addLayouts()
        addConstraints()
    }
    
    private func addLayouts() {
        contentView.addSubview(collectionView)
        contentView.addSubview(lblAlbum)
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["collectionView": collectionView, "lblAlbum": lblAlbum]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        // MARK: collectionView constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let hCollectionView = "H:|-0-[collectionView]-0-|"
        let vCollectionView = "V:|-0-[collectionView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hCollectionView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vCollectionView, options: .alignAllLeading, metrics: metrix, views: views)
        
        // MARK: lblAlbum constraints
        lblAlbum.translatesAutoresizingMaskIntoConstraints = false
        let hLblAlbum = "H:|-[lblAlbum]-|"
        constraints += [NSLayoutConstraint(item: lblAlbum, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLblAlbum, options: .alignAllTop, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: lblAlbum, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -15)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: "PictureCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        collectionView.allowsSelection = false
        collectionView.isScrollEnabled = false
    }
}

extension AlbumIconCollectionViewCell {
    func setAlbum(album data: Album) {
        thumbnailURL = data.listThumbnailUrl
        lblAlbum.text = data.title
        collectionView.reloadData()
    }
}

extension AlbumIconCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnailURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as? PictureCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        cell.setThumbnail(thumbnail: thumbnailURL[indexPath.item].thumbnailUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as? PictureCollectionViewCell else {
            return
        }
        cell.returnPicture().kf.cancelDownloadTask()
        cell.returnPicture().image = #imageLiteral(resourceName: "loading")
    }
    
}
extension AlbumIconCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width) / 3.5
        
        return CGSize(width: Int(width), height: Int(width))
        
    }
}
