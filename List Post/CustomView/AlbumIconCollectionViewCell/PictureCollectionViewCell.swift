//
//  PictureCollectionViewCell.swift
//  List Post
//
//  Created by Jan Sebastian on 12/03/22.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    private let picture: UIImageView = {
        let pict = UIImageView()
        pict.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        pict.image = #imageLiteral(resourceName: "loading")
        pict.contentMode = .scaleAspectFill
        pict.clipsToBounds = true
        return pict
    }()
    
    private let lblNama: UILabel = {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        self.backgroundColor = .white
        addLayouts()
        addConstraints()
    }
    
    private func addLayouts() {
        contentView.addSubview(picture)
        contentView.addSubview(lblNama)
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["picture": picture, "lblNama": lblNama]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        //MARK: picture constraints
        picture.translatesAutoresizingMaskIntoConstraints = false
        let hPicture = "H:|-0-[picture]-0-|"
        let vPicture = "V:|-0-[picture]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hPicture, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vPicture, options: .alignAllLeading, metrics: metrix, views: views)
        
        // MARK: lblAlbum constraints
        lblNama.translatesAutoresizingMaskIntoConstraints = false
        let hLblAlbum = "H:|-[lblNama]-|"
        constraints += [NSLayoutConstraint(item: lblNama, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLblAlbum, options: .alignAllTop, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: lblNama, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -15)]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
extension PictureCollectionViewCell {
    func returnPicture() -> UIImageView {
        return picture
    }
    
    func setThumbnail(thumbnail url: String) {
        picture.setImage(url: url)
        lblNama.isHidden = true
    }
    
    func setThumbnail(photo data: Photo) {
        picture.setImage(url: data.thumbnailUrl)
        lblNama.text = data.title
    }
    
}

