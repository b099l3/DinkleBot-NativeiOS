final class CoordinatorFactoryImp: CoordinatorFactory {
	
	func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?) {
	 let controller = TabbarController.controllerFromStoryboard(.main)
	 let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: CoordinatorFactoryImp())
	 return (coordinator, controller)
 }
    
  func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput {
    let coordinator = AuthCoordinator(router: router, factory: ModuleFactoryImp())
    return coordinator
  }
	
	func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput {
		return OnboardingCoordinator(with: ModuleFactoryImp(), router: router)
	}
	
	func makeSettingsCoordinator() -> Coordinator {
		return makeSettingsCoordinator(navController: nil)
	}
	
	func makeSettingsCoordinator(navController: UINavigationController? = nil) -> Coordinator {
		let coordinator = SettingsCoordinator(router: router(navController), factory: ModuleFactoryImp())
		return coordinator
	}
	
	func makeHomeCoordinator() -> Coordinator {
		return makeHomeCoordinator(navController: nil)
	}
	
	func makeHomeCoordinator(navController: UINavigationController? = nil) -> Coordinator {
		let coordinator = HomeCoordinator(router: router(navController), factory: ModuleFactoryImp())
		return coordinator
	}
  
  private func router(_ navController: UINavigationController?) -> Router {
    return RouterImp(rootController: navigationController(navController))
  }
  
  private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
    if let navController = navController { return navController }
    else { return UINavigationController.controllerFromStoryboard(.main) }
  }
}
