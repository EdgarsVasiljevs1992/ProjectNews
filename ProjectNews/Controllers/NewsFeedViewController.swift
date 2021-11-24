//
//  NewsFeedViewController.swift
//  NewsApiOrg
//
//  Created by edgars.vasiljevs on 19/11/2021.
//

import UIKit
import SDWebImage

class NewsFeedViewController: UIViewController {
    
    var newsItems: [NewsItem] = []
    var searchResult = String()
    //#warning("put your newsapi.org apikey here:")
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var apiKey = "1e261015f5d84906b476364c53716e1a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(searchResult) News"
        handleGetData()
//        self.tblView.delegate
//        self.tblView.dataSource
    }
//    @IBAction func fetchData(_ sender: Any) {
//        tblView.reloadData()
//        basicAlert(title: "Plane!", message: "Tabble view data reloaded.")
//    }
//    @IBAction func infoAlert(_ sender: Any) {
//        basicAlert(title: "Some info!", message: "Search keyword: \(searchResult).")
//    }
    
    

    func activityIndicator(animated: Bool){
        DispatchQueue.main.async {
            if animated{
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.startAnimating()
            }else{
                self.activityIndicatorView.isHidden = true
                self.activityIndicatorView.startAnimating()
            }
        }
        
    }
    
    func handleGetData(){
        activityIndicator(animated: true)
        let jsonUrl = "https://newsapi.org/v2/everything?q=\(searchResult)&apiKey=\(apiKey)"
        
        guard let url = URL(string: jsonUrl) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: urlRequest) { (data, response, error)  in
            if error != nil {
                print((error?.localizedDescription)!)
                self.basicAlert(title: "Error!", message: "\(String(describing: error?.localizedDescription))")
                return
            }
            guard let data = data else {
                self.basicAlert(title: "Error!", message: "Something went wrong no data.")
                return
            }
            do{
                let jsonData = try
                JSONDecoder().decode(Articles.self, from: data)
                self.newsItems = jsonData.articles
                DispatchQueue.main.async {
                    print("self.newItems: ", self.newsItems)
                    self.tblView.reloadData()
                    self.activityIndicator(animated: false)
                }
            }catch{
                print("err:", error)
            }
        }.resume()
//      #warning("complete URLSession(configuration: to print(jsonData of Articles)")
        //}.resume()
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "appleCell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        
        let item = newsItems[indexPath.row]
        cell.newsTitleLabel.text = item.title
        cell.newsTitleLabel.numberOfLines = 0
        cell.newsImageView.sd_setImage(with: URL(string: item.urlToImage ?? ""), placeholderImage: UIImage(named: "news.png"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        let item = newsItems[indexPath.row]
        vc.newsImage = item.urlToImage ?? ""
        vc.titleString = item.title
        vc.webUrlString = item.url ?? ""
        vc.contentString = item.description ?? ""
        
        //present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
