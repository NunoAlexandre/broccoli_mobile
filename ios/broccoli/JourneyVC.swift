import Foundation
import UIKit
import DGElasticPullToRefresh


class JourneyVC : UIViewController, PointSelectedProtocol {
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var containerView: UIScrollView!
    private var graph : ScrollableGraphView!
    private var journey : Journey!
    @IBOutlet weak var statsBarView: UIView!
    @IBOutlet weak var avgField: UILabel!
    @IBOutlet weak var medianField: UILabel!
    @IBOutlet weak var bestDayField: UILabel!
    @IBOutlet weak var worstDayField: UILabel!
    
    
    override open func loadView() {
        super.loadView()
        containerView.isHidden = true
        graph = ScrollableGraphView(frame: chartView.frame, delegate: self)
        JourneyCache.map { self.updateView(withJourney: $0) }
        containerView.onPull(self.loadJourneyGraphData)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        loadJourneyGraphData()
    }
    
    func loadJourneyGraphData() {
        BroccoliAPI().journey(
            onSuccess: { fetchedData in
                self.updateView(withJourney: Journey(data: fetchedData))
                JourneyCache.save(fetchedData)
                self.containerView.dg_stopLoading()
            },
            onUnauthorized: self.performExplainedLogout
        )
    }
    
    func updateView(withJourney journey: Journey) {
        self.journey = journey
        self.presentCorrectViews()
        if journey.hasStarted() {
            graph.set(data: self.journey.levels(), withLabels: self.journey.days())
            self.chartView.subviews.forEach{$0.removeFromSuperview()}
            self.chartView.addSubview(graph)
            self.display(journeyStatistics: JourneyStats(journey))
        }
    }
    
    func presentCorrectViews() {
        self.noDataView.isHidden = journey.hasStarted()
        self.chartView.isHidden = journey.isEmpty()
        self.statsBarView.isHidden = journey.isEmpty()
        self.containerView.isHidden = false
    }
    
    func display(journeyStatistics: JourneyStats) {
        self.avgField.text = String(journeyStatistics.average())
        self.medianField.text = String(journeyStatistics.median())
        let (best, worst) = journeyStatistics.bestAndWorstDays()
        self.bestDayField.text = best
        self.worstDayField.text = worst
    }
    
    func pointWasSelectedAt(index:Int, label: String, value: Double, location: CGPoint) {
        AZDialogViewController(day: journey.day(atIndex: index)).show(in: self)
    }
}
