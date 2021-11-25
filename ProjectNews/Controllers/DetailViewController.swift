//
//  DetailViewController.swift
//  NewsApiOrg
//
//  Created by edgars.vasiljevs on 20/11/2021.
//

import UIKit
import SDWebImage
import CoreData

class DetailViewController: UIViewController {
    
    
    var savedItems = [Items]()
    var context: NSManagedObjectContext?
    
    var webUrlString = String()
    var titleString = String()
    var contentString = String()
    var newsImage = String()
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString
        contentTextView.text = contentString
        newsImageView.sd_setImage(with: URL(string: newsImage), placeholderImage: UIImage(named: "news.png"))
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        }
 
    //MARK: Save Data
    
    func saveData(){
        do{
            try context?.save()
            basicAlert(title: "Saved!", message: "Please go to saved tab bar to see your saved data!")
        }catch{
            fatalError("error in saving core data item")
        }
    }
  
    //MARK: Action save button
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let item = Items(context: context!)
        
        item.url = webUrlString
        item.image = newsImage
        item.newsContent = contentString
        item.newsTitle = titleString
        
        savedItems.append(item)
        saveData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard let destinationVC: WebViewController = segue.destination as? WebViewController else{return print("destinationVC as WebViewController did not load")}
                destinationVC.urlString = webUrlString
    }
}
