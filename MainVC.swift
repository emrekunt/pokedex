//
//  MainVC.swift
//  Pokedex
//
//  Created by Emre Kunt on 27/04/2017.
//  Copyright © 2017 usturlapp. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    

    var musicPlayer: AVAudioPlayer!
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var isSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = .done
        
        parsePokemonCSV()
        initAudio()
        
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "pokemonTheme", ofType: "mp3")!
        
        do{
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        
        }catch let err as NSError{
            print(err.debugDescription)
        }
    
    }
    
    
    @IBAction func volumeButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            volumeButton.setImage(UIImage(named: "volumeoff"), for: .normal)
            
        }else{
            musicPlayer.play()
            volumeButton.setImage(UIImage(named: "volumeon"), for: .normal)
        }
        
    }
    
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do{
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows{
                let pokeid = Int(row["id"]!)!
                let name = row["identifier"]!

                let pokemon = Pokemon(name: name, pokeid: pokeid)
                pokemons.append(pokemon)
            
            }
        
        }catch let  err as NSError{
            print(err.debugDescription)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            var poke :Pokemon!
            if isSearchMode{
                poke = filteredPokemons[indexPath.row]
            }else{
                poke = pokemons[indexPath.row]
            }
            
            cell.configureCell(pokemon: poke)
            return cell
        
        }else{
        
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { 
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count:Int!
        
        if isSearchMode{
            count = filteredPokemons.count
        }else{
            count = pokemons.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearchMode = false
            collectionView.reloadData()
            //view.endEditing(true)
            
        }else{
            isSearchMode = true
            let lower = searchBar.text?.lowercased()
            filteredPokemons = pokemons.filter({$0.name.range(of: lower!) != nil})
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

}
