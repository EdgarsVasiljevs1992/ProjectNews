import UIKitclass SearchTableViewController: UITableViewController {
  var filterData: [String]!
  override func viewDidLoad() {
    super.viewDidLoad()
  }
// MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filterData.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
      cell.textLabel?.text = filterData[indexPath.row]
      return cell
    }
  }
