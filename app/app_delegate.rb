class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    # Hide status bar inmediatly after of start
    # UIApplication.sharedApplication.setStatusBarHidden(true, animated:false)
    
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
    end

    # Setup main window
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    controller = RootController.alloc.initWithNibName(nil, bundle: nil)

    # Setup navigation
    navigation_controller = UINavigationController.alloc.initWithRootViewController(controller)
    @window.rootViewController = navigation_controller
    top_bar = UIImage.imageNamed("top_bar.png")
    navigation_bar = UINavigationBar.appearance
    navigation_bar.setBackgroundImage(top_bar, forBarMetrics: UIBarMetricsDefault)
    navigation_bar.setTitleTextAttributes({
      UITextAttributeFont: UIFont.fontWithName("Helvetica-Bold", size: 18),
      UITextAttributeTextShadowColor: UIColor.colorWithWhite(0.0, alpha: 0.4),
      UITextAttributeTextColor: UIColor.whiteColor
    })

    back_button = UIImage.imageNamed("button_back.png", resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12))
    UIBarButtonItem.appearance.setBackButtonBackgroundImage(back_button, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault)
    
    # Add a splash screen on start
    image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed("Default.png"))
    @window.rootViewController.view.addSubview(image_view)
    @window.rootViewController.view.bringSubviewToFront(image_view)
    @window.makeKeyAndVisible

    # Make the splash screen to fade out after of five seconds
    fade_out_timer = 3.0
    UIView.transitionWithView(@window, duration: fade_out_timer, options: UIViewAnimationOptionTransitionNone, animations: lambda { image_view.alpha = 0 }, completion: lambda do |finished|
      image_view.removeFromSuperview
      image_view = nil
      #@window.rootViewController.view.frame = UIScreen.mainScreen.applicationFrame;
      #UIApplication.sharedApplication.setStatusBarHidden(false, animated:false)
    end)
    true
  end
end
