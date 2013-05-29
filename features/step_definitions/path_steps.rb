When(/^I (access|visit) (a|an|the) (.*?) (.*?) page$/) do |verb, article, controller, action|
  visit create_path( controller, action )
end

Then(/^I should be redirected to the homepage$/) do
  current_path.should eql( root_path )
  page.should have_css( '.alert-alert' )
end

Then(/^show me the page$/) do
  save_and_open_page
end

private
def create_path controller, action
  parameter = controller.singularize.parameterize
  case action
    when "home"
      send "root_path"
    when "index"
      send "#{ parameter.pluralize }_path"
  end
end