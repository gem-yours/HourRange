//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

protocol TimeRecordView: AnyObject {
    var startHour: BehaviorRelay<String?> { get }
    var endHour: BehaviorRelay<String?> { get }
    var hour: BehaviorRelay<String?> { get }
    
    func showToast(message: String)
}

class TimeRecordViewController: UIViewController, TimeRecordView {
    // TODO: RxSwiftでBindingできるようにする
    var startHour = BehaviorRelay<String?>(value: nil)
    var endHour = BehaviorRelay<String?>(value: nil)
    var hour = BehaviorRelay<String?>(value: nil)
    
    @IBOutlet var startHourPicker: HourPicker?
    @IBOutlet var endHourPicker: HourPicker?
    @IBOutlet var hourPicker: HourPicker?
    @IBOutlet var toast: UILabel?
    
    private var isShowingToast = false
    
    var viewModel = TimeRecordViewModel()
    private var disposeBag = DisposeBag()
    
    public func showToast(message: String) {
        guard !isShowingToast else {
            // TODO: 複数個のトースト表示対応
            return
        }
        isShowingToast = true
        toast?.isHidden = false
        toast?.text = message
        UIView.animate(withDuration: 2, delay: 1, options: .curveEaseOut) {
            self.toast?.alpha = 0
        } completion: { _ in
            self.toast?.isHidden = true
            self.toast?.alpha = 1
            self.isShowingToast = false
        }
    }
    
    override func viewDidLoad() {
        viewModel.timeRecordView = self
        startHourPicker?.text.bind(to: startHour).disposed(by: disposeBag)
        endHourPicker?.text.bind(to: endHour).disposed(by: disposeBag)
        hourPicker?.text.bind(to: hour).disposed(by: disposeBag)
        
        setTimeRecord(viewModel.timeRecord.value)
    }
    
    @IBAction func saveTimeRecord() {
        viewModel.save()
    }
}

extension TimeRecordViewController {
    func setTimeRecord(_ timeRecord: TimeRecord) {
        startHourPicker?.setText(String(timeRecord.start.value))
        endHourPicker?.setText(String(timeRecord.end.value))
        hourPicker?.setText(String(timeRecord.hour.value))
    }
}
