
import UIKit

class ViewController: UIViewController {
    //MARK: - Properties
    var timerBackViewLabel = UILabel()
    var hourMinSectLabel = UILabel()
    var fractionsLabel = UILabel()
    var timerValueStoreTextView = UITextView()
    var startStopButton = UIButton()
    var clearAllButton = UIButton()
    var timer = Timer()
    var isStarted = false
    var rowNumber = 0
    var (hours, minutes, seconds, fractions) = (0,0,0,0)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createTimerBackViewLabel()
        self.createhourMinSecFractionsLabel()
        self.createTimerValueTextView()
        self.createStartStopButton()
        self.createCrearAllButton()
    }
    //MARK: - Actions
    //timer start action when start button pressed. Calls timer hour, min, sec regulate action
    @objc func startButtonPressed(target: UIButton) {
        if target.isEqual(startStopButton) {
            
            if !isStarted {
                
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.timerKeeper(target:)), userInfo: nil, repeats: true)
                //changing startButton.text to Stop
                startStopButton.setTitle("Stop", for: .normal)
                isStarted = true
                
            } else if isStarted {
                
                timer.invalidate()
                //returning startButton.text to Start
                startStopButton.setTitle("Start", for: .normal)
                //add timer text/value to timerValueStoreTextView
                rowNumber += 1
                self.addTimerValueToList()
                isStarted = false
            }
            
        }
    }
    //stops the timer
    @objc func clearAllButtonPressed(target: UIButton) {
        if target.isEqual(clearAllButton) {
            //reseting all
            timer.invalidate()
            (hours, minutes, seconds, fractions) = (0,0,0,0)
            hourMinSectLabel.text = "0\(hours):0\(minutes):0\(seconds)"
            fractionsLabel.text = ".0\(fractions)"
            startStopButton.setTitle("Start", for: .normal)
            timerValueStoreTextView.text = ""
            rowNumber = 0
            isStarted = false
        }
    }
    //timer hour, min, sec regulate action
    @objc func timerKeeper(target: Timer) {
        
        fractions += 1
        if fractions > 99 {
            seconds += 1
            fractions = 0
        }
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        if minutes == 60 {
            hours += 1
            minutes = 0
        }
        //changing hour minute second and fraction to new value
        let secondsNew = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesNew = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let hoursNew = hours > 9 ? "\(hours)" : "0\(hours)"
        
        hourMinSectLabel.text = "\(hoursNew):\(minutesNew):\(secondsNew)"
        fractionsLabel.text = ".\(fractions)"
    }
    //MARK: - Methods
    //create main time Label
    func createTimerBackViewLabel() {
        //design, location, setting
        timerBackViewLabel.frame = CGRect(x: 0, y: 0, width: 350, height: 250)
        timerBackViewLabel.center = self.view.center
        timerBackViewLabel.frame.origin.y = 100
        timerBackViewLabel.layer.borderColor = UIColor.lightGray.cgColor
        timerBackViewLabel.layer.borderWidth = 0.5
        //text setting
        timerBackViewLabel.text = "Stopwatch"
        timerBackViewLabel.textAlignment = .center
        timerBackViewLabel.textColor = .darkGray
        timerBackViewLabel.font = UIFont.init(name: "Courier", size: 20)
        view.addSubview(timerBackViewLabel)
    }
    //create hours minutes second and fractions label
    func createhourMinSecFractionsLabel() {
        //design, location, setting
        hourMinSectLabel.frame = CGRect(x: 0, y: 0, width: timerBackViewLabel.bounds.width / 2, height: 50)
        hourMinSectLabel.center = timerBackViewLabel.center
        hourMinSectLabel.frame.origin.x = 40
        //text settings
        hourMinSectLabel.text = "0\(hours):0\(minutes):0\(seconds)"
        hourMinSectLabel.textAlignment = .right
        hourMinSectLabel.textColor = .darkGray
        hourMinSectLabel.font = UIFont.init(name: "Courier", size: 35)
        timerBackViewLabel.addSubview(hourMinSectLabel)
        
        fractionsLabel.frame = CGRect(x: 0, y: 0, width: timerBackViewLabel.bounds.width / 4, height: 50)
        fractionsLabel.center = timerBackViewLabel.center
        fractionsLabel.frame.origin.x = timerBackViewLabel.bounds.width / 2 + 42
        //text settings
        fractionsLabel.text = ".0\(fractions)"
        fractionsLabel.textAlignment = .left
        fractionsLabel.textColor = .darkGray
        fractionsLabel.font = UIFont.init(name: "Courier", size: 35)
        timerBackViewLabel.addSubview(fractionsLabel)
    }
    //create a text view, where I am gonna store the time value when click the stop button
    func createTimerValueTextView() {
        //main design, location, coordinates
        timerValueStoreTextView.frame = CGRect(x: 0, y: 0, width: 350, height: 300)
        timerValueStoreTextView.center = self.view.center
        timerValueStoreTextView.frame.origin.y = 400
        timerValueStoreTextView.layer.borderWidth = 0.5
        timerValueStoreTextView.layer.borderColor = UIColor.lightGray.cgColor
        //main text and text settings
        timerValueStoreTextView.textAlignment = .justified
        timerValueStoreTextView.textColor = .darkGray
        timerValueStoreTextView.font = UIFont.systemFont(ofSize: 25)
        timerValueStoreTextView.text = ""
        timerValueStoreTextView.isScrollEnabled = true
        timerValueStoreTextView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 40)
        view.addSubview(timerValueStoreTextView)
        
    }
    //create a start and stop button
    func createStartStopButton() {
        //main design, coordinates
        startStopButton = UIButton(type: .system)
        startStopButton.frame = CGRect(x: 30, y: 750, width: 165, height: 40)
        startStopButton.layer.borderColor = UIColor.systemBlue.cgColor
        startStopButton.layer.borderWidth = 1
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        startStopButton.addTarget(self, action: #selector(self.startButtonPressed(target:)), for: .touchUpInside)
        view.addSubview(startStopButton)
    }
    //create clear all/reset to zero button
    func createCrearAllButton() {
        //main design, coordinates
        clearAllButton = UIButton(type: .system)
        clearAllButton.frame = CGRect(x: 215, y: 750, width: 165, height: 40)
        clearAllButton.layer.borderColor = UIColor.systemRed.cgColor
        clearAllButton.layer.borderWidth = 1
        clearAllButton.setTitle("Clear all", for: .normal)
        clearAllButton.setTitleColor(.systemRed, for: .normal)
        clearAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        clearAllButton.addTarget(self, action: #selector(self.clearAllButtonPressed(target:)), for: .touchUpInside)
        view.addSubview(clearAllButton)
    }
    //add got timer value/text to timerValueStoreTextView
    func addTimerValueToList() {
        
        timerValueStoreTextView.text += "\(rowNumber). \(hourMinSectLabel.text ?? "nil in hourMinSectLabel.text")\(fractionsLabel.text ?? "nil in fractionsLabel.text")" + "\n"
    }
}

