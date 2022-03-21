//
//  HomeViewController.swift
//  List Post
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit
import Loading

class HomeViewController: UIViewController {
    
    private let tblPost: UITableView = {
        let tabel = UITableView()
        tabel.backgroundColor = UIColor(white: 1, alpha: 0)
        tabel.allowsSelection = true
        tabel.bouncesZoom = false
        tabel.bounces = false
        tabel.showsVerticalScrollIndicator = false
        return tabel
    }()
    
//    private let loadingSpinner = UIActivityIndicatorView()
    private let loadingView = LoadingView()
    private var uiControll: ListUIGuideHelper?
    private var viewModel: ListPostVMGuideline?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "List Post"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.view.backgroundColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1)
        addLayout()
        addConstraints()
        uiControll = ListProductUIControll(controller: self)
        uiControll?.showLoading(completion: nil)
        let useCase = UseCaseListPost(postDataSource: PostDataSource(), userDataSource: UserDataSource())
        viewModel = ListPostViewModel(useCase: useCase)
        setupTabel()
        bind()
        viewModel?.loadListPost(try: 3)
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
            self?.uiControll?.hideLoading(completion: nil)
        }
        viewModel?.postResult = { [weak self] _ in
            self?.tblPost.reloadData()
            self?.uiControll?.hideLoading(completion: nil)
        }
    }
    
    private func addLayout() {
        setLoadingView()
        addTabel()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["tblPost": tblPost, "loadingView": loadingView]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        // MARK: tblPost and loadingView constraints
        tblPost.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        let hTblPost = "H:|-[tblPost]-|"
        let vLoadingViewTblPost = "V:|-[loadingView]-0-[tblPost]-0-|"
        let hLoadingView = "H:|-0-[loadingView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTblPost, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vLoadingViewTblPost, options: .alignAllCenterX, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLoadingView, options: .alignAllTop, metrics: metrix, views: views)
        let loadingViewHeight = NSLayoutConstraint(item: loadingView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/9, constant: 0)
        loadingViewHeight.identifier = "loadingViewHeight"
        constraints += [loadingViewHeight]
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func addTabel() {
        view.addSubview(tblPost)
    }
    
    private func setLoadingView() {
//        loadingView.backgroundColor = .white
        loadingView.startAnimate()
        view.addSubview(loadingView)
    }
    
    private func setupTabel() {
        tblPost.delegate = self
        tblPost.dataSource = self
        tblPost.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tblPost.rowHeight = UITableView.automaticDimension
        tblPost.estimatedRowHeight = 250
        tblPost.tableFooterView = UIView()
        
    }

}
extension HomeViewController {
    func getLoadingView() -> LoadingView {
        return loadingView
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.listPost.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        if let data = viewModel?.listPost[indexPath.section] {
            cell.setPost(post: data)
        } else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = viewModel?.listPost[indexPath.section] {
            print("Post id: \(data.id)")
            
            let detailVC = DetailPostViewController()
            detailVC.setPostDetail(post: data)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        uiControll?.scrollControll(scrollView: scrollView, completion: { [weak self] in
            self?.viewModel?.loadListPost(try: 3)
        })
    }
    
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return 350
//    }
//    
}
