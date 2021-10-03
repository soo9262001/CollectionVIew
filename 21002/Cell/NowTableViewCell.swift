//
//  NowTableViewCell.swift
//  21002
//
//  Created by kms on 2021/10/02.
//

import UIKit
import Kingfisher

protocol CellDelegate {
    func selectedCell(_ index: Int)
}

class NowTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var nowModel = [MovieModel]()
    
    var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "popularCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func config(with movieModels: [MovieModel]) {
        self.nowModel = movieModels
        collectionView.reloadData()
    }
    
    
}

extension NowTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PopularCollectionViewCell
        
        let movie = nowModel[indexPath.row]
        
        cell.nameLabel.text = movie.title
        cell.imgView.kf.setImage(with: URL(string:"https://image.tmdb.org/t/p/w500" + "\(movie.img ?? "")"))
        cell.floatView.rating = Double(movie.average! / 2)
        
        return cell
    }
    
}

extension NowTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - 1, height: collectionView.frame.size.height)
    }
}
