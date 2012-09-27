class RootController < UIViewController
  def viewDidLoad
    super

    @menu_items = { :buildings => 'Nearby Buildings', :search => 'Search a Building',
                    :tour => 'Take a tour', :food => 'Nearby Food Venues',
                    :computers => 'Nearby Computer Rooms' }

    @table = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
    @table.dataSource = @table.delegate = self

    self.view.addSubview @table
    self.title = "Du Nord Map"
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = @menu_items.values[indexPath.row]
    #cell.imageView.image = UIImage.imageNamed:("image.png")
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @menu_items.size
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    self.send("open_#{@menu_items.keys[indexPath.row]}")
  end

  def open_buildings
    new_controller = BuildingsController.alloc.initWithNibName(nil, bundle: nil)
    self.navigationController.pushViewController(new_controller, animated: true)
  end

  def open_search
    alert = UIAlertView.alloc.init
    alert.message = "Unimplemented option"
    alert.addButtonWithTitle "OK"
    alert.show
  end

  def open_tour
    alert = UIAlertView.alloc.init
    alert.message = "Unimplemented option"
    alert.addButtonWithTitle "OK"
    alert.show
  end

  def open_food
    alert = UIAlertView.alloc.init
    alert.message = "Unimplemented option"
    alert.addButtonWithTitle "OK"
    alert.show
  end

  def open_computers
    alert = UIAlertView.alloc.init
    alert.message = "Unimplemented option"
    alert.addButtonWithTitle "OK"
    alert.show
  end
end
