//
//  NewsViewController.swift
//  ProjectNews
//
//  Created by edgars.vasiljevs on 24/11/2021.
//

import UIKit
import CoreData


class NewsViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cView1: UICollectionView!
    @IBOutlet weak var cView2: UICollectionView!
    @IBOutlet weak var cView3: UICollectionView!
    
    @IBOutlet var collView: UIView!
    private let searchVC = UISearchController(searchResultsController: nil)
    let titles = Title.createTitle()
    let titles2 = Title.createTitle2()
    let titles3 = Title.createTitle3()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
    }
    
    // MARK: Create Search Bar
    
    func createSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    // MARK: Search Bar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else{return}
        print(text)
        let keyword = text.filter {!$0.isWhitespace}
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "NewsFeedViewController") as? NewsFeedViewController else {return}
        
        vc.searchResult = keyword
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cView1.dequeueReusableCell(withReuseIdentifier: "NewsCell1", for: indexPath) as? News1CollectionViewCell else {
            print("went to wrong cell")
            return UICollectionViewCell()}
        
        if (collectionView == cView2){
            guard let cell2 = cView2.dequeueReusableCell(withReuseIdentifier: "NewsCell2", for: indexPath) as? News2CollectionViewCell else {
                print("went to wrong cell")
                return UICollectionViewCell()}
            
            let name = titles2[indexPath.row]
            cell2.newsCollectionLabel.text = name.title
            cell2.newsCollectionImage.image = UIImage(named: name.poster)
            
            return cell2}
        
        if (collectionView == cView3){
            guard let cell3 = cView3.dequeueReusableCell(withReuseIdentifier: "NewsCell3", for: indexPath) as? News3CollectionViewCell else {
                print("went to wrong cell")
                return UICollectionViewCell()}
            
            let name = titles3[indexPath.row]
            cell3.newsCollectionLabel.text = name.title
            cell3.newsCollectionImage.image = UIImage(named: name.poster)
            
            return cell3}
        
        let name = titles[indexPath.row]
        cell.newsCollectionLabel.text = name.title
        cell.newsCollectionImage.image = UIImage(named: name.poster)
        
        
        return cell
    }
    
    
    //MARK: - Navigate to
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected article: \(titles[indexPath.row])")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "NewsFeedViewController") as? NewsFeedViewController else {return}
        let item = titles[indexPath.row]
        vc.searchResult = item.title
        if (collectionView == cView2){
            let item2 = titles2[indexPath.row]
            vc.searchResult = item2.title}
        if (collectionView == cView3){
            let item3 = titles3[indexPath.row]
            vc.searchResult = item3.title}
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
