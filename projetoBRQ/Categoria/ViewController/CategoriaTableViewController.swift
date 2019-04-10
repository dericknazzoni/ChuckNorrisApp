//
//  ViewController.swift
//  projetoBRQ
//
//  Created by Derick Nazzoni on 02/04/19.
//  Copyright © 2019 Derick Nazzoni. All rights reserved.
//

import UIKit

class CategoriaTableViewController: UITableViewController {

    var categories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CategoriaREST.loadCategories(onComplete: { (categorias) in
            self.categories = categorias
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let view = segue.destination as! PiadaViewController
//        view.categoriaTable = self
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let category = categories[indexPath.row];
            cell.textLabel?.text = "\(category.uppercased())"
            cell.textLabel?.font = UIFont(name: "Marker Felt", size: 20.0)
            tableView.tableFooterView = UIView()
            return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row];
        Global.name = category
    }

}

