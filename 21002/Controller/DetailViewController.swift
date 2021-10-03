//
//  DetailViewController.swift
//  21002
//
//  Created by kms on 2021/10/02.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var id: Int = 0
    
    fileprivate var movie = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMovieInfo()
    }
    
    fileprivate func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "detailCell")
    }
    
    fileprivate func getMovieInfo() {
        movie.getMovieInfo(id: id) { [self] state in
            switch state {
            case .success:
                self.navigationItem.title = movie.movieInfo?.title
                self.handleSuccessFetchUsers()
            case .failure:
                print(movie.message as Any)
                break
            }
        }
    }

    fileprivate func handleSuccessFetchUsers() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! MovieInfoTableViewCell
        
        cell.imgView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + "\(movie.movieInfo?.img ?? "")"))
        cell.posterView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + "\(movie.movieInfo?.poster ?? "")"))
        cell.nameLabel.text = movie.movieInfo?.title
        cell.dateLabel.text = "\(movie.movieInfo?.date ?? "") 개봉"
        cell.overviewLabel.text = movie.movieInfo?.overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}
