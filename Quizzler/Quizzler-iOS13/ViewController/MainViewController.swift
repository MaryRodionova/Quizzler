import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private enum Layout {
        static let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
        enum Label {
            static let top: CGFloat = 20
            static let height: CGFloat = 400
        }

        enum Button {
            static let top: CGFloat = 20
            static let height: CGFloat = 80
        }

        enum Image {
            static let top: CGFloat = 50
            static let height: CGFloat = 80
        }
    }

    private var quizBrain = QuizBrain()

    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Score: 0"
        label.textColor = .white
        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(35)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Question Text"
        label.textColor = .white
        return label
    }()
    
    private let changeOneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change 1", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.borderWidth = 4.0
        button.layer.borderColor = UIColor(hex: "#466390").cgColor
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(
            self,
            action: #selector(didTapOneButton),
            for: .touchUpInside
        )
        return button
    }()
    
    private let changeTwoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change 2", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.borderWidth = 4.0
        button.layer.borderColor = UIColor(hex: "#466390").cgColor
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(
            self,
            action: #selector(didTapTwoButton),
            for: .touchUpInside
        )
        return button
    }()
    
    private let changeThreeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change 3", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.borderWidth = 4.0
        button.layer.borderColor = UIColor(hex: "#466390").cgColor
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(
            self,
            action: #selector(didTapThreeButton),
            for: .touchUpInside
        )
        return button
    }()

    private let progressBar: UIProgressView = {
        let viewprogressBar = UIProgressView()
        viewprogressBar.progressTintColor = UIColor(hex: "#FB73A6")
        viewprogressBar.trackTintColor = .white
        viewprogressBar.progress = 0.5
        return viewprogressBar
    }()

    private let imageBackground: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Background-Bubbles")
        image.contentMode = .scaleAspectFill
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#313A5D")
        addSubviews()
        setupConstraints()

        updateQuestion()
    }
    
   
    @objc
    private func didTapOneButton() {
        handleAnswer(for: changeOneButton, answerIndex: 0)
    }

    @objc
    private func didTapTwoButton() {
        handleAnswer(for: changeTwoButton, answerIndex: 1)
    }

    @objc
    private func didTapThreeButton() {
        handleAnswer(for: changeThreeButton, answerIndex: 2)
    }

    private func handleAnswer(for button: UIButton, answerIndex: Int) {
        let userGotItRight = quizBrain.checkAnswer(userAnswer: answerIndex)
        button.backgroundColor = userGotItRight ? .green : .red
        
        quizBrain.nextQuestion()
        scoreLabel.text = "Score: \(quizBrain.getScore())"

        Timer.scheduledTimer(
            timeInterval: 0.2,
            target: self,
            selector: #selector(updateQuestion),
            userInfo: nil,
            repeats: false
        )
    }

    @objc
    private func updateQuestion() {
        label.text = quizBrain.getQuestionText()
        changeOneButton.setTitle(quizBrain.getAnswerText(userButtonNumber: 0), for: .normal)
        changeTwoButton.setTitle(quizBrain.getAnswerText(userButtonNumber: 1), for: .normal)
        changeThreeButton.setTitle(quizBrain.getAnswerText(userButtonNumber: 2), for: .normal)
        progressBar.progress = quizBrain.getProgress()
        changeOneButton.backgroundColor = .clear
        changeTwoButton.backgroundColor = .clear
        changeThreeButton.backgroundColor = .clear
    }
}

// MARK: - Setup Constraints

private extension MainViewController {
    func addSubviews() {
        view.addSubview(scoreLabel)
        view.addSubview(label)
        view.addSubview(changeOneButton)
        view.addSubview(changeTwoButton)
        view.addSubview(changeThreeButton)
        view.addSubview(imageBackground)
        view.addSubview(progressBar)
    }

    func setupConstraints() {
        scoreLabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(Layout.Label.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
        }

        label.snp.makeConstraints { make in
            make
                .top
                .equalTo(scoreLabel.snp.bottom)
                .offset(Layout.Label.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
            make
                .height
                .equalTo(Layout.Label.height)
        }

        changeOneButton.snp.makeConstraints { make in
            make
                .top
                .equalTo(label.snp.bottom)
                .offset(Layout.Button.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
            make
                .height
                .equalTo(Layout.Button.height)
        }

        changeTwoButton.snp.makeConstraints { make in
            make
                .top
                .equalTo(changeOneButton.snp.bottom)
                .offset(Layout.Button.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
            make
                .height
                .equalTo(Layout.Button.height)
        }

        changeThreeButton.snp.makeConstraints { make in
            make
                .top
                .equalTo(changeTwoButton.snp.bottom)
                .offset(Layout.Button.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
            make
                .height
                .equalTo(Layout.Button.height)
        }

        imageBackground.snp.makeConstraints { make in
            make
                .top
                .equalTo(changeTwoButton.snp.bottom)
                .offset(Layout.Image.top)
            make
                .leading.trailing
                .equalToSuperview()
        }

        progressBar.snp.makeConstraints { make in
            make
                .top
                .equalTo(changeThreeButton.snp.bottom)
                .offset(Layout.Button.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
        }
    }
}
