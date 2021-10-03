//
//  ViewController.swift
//  21002
//
//  Created by kms on 2021/10/02.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let movieViewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getMovieData()
    }

    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "popularCell")
        tableView.register(UINib(nibName: "UpcomingTableViewCell", bundle: nil), forCellReuseIdentifier: "upmovieCell")
        tableView.register(UINib(nibName: "NowTableViewCell", bundle: nil), forCellReuseIdentifier: "nowCell")
    }

    func getMovieData() {
        movieViewModel.getMovies { [self] state in
            switch state {
            case .success:
                self.handleSuccessFetchUsers()
            case .failure:
                print(movieViewModel.message as Any)
                break
            }
        }
    }
    
    fileprivate func handleSuccessFetchUsers() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = self.tableView.indexPathForSelectedRow
        let detailVC = segue.destination as! DetailViewController
        if index?.section == 0 {
            detailVC.id = movieViewModel.popularMovies[index!.row].id
        }else if index?.section == 1 {
            detailVC.id = movieViewModel.nowMovies[index!.row].id
        }else {
            detailVC.id = movieViewModel.upMovies[index!.row].id
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PopularTableViewCell
            
            let movieViewModel = movieViewModel.popularMovies
            
            cell.config(with: movieViewModel)
            
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nowCell", for: indexPath) as! NowTableViewCell

            let movieViewModel = movieViewModel.nowMovies
            print(movieViewModel)

            cell.config(with: movieViewModel)

            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "upmovieCell", for: indexPath) as! UpcomingTableViewCell

            let movieViewModel = movieViewModel.upMovies

            cell.config(with: movieViewModel)

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 410
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Popular"
        }else if section == 1 {
            return "Now"
        }else {
            return "Upcoming"
        }
    }

    
}




