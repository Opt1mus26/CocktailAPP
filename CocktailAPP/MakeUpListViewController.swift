//
//  TableViewController.swift
//  CocktailAPP
//
//  Created by Pavel Tsyganov on 27.11.2021.
//

import UIKit

class MakeUpListViewController: UITableViewController {
    
    @IBOutlet var activitiIndicator: UIActivityIndicatorView!
    
    var makeUps: MakeUp = []
    
    let link = "https://makeup-api.herokuapp.com/api/v1/products.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitiIndicator.startAnimating()
        activitiIndicator.hidesWhenStopped = true
        tableView.rowHeight = 100
        fetchMakeUp()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        makeUps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let makeUp = makeUps[indexPath.row]
        
        cell.configure(with: makeUp)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let detailsVC = segue.destination as? DetailViewController else { return }
            detailsVC.dataMakeUp = makeUps[indexPath.row]
        }
    }
    
}

extension MakeUpListViewController {
    func fetchMakeUp() {
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No eror description")
                return
            }
            do {
                self.makeUps = try JSONDecoder().decode(MakeUp.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activitiIndicator.stopAnimating()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
