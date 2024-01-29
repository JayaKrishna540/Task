import UIKit
import ARKit
 
class ViewController: UIViewController, ARSCNViewDelegate {
 
    @IBOutlet var sceneView: ARSCNView!
    var jokeManager: ARJokeManager!
 
    private lazy var recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Record", for: .normal)
        button.setTitle("Stop", for: .selected)
        button.addTarget(self, action: #selector(recordButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    
        jokeManager = ARJokeManager(sceneView: sceneView)
        
        jokeManager.startARSession()
    }
 
    private func setupUI() {
        // Add buttons to the view
        view.addSubview(recordButton)
 
        // Configure constraints for buttons
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
    }
 
    @objc private func recordButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            // Stop recording
     
            sender.isSelected = false
        } else {
            // Start recording
            sender.isSelected = true
        }
    }
 
    func recordingDidFinish(success: Bool, url: URL?) {
        if success {
            // Update UI or show a success message
            print("Recording completed! Video saved at \(url?.absoluteString ?? "N/A")")
        } else {
            // Handle recording failure
            print("Recording failed.")
        }
    }
}
