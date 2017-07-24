import Foundation
import UIKit
import DGElasticPullToRefresh

class JourneyVC : UIViewController, PointSelectedProtocol {
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var containerView: UIScrollView!
    private var graph : ScrollableGraphView!
    private var journey : Journey!
    private let cache = NSCache<NSString, Journey>()

    
    override open func loadView() {
        super.loadView()
        graph = ScrollableGraphView(frame: chartView.frame, delegate: self)
        containerView.onPull(self.loadJourneyGraphData)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        loadJourneyGraphData()
    }
    
    func loadJourneyGraphData() {
        if let cachedJourney = self.cache.object(forKey: "broccoliJourney") {
            self.updateView(withJourney: cachedJourney)
            self.containerView.dg_stopLoading()
            print("cachedJourney found")
        }
        else {
            BroccoliAPI().journey(
                onSuccess: {
                    let journey: Journey = Journey(data: $0)
                    self.updateView(withJourney: journey)
                    self.containerView.dg_stopLoading()
                    self.cache.setObject(Journey(data: $0), forKey: "broccoliJourney")
                },
                onUnauthorized: self.performExplainedLogout
            )

        }
    }
    
    func updateView(withJourney journey: Journey) {
        self.journey = journey
        self.noDataView.isHidden = journey.hasStarted()
        chartView.isHidden = journey.isEmpty()
        if journey.hasStarted() {
            graph.set(data: self.journey.levels(), withLabels: self.journey.days())
            self.chartView.subviews.forEach{$0.removeFromSuperview()}
            self.chartView.addSubview(graph)
        }
    }
    
    func pointWasSelectedAt(index:Int, label: String, value: Double, location: CGPoint) {
        AZDialogViewController(day: journey.day(atIndex: index)).show(in: self)
    }
}
