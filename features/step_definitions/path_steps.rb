When(/^I (access|visit) (a|an|the) (.*?) (.*?) page$/) do |verb, article, controller, action|
  #the_path = create_path controller, action
  #visit the_path
  visit create_path( controller, action )
  #visit expediente_path(Expediente.last)
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
      send "#{parameter.pluralize}_path"
  end
end