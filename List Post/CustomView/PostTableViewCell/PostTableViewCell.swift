//
//  PostTableViewCell.swift
//  List Post
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    private let viewUser: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 1
        return view
    }()
    private let labelUserName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }()
    private let labelCompany: UILabel = {
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
    private let viewPost: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let labelPostTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }()
    private let labelPostBory: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
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
        stack.alignment = .fill
        stack.spacing = 5
        stack.layoutMargins.left = 1
        stack.layoutMargins.right = 1
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let userInfo: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 1
        stack.layoutMargins.left = 10
        stack.layoutMargins.right = 10
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let postData: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 1
        stack.layoutMargins.left = 10
        stack.layoutMargins.right = 10
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
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
        addViewUser()
        addViewPost()
        addUserInfo()
        addPostDisplay()
        addStackView()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["viewUser": viewUser, "labelUserName": labelUserName, "labelCompany": labelCompany, "viewPost": viewPost, "labelPostTitle": labelPostTitle, "labelPostBory": labelPostBory, "contentStackView": contentStackView, "userInfo": userInfo, "postData": postData, "line": line]
        let matrix: [String: Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        // MARK: contentStackView constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let hContentStackView = "H:|-0-[contentStackView]-0-|"
        let vContentStackView = "V:|-[contentStackView]-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentStackView, options: .alignAllTop, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentStackView, options: .alignAllLeading, metrics: matrix, views: views)
        
        // MARK: userInfo constraints
        userInfo.translatesAutoresizingMaskIntoConstraints = false
        let hUserInfo = "H:|-0-[userInfo]-0-|"
        let vUserInfo = "V:|-0-[userInfo]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hUserInfo, options: .alignAllTop, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vUserInfo, options: .alignAllLeading, metrics: matrix, views: views)
        
        
        // MARK: postData constraints
        postData.translatesAutoresizingMaskIntoConstraints = false
        let hPostData = "H:|-0-[postData]-0-|"
        let vPostData = "V:|-0-[postData]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hPostData, options: .alignAllTop, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vPostData, options: .alignAllLeading, metrics: matrix, views: views)
        
        // MARK: viewUser constraints
        viewUser.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: viewUser, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 2/9, constant: 0)]
        
        //MARK: line contraints
        line.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addViewUser() {
        contentView.addSubview(viewUser)
    }
    
    private func addViewPost() {
        contentView.addSubview(viewPost)
    }
    
    private func addUserInfo() {
        viewUser.addSubview(labelUserName)
        viewUser.addSubview(labelCompany)
    }
    
    private func addPostDisplay() {
        viewPost.addSubview(labelPostTitle)
        viewPost.addSubview(labelPostBory)
    }
    private func addStackView() {
        userInfo.addArrangedSubview(labelUserName)
        userInfo.addArrangedSubview(labelCompany)
        viewUser.addSubview(userInfo)
        
        postData.addArrangedSubview(labelPostTitle)
        postData.addArrangedSubview(labelPostBory)
        viewPost.addSubview(postData)
        
        contentStackView.addArrangedSubview(viewUser)
        contentStackView.addArrangedSubview(line)
        contentStackView.addArrangedSubview(viewPost)
        contentView.addSubview(contentStackView)
    }
}
extension PostTableViewCell {
    func setPost(post data: Post) {
        labelUserName.text = data.userInfo?.name
        labelCompany.text = data.userInfo?.company.name
        labelPostTitle.text = data.title
        labelPostBory.text = data.body
    }
}
