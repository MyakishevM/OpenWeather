import Lottie
import UIKit

class WeatherLottie: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAnimations(filename: String) {
        let animation = Animation.named(filename)
        let animationView = AnimationView(animation: animation)
        animationView.contentMode = .scaleToFill
        animationView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        addSubview(animationView)
        animationView.loopMode = .loop
        animationView.play()
    }
}
