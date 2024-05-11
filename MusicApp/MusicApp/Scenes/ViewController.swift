//
//  ViewController.swift
//  MusicApp
//
//  Created by Default on 10.05.24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var table: UITableView = {
        let table = UITableView()
        return table
    }()
    
    var songs = [Song]()
    
    lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainView()
        configureViews()
        configureSong()
    }
    
    //MARK: - configureViews
    func configureViews() {
        table.frame = view.bounds
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "SongCell")
        mainView.addSubview(table)
    }
    
    //MARK: - configureMainView
    func configureMainView() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        mainView.backgroundColor = UIColor.white
    }
    
    //MARK: - configureSong
    func configureSong() {
        songs.append(Song(name: "Mapatie",
                          albumName: "gialo",
                          artistName: "Gia Suramelashvili",
                          imageName: "Image1",
                          trackName: "/Users/default/Desktop/gia_suramelashvili_-gapatieb.mp3"))
        songs.append(Song(name: "Ghamis sichume gafante",
                          albumName: "wurwu123",
                          artistName: "Lela Wurwumia",
                          imageName: "Image2",
                          trackName: "/Users/default/Desktop/gia_suramelashvili_-gapatieb.mp3"))
        songs.append(Song(name: "Ubedo sikvaruli",
                          albumName: "XatiaCool",
                          artistName: "Xatia Wereteli",
                          imageName: "Image3",
                          trackName: "gia_suramelashvili_-gapatieb.mp3"))
        songs.append(Song(name: "Bedi",
                          albumName: "gialo",
                          artistName: "Gia Suramelashvili",
                          imageName: "Image1",
                          trackName: "/Users/default/Desktop/gia_suramelashvili_-gapatieb.mp3"))
        songs.append(Song(name: "Aghar minda me shentan",
                          albumName: "wurwu123",
                          artistName: "Lela Wurwumia",
                          imageName: "Image2",
                          trackName: "/Users/default/Desktop/gia_suramelashvili_-gapatieb.mp3"))
        songs.append(Song(name: "Ar gamabrazo",
                          albumName: "XatiaCool",
                          artistName: "Xatia Wereteli",
                          imageName: "Image3",
                          trackName: "/Users/default/Desktop/gia_suramelashvili_-gapatieb.mp3"))
        
        table.reloadData()
    }
}

//MARK: - extension ViewController
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        let song = songs[indexPath.row]
        
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 60, height: 60))
        imageView.image = UIImage(named: song.imageName)
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        
        let nameLabel = UILabel(frame: CGRect(x: 80, y: 10, width: tableView.frame.width - 90, height: 20))
        nameLabel.text = song.name
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.contentView.addSubview(nameLabel)
        
        let artistLabel = UILabel(frame: CGRect(x: 80, y: 35, width: tableView.frame.width - 90, height: 20))
        artistLabel.text = song.artistName
        artistLabel.font = UIFont(name: "Helvetica", size: 17)
        cell.contentView.addSubview(artistLabel)
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        let playerViewController = PlayerViewController()
        playerViewController.songs = songs
        playerViewController.position = position
        navigationController?.pushViewController(playerViewController, animated: true)
    }
}
