//
//  CommentTableViewCell.swift
//  List Post
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    private let labelUser: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }()
    private let labelComment: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }()
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 5
        stack.layoutMargins.left = 1
        stack.layoutMargins.right = 1
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        setupLayout()
        addConstraints()
    }
    
    private func setupLayout() {
        contentView.addSubview(labelUser)
        contentView.addSubview(labelComment)
        contentStackView.addArrangedSubview(labelUser)
        contentStackView.addArrangedSubview(labelComment)
        contentView.addSubview(contentStackView)
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["labelUser": labelUser, "labelComment": labelComment, "contentStackView": contentStackView]
        let matrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        // MARK: contentStackView constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let hContentStackView = "H:|-[contentStackView]-|"
        let vContentStackView = "V:|-[contentStackView]-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentStackView, options: .alignAllTop, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentStackView, options: .alignAllLeading, metrics: matrix, views: views)
        
        // MARK: labelUser constraints
        labelUser.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: labelUser, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 15)]
        
        NSLayoutConstraint.activate(constraints)
    }

}
extension CommentTableViewCell {
    func setComment(comment data: Comment) {
        labelUser.text = data.name
        labelComment.text = data.body
    }
}
