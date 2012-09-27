class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    # Hide status bar inmediatly after of start
    # UIApplication.sharedApplication.setStatusBarHidden(true, animated:false)

    # Setup API end-point
    Maglev::API.setup do
      root 'http://localhost:3000'
    end
    
    # Update GPS coordinates each five seconds
    timer = EM.add_periodic_timer 5.0 do
      BW::Location.get do |result|
        if result[:to]
          App::Persistence['coordinates'] = [result[:to].latitude, result[:to].longitude]
        end
        
        if App::Persistence['coordinates'].nil?
          # failure
        end
      end
      puts App::Persistence['coordinates']
    end

    # Setup main window
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    controller = RootController.alloc.initWithNibName(nil, bundle: nil)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(controller)

    # Add a splash screen on start
    image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed("Default.png"))
    @window.rootViewController.view.addSubview(image_view)
    @window.rootViewController.view.bringSubviewToFront(image_view)
    @window.makeKeyAndVisible

    # Make the splash screen to fade out after of five seconds
    fade_out_timer = 5.0
    UIView.transitionWithView(@window, duration:fade_out_timer, options:UIViewAnimationOptionTransitionNone, animations: lambda { image_view.alpha = 0 }, completion: lambda do |finished|
      image_view.removeFromSuperview
      image_view = nil
      #UIApplication.sharedApplication.setStatusBarHidden(false, animated:false)
    end)
    true
  end
end
