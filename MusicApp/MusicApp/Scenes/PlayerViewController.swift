import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    var player: AVAudioPlayer?
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Play"), for: .normal)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Next"), for: .normal)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Back"), for: .normal)
        return button
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = UIColor.systemBlue
        slider.maximumTrackTintColor = UIColor.lightGray
        slider.setThumbImage(UIImage(named: "slider_thumb"), for: .normal)
        return slider
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        configure()
    }
    
    //MARK: - configure
    func configure() {
        let song = songs[position]
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            let filePath = songs[position].trackName
            
            player = try AVAudioPlayer(contentsOf:URL(fileURLWithPath:filePath))
            guard let player = player else {
                print("player is nil")
                return
            }
            player.volume = 0.5
            player.play()
        } catch {
            print("error occurred")
        }
        
        albumImageView.image = UIImage(named: song.imageName)
        songNameLabel.text = song.name
        artistNameLabel.text = song.artistName
        albumNameLabel.text = song.albumName
        
        let uiElements = [albumImageView, songNameLabel, albumNameLabel, artistNameLabel, playPauseButton, nextButton, backButton, slider]
        for uiElement in uiElements {
            uiElement.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(uiElement)
        }
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            albumImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            albumImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor),
            
            songNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 20),
            songNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            albumNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 10),
            albumNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            albumNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 10),
            artistNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            artistNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playPauseButton.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 20),
            playPauseButton.widthAnchor.constraint(equalToConstant: 70),
            playPauseButton.heightAnchor.constraint(equalToConstant: 70),
            
            
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nextButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            backButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
    }
    
    //MARK: - didTapBackButton
    @objc func didTapBackButton() {
        if position > 0 {
            position = position - 1
            player?.stop()
            configure()
        }
    }
    
    //MARK: - didTapNextButton
    @objc func didTapNextButton() {
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            configure()
        }
    }
    
    //MARK: - didTapPlayPauseButton
    @objc func didTapPlayPauseButton() {
        if let player = player {
            if player.isPlaying {
                player.pause()
                playPauseButton.setImage(UIImage(named: "Play"), for: .normal)
                UIView.animate(withDuration: 0.2) {
                    self.albumImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                }
            } else {
                player.play()
                playPauseButton.setImage(UIImage(named: "Pause"), for: .normal)
                UIView.animate(withDuration: 0.2) {
                    self.albumImageView.transform = .identity
                }
            }
        }
    }
    
    //MARK: - didSlideSlider
    @objc func didSlideSlider(_ slider: UISlider) {
        if let player = player {
            let value = slider.value
            player.volume = value
        }
    }
    
    //MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
}
