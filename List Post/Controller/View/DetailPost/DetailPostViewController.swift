//
//  DetailPostViewController.swift
//  List Post
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit



class DetailPostViewController: UIViewController {
    private var group = DispatchGroup()
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bouncesZoom = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
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
    
    private let viewTitle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let stackTitle: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 1
        stack.layoutMargins.left = 1
        stack.layoutMargins.right = 1
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let userAuthor: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        return button
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
    private let tblComment: UITableView = {
        let tabel = BootstrapTableView()
        tabel.backgroundColor = UIColor(white: 1, alpha: 0)
        tabel.allowsSelection = true
        tabel.bouncesZoom = false
        tabel.bounces = false
        tabel.showsVerticalScrollIndicator = false
        return tabel
    }()
    
    private let bodyPost: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = label.font.withSize(10)
        label.textAlignment = .left
//        label.sizeToFit()
        label.bounds.size.width = 0
        
        return label
    }()
    
    private let loadingSpinner = UIActivityIndicatorView()
    private let loadingView = UIView()
    
    private var postData: Post?
    private var viewModel: ListCommentVMGuideline?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        addLayouts()
        addConstraints()
        
        viewModel = ListCommentViewModel(useCase: CommentDataSource())
        setupTabel()
        bind()
        self.loadingSpinner.startAnimating()
        group.notify(queue: .main, execute: { [weak self] in
            if let getPostInfo = self?.postData {
                self?.viewModel?.loadCommentOfPost(id: getPostInfo.id, try: 3)
            }
            
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func bind() {
        viewModel?.fetchError = { [weak self] _ in
            self?.loadingSpinner.stopAnimating()
            self?.loadingView.isHidden = true
            self?.bodyPost.text = self?.postData?.body
        }
        viewModel?.commentResult = { [weak self] _ in
            self?.tblComment.reloadData()
            self?.loadingSpinner.stopAnimating()
            self?.loadingView.isHidden = true
            self?.bodyPost.text = self?.postData?.body
        }
    }
    

    private func addLayouts() {
        view.addSubview(contentScrollView)
        
        contentScrollView.addSubview(viewTitle)
        
        viewTitle.addSubview(labelPostTitle)
        viewTitle.addSubview(userAuthor)
        stackTitle.addArrangedSubview(labelPostTitle)
        stackTitle.addArrangedSubview(userAuthor)
        viewTitle.addSubview(stackTitle)
        
        contentScrollView.addSubview(bodyPost)
        contentScrollView.addSubview(tblComment)
        
        contentStackView.addArrangedSubview(viewTitle)
        contentStackView.addArrangedSubview(bodyPost)
        contentStackView.addArrangedSubview(tblComment)
        contentScrollView.addSubview(contentStackView)
        setLoadingView()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["contentScrollView": contentScrollView, "viewTitle": viewTitle, "labelPostTitle": labelPostTitle, "userAuthor": userAuthor, "stackTitle": stackTitle, "bodyPost": bodyPost, "tblComment": tblComment, "contentStackView": contentStackView, "loadingSpinner": loadingSpinner, "loadingView": loadingView]
        let matrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        // MARK: contentScrollView constraints
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        let hContentScrollView = "H:|-0-[contentScrollView]-0-|"
        let vContentScrollView = "V:|-0-[contentScrollView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentScrollView, options: .alignAllTop, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentScrollView, options: .alignAllLeading, metrics: matrix, views: views)
        
        // MARK: contentStackView constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let hContentStackView = "H:|-0-[contentStackView]-0-|"
        let vContentStackView = "V:|-0-[contentStackView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentStackView, options: .alignAllTop, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentStackView, options: .alignAllLeading, metrics: matrix, views: views)
        constraints += [NSLayoutConstraint(item: contentStackView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)]
        
        // MARK: stackTitle constraints
        stackTitle.translatesAutoresizingMaskIntoConstraints = false
        let hStackTitle = "H:|-0-[stackTitle]-0-|"
        let vStackTitle = "V:|-0-[stackTitle]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hStackTitle, options: .alignAllTop, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vStackTitle, options: .alignAllLeading, metrics: matrix, views: views)
        
        // MARK: userAuthor constraints
        userAuthor.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: userAuthor, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)]
        
        // MARK: viewTitle constraints
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: viewTitle, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 2/9, constant: 0)]
        
        // MARK: loadingView constraints
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .width, relatedBy: .equal, toItem: loadingView, attribute: .height, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: tblComment, attribute: .top, relatedBy: .equal, toItem: loadingView, attribute: .top, multiplier: 1, constant: 20)]
        
        // MARK: loadingSpinner constraints
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerX, relatedBy: .equal, toItem: loadingView, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerY, relatedBy: .equal, toItem: loadingView, attribute: .centerY, multiplier: 1, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setLoadingView() {
        loadingSpinner.color = .gray
        loadingView.addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
        loadingView.backgroundColor = .white
        view.addSubview(loadingView)
    }
    
    private func setupTabel() {
        tblComment.delegate = self
        tblComment.dataSource = self
        tblComment.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        tblComment.rowHeight = UITableView.automaticDimension
        tblComment.estimatedRowHeight = 250
        tblComment.tableFooterView = UIView()
    }
    
}
extension DetailPostViewController {
    func getLoadingView() -> UIView {
        return loadingView
    }
    
    func getLoadingSpinner() -> UIActivityIndicatorView {
        return loadingSpinner
    }
    
    func setPostDetail(post data: Post) {
        group.enter()
        postData = data
        labelPostTitle.text = data.title
//        bodyPost.text = data.body
        userAuthor.setTitle(data.userInfo?.name, for: .normal)
        self.navigationItem.title = "\(data.title)"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        group.leave()
    }
}

extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.listComment.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        if let data = viewModel?.listComment[indexPath.section] {
            cell.setComment(comment: data)
            cell.selectionStyle = .none
        } else{
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
