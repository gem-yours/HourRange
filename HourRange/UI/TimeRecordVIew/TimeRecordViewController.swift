//

import UIKit
import RxSwift

protocol TimeRecordView: AnyObject {
    var startHour: String? { get set }
    var endHour: String? { get set }
    var hour: String? { get set }
    
    func showToast(message: String)
}

class TimeRecordViewController: UIViewController, TimeRecordView {
    // TODO: RxSwiftでBindingできるようにする
    var startHour: String? {
        get { startHourPicker?.text }
        set { startHourPicker?.text = newValue }
    }
    var endHour: String? {
        get { endHourPicker?.text }
        set { endHourPicker?.text = newValue }
    }
    var hour: String? {
        get { hourPicker?.text }
        set { hourPicker?.text = newValue }
    }
    
    @IBOutlet var startHourPicker: HourPicker?
    @IBOutlet var endHourPicker: HourPicker?
    @IBOutlet var hourPicker: HourPicker?
    @IBOutlet var toast: UILabel?
    
    private var isShowingToast = false
    
    // TODO: DIでリポジトリを注入する
    var viewModel = TimeRecordViewModel(timeRecordRepository: DatabaseTimeRecordRepository.shared)
    
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
        setTimeRecord(viewModel.timeRecord)
    }
    
    @IBAction func saveTimeRecord() {
        viewModel.save()
    }
}

extension TimeRecordViewController {
    func setTimeRecord(_ timeRecord: TimeRecord) {
        startHour = String(timeRecord.start.value)
        endHour = String(timeRecord.end.value)
        hour = String(timeRecord.hour.value)
    }
}
