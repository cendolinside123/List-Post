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
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["picture": picture]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        //MARK: picture constraints
        picture.translatesAutoresizingMaskIntoConstraints = false
        let hPicture = "H:|-0-[picture]-0-|"
        let vPicture = "V:|-0-[picture]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hPicture, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vPicture, options: .alignAllLeading, metrics: metrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
extension PictureCollectionViewCell {
    func returnPicture() -> UIImageView {
        return picture
    }
    
    func setThumbnail(thumbnail url: String) {
        picture.setImage(url: url)
    }
    
}

