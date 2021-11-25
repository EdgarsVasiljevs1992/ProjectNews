//
//  SavedTableViewController.swift
//  NewsApiOrg
//
//  Created by edgars.vasiljevs on 20/11/2021.
//

import UIKit
import CoreData
import SDWebImage

class SavedTableViewController: UITableViewController {
    
    var savedItems = [Items]()
    var context: NSManagedObjectContext?
    var webUrlString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Saved articles"
        
        tableView.reloadData()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        self.loadData()
    }
    
    //MARK: Action delete all saved data
    
    @IBAction func deleteAllSavedData(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete All Saved articles?", message: "Do you want to delete them all?", preferredStyle: .actionSheet)
        let addActionButton = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteAllData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addActionButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
        self.saveData()
        self.loadData()
    }
    
    //MARK: - Delete all data
    
    func deleteAllData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        let delete: NSBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do{
            try context?.execute(delete)
            saveData()
        }catch let err{
            print(err.localizedDescription)
        }
    }
    
    //MARK: - Load data when view appears
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.isEditing = false
        loadData()
    }
    
    //MARK: - Save data
    
    func saveData() {
        do {
            try self.context?.save()
        }catch{
            print(error.localizedDescription)
        }
        loadData()
    }
    
    //MARK: - Load data
    
    func loadData() {
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        
        do{
            savedItems = try (context?.fetch(request))!
        }catch{
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    
    //MARK: - Number of rows in section
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if savedItems.count == 0 {
            tableView.setEmptyView(title: "You don't have any saved articles.", message: "Your saved articles will be in here.")
        }
        else {
            tableView.restore()
        }
        return savedItems.count
    }
    
    //MARK: - Write item in cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedArticleCell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        
        let item = savedItems[indexPath.row]
        cell.newsImageView.sd_setImage(with: URL(string: item.image!), placeholderImage: UIImage(named: "news.png"))
        cell.newsTitleLabel.text = item.newsTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    //MARK: - Confirmation of delete item
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete article", message: "Are you sure you want to delete this article?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                let item = self.savedItems[indexPath.row]
                self.context?.delete(item)
                self.saveData()
                self.loadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else {return}
        vc.urlString = self.savedItems[indexPath.row].url!
        navigationController?.pushViewController(vc, animated: true)
    }
}
