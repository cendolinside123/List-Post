//
//  DetailPictViewController.swift
//  List Post
//
//  Created by Jan Sebastian on 12/03/22.
//

import UIKit

class DetailPictViewController: UIViewController {

    private let group = DispatchGroup()
    
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
    
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.minimumZoomScale = -1.0
        scrollView.maximumZoomScale = 4.0
        return scrollView
    }()
    
    private let picture: UIImageView = {
        let pict = UIImageView()
        pict.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        pict.image = #imageLiteral(resourceName: "loading")
        pict.contentMode = .scaleAspectFill
        pict.clipsToBounds = true
        return pict
    }()
    
    private var photoInfo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneSelect(sender: )))
        addLayout()
        addConstraints()
        contentScrollView.delegate = self
        group.notify(queue: .main, execute: { [weak self] in
            if let getData = self?.photoInfo {
                self?.picture.setImage(url: getData.url, times: 4)
                self?.lblNama.text = getData.title
                self?.contentScrollView.zoomScale = 0.5
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
    
    private func addLayout() {
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(picture)
        view.addSubview(lblNama)
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["contentScrollView": contentScrollView, "lblNama": lblNama, "picture": picture]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        // MARK: contentScrollView constraints
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        let hContentScrollView = "H:|-0-[contentScrollView]-0-|"
        let vContentScrollView = "V:|-[contentScrollView]-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentScrollView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentScrollView, options: .alignAllLeading, metrics: metrix, views: views)
        
        // MARK: lblAlbum constraints
        lblNama.translatesAutoresizingMaskIntoConstraints = false
        let hLblAlbum = "H:|-[lblNama]-|"
        constraints += [NSLayoutConstraint(item: lblNama, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLblAlbum, options: .alignAllTop, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: lblNama, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -15)]
        
        // MARK: picture constraints
        picture.translatesAutoresizingMaskIntoConstraints = false
        let hPicture = "H:|-[picture]-|"
        let vPicture = "V:|-[picture]-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hPicture, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vPicture, options: .alignAllLeading, metrics: metrix, views: views)
        
        
        NSLayoutConstraint.activate(constraints)
    }
}
extension DetailPictViewController {
    @objc private func doneSelect(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailPictViewController {
    func showDetail(pic data: Photo) {
        group.enter()
        self.navigationItem.title = data.title
        photoInfo = data
        group.leave()
    }
    
    
}

extension DetailPictViewController: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > scrollView.maximumZoomScale {
            scrollView.zoomScale = scrollView.maximumZoomScale
        } else if scrollView.zoomScale < scrollView.minimumZoomScale {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return picture
    }
}

