When(/^I (access|visit) the (.*?) (.*?) page$/) do |verb, controller, action|
  the_path = create_path controller, action
  visit the_path
end

Then(/^show me the page$/) do
  save_and_open_page
end

private
def create_path controller, action
  case action
    when "index"
      send "#{controller.singularize.downcase.pluralize}_path"
  end
end