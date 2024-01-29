
import ARKit
 
class ARJokeManager {
    
    private var sceneView: ARSCNView
    private var apiClient: APIClient
    
    init(sceneView: ARSCNView) {
        self.sceneView = sceneView
        self.apiClient = APIClient()
        setupGestureRecognizers()
    }
 
    func startARSession() {
        // Set up AR session and configurations
    }
 
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tapGesture)
    }
 
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            fetchAndDisplayJoke()
        }
    }
 
    private func displayJokeInAR(joke: String) {
        // Create AR nodes and display the joke in the AR environment
        let jokeNode = SCNText(string: joke, extrusionDepth: 1.0)
        let node = SCNNode(geometry: jokeNode)
        // Set the position of the node in the AR world
        // Add the node to the scene
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    private func fetchAndDisplayJoke() {
        apiClient.fetchJoke { result in
            switch result {
            case .success(let joke):
                DispatchQueue.main.async {
                    self.displayJokeInAR(joke: joke)
                }
            case .failure(let error):
                print("Error fetching joke: \(error.localizedDescription)")
            }
        }
    }
}
