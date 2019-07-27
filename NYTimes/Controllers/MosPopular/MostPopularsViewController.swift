//
//  MostPopularsViewController.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

class MostPopularsViewController: UIViewController {

    // MARK:- IBOutlets -
    @IBOutlet private weak var tableView: UITableView!
    
    private var tempRefreshControl: UIRefreshControl? = nil
    private var refreshControl: UIRefreshControl {
        get{
            guard let _: UIRefreshControl = tempRefreshControl else {
                
                tempRefreshControl = UIRefreshControl()
                tempRefreshControl?.backgroundColor = UIColor.clear
                tempRefreshControl?.tintColor = UIColor.black
                tempRefreshControl?.addTarget(self,
                                              action: #selector(refreshContent),
                                              for: UIControl.Event.valueChanged)
                
                return tempRefreshControl!
            }
            return tempRefreshControl!
        }
        set{
            tempRefreshControl = newValue
        }
    }
    
    // MARK:- Variables -
    
    private let viewModel = MostPopularViewModel()
    
    private var arrPopulars = [DataObserver<MostPopularCellViewModel>]()
    
    private let tableSerialQueue:DispatchQueue = DispatchQueue(label: "com.nytimesTable")
    
    private let cellIdentifier: String = "popularCell"
    
    // MARK:- Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitials()
    }
    
    // MARK:- Helpers -
    
    func setupInitials() {
        
        self.title = "NY Times Most Popular"
        
        dataBinding()
        setupTable()
        setupRefreshControl()
        fetchNewPopulars()
    }
    
    func setupRefreshControl() {
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    func dataBinding() {
        
        viewModel.isRequestInProgress.bind {[weak self] (isWorking) in
            if isWorking {
                self?.startRefreshing()
            } else {
                self?.endRefreshing()
            }
        }
        
        viewModel.arrPopulars.bind {[weak self] (populars) in
            
            self?.arrPopulars = populars.map{ DataObserver<MostPopularCellViewModel>(MostPopularCellViewModel(info: $0)) }
            
            self?.refreshTable()
        }
    }
    
    // MARK:- Table Helpers -
    
    func setupTable() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MostPopularTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func refreshTable() {
        
        weak var weakSelf = self
        
        tableSerialQueue.async {
            weakSelf?.moveToMainThread({
                weakSelf?.tableView.reloadData()
            })
        }
    }

    // MARK:- Actions -
    
    @objc func refreshContent() {

        fetchNewPopulars()
    }
    
    func startRefreshing() {
        
        weak var weakSelf = self
        moveToMainThread {
            if !(weakSelf?.refreshControl.isRefreshing ?? true) {
                
                weakSelf?.refreshControl.beginRefreshing()
                weakSelf?.tableView.setContentOffset(
                    CGPoint(x: 0, y: (weakSelf?.refreshControl.frame.size.height ?? 0)),
                    animated: true)
            }
        }
    }
    
    func endRefreshing() -> Void {
        
        moveToMainThread {[weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    // MARK:- Apis -
    
    func fetchNewPopulars() {
        
        viewModel.fetchNewSearchResults(forDays: 1, searchText: nil)
    }
}


extension MostPopularsViewController : UITableViewDelegate {
    
}

extension MostPopularsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPopulars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let popularCell = cell as? MostPopularTableViewCell,
            indexPath.row < arrPopulars.count{
            popularCell.populateInfo(arrPopulars[indexPath.row])
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}
