//

import UIKit

protocol TimeRecordView: AnyObject {
    var startHour: String? { get set }
    var endHour: String? { get set }
    var hour: String? { get set }
}

class TimeRecordViewController: UIViewController, TimeRecordView {
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
    
    // TODO: DIでリポジトリを注入する
    var viewModel = TimeRecordViewModel(timeRecordRepository: InmemoryTimeRecordRepository.shared)
    
    override func viewDidLoad() {
        title = "時刻入力"
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
