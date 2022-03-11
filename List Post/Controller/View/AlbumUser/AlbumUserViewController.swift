//
//  AlbumUserViewController.swift
//  List Post
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class AlbumUserViewController: UIViewController {

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
    private let stackInfo: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 1
        stack.layoutMargins.left = 1
        stack.layoutMargins.right = 1
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(10)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.text = "Name: "
        return label
    }()
    private let labelEmail: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(10)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.text = "Email: "
        return label
    }()
    private let labelAddress: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(10)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.text = "Address: "
        return label
    }()
    private let labelCompany: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(10)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.text = "Company: "
        return label
    }()
    private let collectionViewAlbum: UICollectionView = {
        
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 10
        flow.minimumInteritemSpacing = 10
        flow.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flow)
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0)
        collectionView.allowsSelection = true
        collectionView.bouncesZoom = false
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let loadingSpinner = UIActivityIndicatorView()
    private let loadingView = UIView()
    
    private var viewModel: ListAlbumsVMGuideline?
    private var setUser: User?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLayout()
        setupConstraints()
        setupCollectionView()
        
        viewModel = ListAlbumsViewModel(useCase: UseCaseListAlbum(albumDataSource: AlbumDataSource(), photoDataSource: PhotoDataSource()))
        loadingSpinner.startAnimating()
        
        group.notify(queue: .main, execute: { [weak self] in
            self?.bind()
            if let getUser = self?.setUser {
                self?.viewModel?.loadUserAlbums(id: getUser.id, try: 3)
            }
        })
    }
    
    private func bind() {
        viewModel?.fetchError = { [weak self] _ in
            self?.loadingSpinner.stopAnimating()
            self?.loadingView.isHidden = true
        }
        viewModel?.albumsResult = { [weak self] _ in
            self?.loadingSpinner.stopAnimating()
            self?.loadingView.isHidden = true
            self?.collectionViewAlbum.reloadData()
            self?.updateCollectionHeighConstraint()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setupLayout() {
        view.addSubview(contentScrollView)
        
        contentScrollView.addSubview(viewTitle)
        
        viewTitle.addSubview(labelName)
        viewTitle.addSubview(labelEmail)
        viewTitle.addSubview(labelAddress)
        viewTitle.addSubview(labelCompany)
        stackInfo.addArrangedSubview(labelName)
        stackInfo.addArrangedSubview(labelEmail)
        stackInfo.addArrangedSubview(labelAddress)
        stackInfo.addArrangedSubview(labelCompany)
        viewTitle.addSubview(stackInfo)
        
        contentScrollView.addSubview(collectionViewAlbum)
        
        contentStackView.addArrangedSubview(viewTitle)
        contentStackView.addArrangedSubview(collectionViewAlbum)
        contentScrollView.addSubview(contentStackView)
        setLoadingView()
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["contentScrollView": contentScrollView, "viewTitle": viewTitle, "stackInfo": stackInfo, "collectionViewAlbum": collectionViewAlbum, "contentStackView": contentStackView]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        // MARK: contentScrollView constraints
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        let hContentScrollView = "H:|-0-[contentScrollView]-0-|"
        let vContentScrollView = "V:|-0-[contentScrollView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentScrollView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentScrollView, options: .alignAllLeading, metrics: metrix, views: views)
        
        // MARK: contentStackView constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let hContentStackView = "H:|-0-[contentStackView]-0-|"
        let vContentStackView = "V:|-0-[contentStackView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentStackView, options: .alignAllLeading, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: contentStackView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)]
        
        // MARK: stackTitle constraints
        stackInfo.translatesAutoresizingMaskIntoConstraints = false
        let hStackInfo = "H:|-0-[stackInfo]-0-|"
        let vStackInfo = "V:|-0-[stackInfo]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hStackInfo, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vStackInfo, options: .alignAllLeading, metrics: metrix, views: views)
        
        //MARK: collectionViewAlbum constraints
        collectionViewAlbum.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewHeight = NSLayoutConstraint(item: collectionViewAlbum, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: collectionViewAlbum.collectionViewLayout.collectionViewContentSize.height, constant: 0)
        collectionViewHeight.identifier = "collectionViewHeight"
        constraints += [collectionViewHeight]
        
        // MARK: viewTitle constraints
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: viewTitle, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 2/9, constant: 0)]
        
        // MARK: loadingView constraints
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .width, relatedBy: .equal, toItem: loadingView, attribute: .height, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: collectionViewAlbum, attribute: .top, relatedBy: .equal, toItem: loadingView, attribute: .top, multiplier: 1, constant: 20)]
        
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
    
    
    private func setupCollectionView() {
        collectionViewAlbum.delegate = self
        collectionViewAlbum.dataSource = self
        collectionViewAlbum.register(AlbumIconCollectionViewCell.self, forCellWithReuseIdentifier: "AlbumCell")
        collectionViewAlbum.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
    }
    
    private func updateCollectionHeighConstraint() {
        var constraints = collectionViewAlbum.constraints
        guard let containerHeigh = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "collectionViewHeight"
        }) else {
            return
        }
        
        NSLayoutConstraint.deactivate(constraints)

        print("collectionViewAlbum.collectionViewLayout.collectionViewContentSize.height:  \(collectionViewAlbum.collectionViewLayout.collectionViewContentSize.height)")
        
        constraints[containerHeigh] = NSLayoutConstraint(item: collectionViewAlbum, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: collectionViewAlbum.collectionViewLayout.collectionViewContentSize.height )
        constraints[containerHeigh].identifier = "collectionViewHeight"
        

        NSLayoutConstraint.activate(constraints)
        self.view.layoutIfNeeded()
    }

    func setData(user data: User) {
        group.enter()
        setUser = data
        self.navigationItem.title = "\(data.name)"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        labelName.text = "Name: \(data.name)"
        labelEmail.text = "Email: \(data.email)"
        labelCompany.text = "Company: \(data.company.name)"
        labelAddress.text = "Address: street \(data.address.street) suite \(data.address.suite), \(data.address.city), ZIP \(data.address.zipcode) "
        group.leave()
    }
    
}
extension AlbumUserViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.listAlbums.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? AlbumIconCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        
        
        if let getData = viewModel?.listAlbums[indexPath.item] {
            cell.setAlbum(album: getData)
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width) / 3.5
        
        return CGSize(width: Int(width), height: Int(width))
        
    }
}

