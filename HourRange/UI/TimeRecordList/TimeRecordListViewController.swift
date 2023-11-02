//

import UIKit
import RxSwift

class TimeRecordListViewController: UITableViewController {
    let viewModel = TimeRecordListViewModel()
    var timeRecords = [TimeRecord]()
    
    private var disposeBag = DisposeBag()
    
    @IBAction func createNew() {
        performSegue(withIdentifier: "timeRecordViewController", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TimeRecordRow", bundle: nil), forCellReuseIdentifier: "timeRecordRow")
        tableView.estimatedRowHeight = 128
        tableView.rowHeight = UITableView.automaticDimension
        viewModel.timeRecordsEvent.subscribe { timeRecords in
            self.timeRecords = timeRecords
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        viewModel.error.subscribe { value in
            // TODO: エラーの表示
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "timeRecordViewController":
            guard let timeRecordViewController = segue.destination as? TimeRecordViewController else {
                return
            }
            if let index = sender as? Int {
                timeRecordViewController.viewModel = TimeRecordViewModel(
                    timeRecord: timeRecords[index]
                )
            }
        default:
            break
        }
    }
}

// MARK: UItableViewDelegate/DataSource
extension TimeRecordListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timeRecords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let timeRecordRow = tableView.dequeueReusableCell(withIdentifier: "timeRecordRow", for: indexPath) as? TimeRecordRow else {
            return UITableViewCell()
        }
        timeRecordRow.timeRecord = timeRecords[indexPath.row]
        
        return timeRecordRow
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "timeRecordViewController", sender: indexPath.row)
    }
}

