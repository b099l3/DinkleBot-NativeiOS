final class HomeCoordinator: BaseCoordinator {
	
	private let factory: HomeModuleFactory
	private let router: Router
	
	init(router: Router, factory: HomeModuleFactory) {
		self.factory = factory
		self.router = router
	}
	
	override func start() {
		showHome()
	}
	
	//MARK: - Run current flow's controllers
	
	private func showHome() {
		let homeFlowOutput = factory.makeHomeOutput()
		router.setRootModule(homeFlowOutput)
	}
}
