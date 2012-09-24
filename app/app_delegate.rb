class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Maglev::API.setup do
      root 'http://localhost:3000'
    end
    
    
    alert = UIAlertView.new
    BW::Location.get do |result|
      alert.message = "(#{result[:to].latitude},#{result[:to].longitude})"
      alert.show
    end
    true
  end
end
