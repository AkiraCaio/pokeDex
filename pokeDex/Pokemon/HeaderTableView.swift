//
//  HeaderTableView.swift
//  pokeDex
//
//  Created by akiracaio on 07/12/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import UIKit

protocol HeaderTableViewDelegate {
    func actionFav(fav: Bool)
    func filterPokm(text: String)
}

class HeaderTableView: UIView {
    
    let searcBar: UISearchBar = {
        let src = UISearchBar()
        
        src.translatesAutoresizingMaskIntoConstraints = false
        
        return src
    }()
    
    let favView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "pokebolaFavorito"))
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.tintColor = UIColor.black
        
        return img
    }()
    
    let gradientFavImage = CAGradientLayer()
    
    var showFav:Bool = false
    
    var delegate: HeaderTableViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupScreen()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupScreen() {
        
        self.backgroundColor = UIColor.white
        
        self.configSearchBar()
        self.configFavView()
        self.configImage()
    }
    
    private func configSearchBar() {
        
        self.searcBar.delegate = self
        
        self.addSubview(self.searcBar)
        
        NSLayoutConstraint.activate([
            
            self.searcBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            self.searcBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.searcBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
            
        ])
        
        self.searcBar.layer.borderWidth = 0
        self.searcBar.placeholder = "Search pokemon"
    }
    
    private func configFavView() {
        self.addSubview(self.favView)
        
        NSLayoutConstraint.activate([
            self.favView.centerYAnchor.constraint(equalTo: self.searcBar.centerYAnchor),
            self.favView.leftAnchor.constraint(equalTo: self.searcBar.rightAnchor, constant: 8),
            self.favView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            self.favView.widthAnchor.constraint(equalToConstant: 55),
            self.favView.heightAnchor.constraint(equalToConstant: 55),
        ])
        
        self.favView.layer.cornerRadius = 55 / 2
        self.favView.clipsToBounds = true
        
        
        if (self.showFav) {
            
            let colorTop = UIColor(red: 221 / 255, green: 62 / 255, blue: 62 / 255, alpha: 1).cgColor
            let colorBottom = UIColor(red: 133 / 255, green: 69 / 255, blue: 37 / 255, alpha: 1).cgColor
            
            self.gradientFavImage.frame = self.favView.bounds
            self.gradientFavImage.colors = [colorTop, colorBottom]
            self.gradientFavImage.locations = [0.0, 1.0]
            
            self.favView.layer.insertSublayer(self.gradientFavImage, at: 0)
            
            
        }
    }
    
    private func configImage() {
        self.favView.addSubview(self.imageView)
        
        NSLayoutConstraint.activate([
            
            self.imageView.centerYAnchor.constraint(equalTo: self.favView.centerYAnchor),
            self.imageView.centerXAnchor.constraint(equalTo: self.favView.centerXAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: 60),
            self.imageView.widthAnchor.constraint(equalToConstant: 60)
        ])
                
        self.favView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HeaderTableView.favAction)))
    }
    
    @objc private func favAction() {
        self.showFav = !self.showFav
        
        self.searcBar.text = ""
        
        if (self.showFav) {
            
            let colorTop = UIColor(red: 221 / 255, green: 62 / 255, blue: 62 / 255, alpha: 1).cgColor
            let colorBottom = UIColor(red: 133 / 255, green: 69 / 255, blue: 37 / 255, alpha: 1).cgColor
            
            self.gradientFavImage.frame = self.favView.bounds
            self.gradientFavImage.colors = [colorTop, colorBottom]
            self.gradientFavImage.locations = [0.0, 1.0]
            
            self.favView.layer.insertSublayer(self.gradientFavImage, at: 0)
            
            
        }else {
            self.gradientFavImage.removeFromSuperlayer()
        }
                
        self.delegate.actionFav(fav: self.showFav)
    }
}

extension HeaderTableView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.delegate.filterPokm(text: searchText.lowercased())
    }
    
}
