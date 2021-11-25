//
//  NewsViewController.swift
//  ProjectNews
//
//  Created by edgars.vasiljevs on 24/11/2021.
//

import UIKit


class NewsViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cView1: UICollectionView!
    @IBOutlet weak var cView2: UICollectionView!
    @IBOutlet weak var cView3: UICollectionView!
    
    @IBOutlet var collView: UIView!
    private let searchVC = UISearchController(searchResultsController: nil)
        let titles = Title.createTitle()
        let titles2 = Title.createTitle2()
        let titles3 = Title.createTitle3()
        //let dataSource: [String] = ["1", "2", "3", "4"]
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Register cell classes
    //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "NewsCell")

            // Do any additional setup after loading the view.
            createSearchBar()
        }
    
//        override func reloadInputViews() {
//        createSearchBar()
//        }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        <#code#>
//    }
    
    
    
        override func viewWillAppear(_ animated: Bool) {
            collView.reloadInputViews()
            
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
            
            //present(vc, animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        // MARK: UICollectionViewDataSource

    //    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }


        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            if (collectionView == cView2){
//                return 3}
//            if (collectionView == cView3){
//                return 3}
            // #warning Incomplete implementation, return the number of items
            return 3
        }

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
            // Configure the cell

            return cell2}
            
            if (collectionView == cView3){
            guard let cell3 = cView3.dequeueReusableCell(withReuseIdentifier: "NewsCell3", for: indexPath) as? News3CollectionViewCell else {
                print("went to wrong cell")
                return UICollectionViewCell()}
           
            let name = titles3[indexPath.row]
            cell3.newsCollectionLabel.text = name.title
            cell3.newsCollectionImage.image = UIImage(named: name.poster)
            // Configure the cell

            return cell3}
            
            let name = titles[indexPath.row]
            cell.newsCollectionLabel.text = name.title
            cell.newsCollectionImage.image = UIImage(named: name.poster)
            // Configure the cell

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
            
            //present(vc, animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    //    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //
    //        var cell = UICollectionViewCell()
    //        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCollectionViewCell{
    //            countryCell.configure(with: dataSource[indexPath.row])
    //
    //            cell = countryCell
    //        }
    //        return cell
    //    }
        
        // MARK: UICollectionViewDelegate

        /*
        // Uncomment this method to specify if the specified item should be highlighted during tracking
        override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
            return true
        }
        */

        /*
        // Uncomment this method to specify if the specified item should be selected
        override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
            return true
        }
        */

        /*
        // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
        override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
            return false
        }

        override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
            return false
        }

        override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
        }
        */

    }
