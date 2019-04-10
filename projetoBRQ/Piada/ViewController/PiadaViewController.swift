//
//  CategoriaViewController.swift
//  projetoBRQ
//
//  Created by Derick Nazzoni on 05/04/19.
//  Copyright © 2019 Derick Nazzoni. All rights reserved.
//

import UIKit

class PiadaViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var jokeImageView: UIImageView!
    @IBOutlet weak var jokeTextView: UITextView!
    @IBOutlet weak var loadJokeOutlet: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = "\(Global.name.uppercased())"
        loadJokeOutlet.startAnimating()
        
        PiadaREST.loadJokes(onComplete: { (piadaRetorno) in
            let piada = piadaRetorno
            DispatchQueue.main.sync {
                self.loadJokeOutlet.stopAnimating()
                self.loadJokeOutlet.hidesWhenStopped = true
                self.jokeTextView.text = piada.value
                
                self.loadImage(url: piada.icon_url)
                
            }
        }) { (error) in
            print(error)
        }

    }
    
    func loadImage(url: String){
        let image = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: image) { (data, response, error) in
            if error == nil{
                DispatchQueue.main.sync{
                let loadImage = UIImage(data: data!)
                
                self.jokeImageView.image = loadImage
                }
            }
        }
        task.resume()
    }
    
    
}
