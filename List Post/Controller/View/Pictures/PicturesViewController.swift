//
//  PicturesViewController.swift
//  List Post
//
//  Created by Jan Sebastian on 12/03/22.
//

import UIKit

class PicturesViewController: UIViewController {
    
    private var group = DispatchGroup()
    private let collectionViewPictures: UICollectionView = {
        
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
    
    private var viewModel: ListPhotosVMGuideline?
    private var viewWidth: CGFloat = 0
    private var setAlbum: Album?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        viewWidth = view.bounds.width
        addLayout()
        addConstraints()
        setupCollectionView()
        viewModel = ListPhotosViewModel(useCase: PhotoDataSource())
        bind()
        group.notify(queue: .main, execute: { [weak self] in
            if let getAlbum = self?.setAlbum {
                self?.viewModel?.loadPhotos(id: getAlbum.id, try: 3)
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
        viewModel?.fetchError = {[weak self] _ in
            self?.loadingSpinner.stopAnimating()
            self?.loadingView.isHidden = true
        }
        viewModel?.photosResult = { [weak self] _ in
            self?.loadingSpinner.stopAnimating()
            self?.loadingView.isHidden = true
            self?.collectionViewPictures.reloadData()
        }
    }
    
    private func setLoadingView() {
        loadingSpinner.color = .gray
        loadingView.addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
        loadingView.backgroundColor = .white
        view.addSubview(loadingView)
    }
    
    
    private func addLayout() {
        view.addSubview(collectionViewPictures)
        setLoadingView()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["collectionViewPictures": collectionViewPictures]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        
        //MARK: collectionViewPictures constraints
        collectionViewPictures.translatesAutoresizingMaskIntoConstraints = false
        let hCollectionViewPictures = "H:|-0-[collectionViewPictures]-0-|"
        let vCollectionViewPictures = "V:|-[collectionViewPictures]-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hCollectionViewPictures, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vCollectionViewPictures, options: .alignAllLeading, metrics: metrix, views: views)
        
        // MARK: loadingView constraints
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .width, relatedBy: .equal, toItem: loadingView, attribute: .height, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: collectionViewPictures, attribute: .top, relatedBy: .equal, toItem: loadingView, attribute: .top, multiplier: 1, constant: CGFloat(Int(collectionViewPictures.bounds.height/2)))]
        
        // MARK: loadingSpinner constraints
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerX, relatedBy: .equal, toItem: loadingView, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerY, relatedBy: .equal, toItem: loadingView, attribute: .centerY, multiplier: 1, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCollectionView() {
        collectionViewPictures.delegate = self
        collectionViewPictures.dataSource = self
        collectionViewPictures.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: "PicCell")
        collectionViewPictures.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
    }

    
    func setData(album data: Album) {
        group.enter()
        setAlbum = data
        self.navigationItem.title = "\(data.title)"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        group.leave()
    }
}
extension PicturesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.listPhotos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as? PictureCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        
        if let getData = viewModel?.listPhotos[indexPath.item] {
            cell.setThumbnail(thumbnail: getData.thumbnailUrl)
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (viewWidth) / 3.5
        
        return CGSize(width: Int(width), height: Int(width))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as? PictureCollectionViewCell else {
            return
        }
        cell.returnPicture().kf.cancelDownloadTask()
        cell.returnPicture().image = #imageLiteral(resourceName: "loading")
    }
}
