class BuildingsController < UIViewController
  def viewDidLoad
    super
    @buildings = []
    @table = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
    @table.dataSource = @table.delegate = self
    self.view.addSubview(@table)

    self.title = "Nearby Buildings"

    load_buildings
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = @buildings[indexPath.row].name
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @buildings.size
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    open_building_details(@buildings[indexPath.row])
  end

  def open_building_details(building)
    alert = UIAlertView.alloc.init
    alert.message = "#{building.name} clicked"
    alert.addButtonWithTitle "OK"
    alert.show
  end


  private

  def load_buildings
    # Set an activity indicator while we load data from network
    show_activity_indicator
    Building.find_all do |buildings|
      @buildings.clear
      buildings.each do |building|
        @buildings << building
      end
      show_buildings_list
    end
  end

  def show_buildings_list
    # Reload table data
    @table.reloadData

    # Remove activity indicator
    @activityIndicator.removeFromSuperview
  end

  def show_activity_indicator
    @activityIndicator = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
    @activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0) # TODO: fix for Retina
    @activityIndicator.center = self.view.center
    self.view.addSubview(@activityIndicator)
  end
end