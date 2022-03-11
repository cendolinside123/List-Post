//
//  HomeViewController.swift
//  List Post
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let tblPost: UITableView = {
        let tabel = UITableView()
        tabel.backgroundColor = .white
        tabel.allowsSelection = true
        return tabel
    }()
    
    private let loadingSpinner = UIActivityIndicatorView()
    private let loadingView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Sort Heroes"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        
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
        setLoadingView()
        addTabel()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["tblPost": tblPost, "loadingView": loadingView, "loadingSpinner": loadingSpinner]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        // MARK: tblMenu constraints
        tblPost.translatesAutoresizingMaskIntoConstraints = false
        let hTblPost = "H:|-[tblPost]-|"
        let vLoadingViewTblPost = "V:|-0-[loadingView]-0-[tblPost]-0-|"
        let hLoadingView = "H:|-0-[loadingView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTblPost, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vLoadingViewTblPost, options: .alignAllLeading, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLoadingView, options: .alignAllTop, metrics: metrix, views: views)
        
        // MARK: loadingSpinner constraints
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerX, relatedBy: .equal, toItem: loadingView, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerY, relatedBy: .equal, toItem: loadingView, attribute: .centerY, multiplier: 1, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func addTabel() {
        view.addSubview(tblPost)
    }
    
    private func setLoadingView() {
        loadingSpinner.color = .gray
        loadingView.addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
        loadingView.backgroundColor = .white
        view.addSubview(loadingView)
    }

}
extension HomeViewController {
    public func getLoadingView() -> UIView {
        return loadingView
    }
    
    public func getLoadingSpinner() -> UIActivityIndicatorView {
        return loadingSpinner
    }
}
