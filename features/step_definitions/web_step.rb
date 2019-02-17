require 'uri'
require 'cgi'

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end

World WithinHelpers

When /^(?:|the .+ )goes to page - "([^"]*)"$/ do |expect_path|
  visit expect_path
  sleep 1
end

When /^(?:|the .+ )presses "([^"]*)"(?: within "([^"]*)")?$/ do |button, selector_name|
  wait_for_ajax
  with_scope(to_selector(selector_name)) do
    click_button(button)
  end
end

When /^(?:|the .+ )clicks "([^"]*)"(?: within "([^"]*)")?$/ do |link, selector_name|
  wait_for_ajax
  with_scope(to_selector(selector_name)) do
    click_link(link, exact: false)
  end
end

When /^(?:|the .+ )clicks "([^"]*)" link(?: within "([^"]*)")? and open a new tab$/ do |link, selector_name|
  wait_for_ajax
  with_scope(to_selector(selector_name)) do
    @new_window = window_opened_by { click_link(link, exact: false) }
  end
end

When /^(?:|the .+ )clicks "([^"]*)" link(?: within "([^"]*)")?$/ do |link, selector_name|
  wait_for_ajax
  with_scope(to_selector(selector_name)) do
    if @link
      @link.click
      @link = nil
    else
      links = page.all('a', text: link, minimum: 1)
      if links.size > 1
        links.each { |x| x.click if x[:href] != '#' && x.text == link }
      else
        click_link(link)
      end
    end
  end
end

When /^(?:|the .+ )clicks "([^"]*)" tab(?: within "([^"]*)")?$/ do |link, selector_name|
  wait_for_ajax
  with_scope('.tabs_sub') do
    click_link(link)
  end
end

When /^(?:|the .+ )clicks "([^"]*)" icon(?: from row "([^"]*)")?$/ do |link, index|
  wait_for_ajax
  link = link.underscore
  if index.present?
    index = index.to_i - 1
    icons = all(".fa-#{link}")
    icons[index].click
  else
    find(".fa-#{link}").click
  end
end

When /^(?:|the .+ )clicks product picture?$/ do
  wait_for_ajax
  find(".thumbnail").click
end


When /^(?:|the .+ )fills in "([^"]*)" with "([^"]*)"(?: within "([^"]*)")?$/ do |field, value, selector_name|
  with_scope(to_selector(selector_name)) do
    fill_in(field_id(field), with: value, match: :prefer_exact)
  end
end

When(/^(?:|the .+ )fills in rules with$/) do |value|
  page.evaluate_script("editor.set(#{value})")
  find(".jsoneditor-repair").click
end

When(/^(?:|the .+ )should see rules with$/) do |value|
  expect(page.evaluate_script('editor.get()').to_json).to eq(value)
end

When /^(?:|the .+ )fills in "([^"]*)" with date "([^"]*)"(?: within "([^"]*)")?$/ do |field, value, selector_name|
  with_scope(to_selector(selector_name)) do
    field_id = field_id(field)
    find("input[id*=#{field_id}]").set(value)
    if Capybara.current_driver.to_s =~ /selenium/
      page.evaluate_script("$('input[id*=#{field_id}]').datepicker('hide');")
      sleep(0.5)
    end
  end
end

# Assign the invalid value to item of field text
When /^(?:|the .+ )fills the invalid "(.*?)" - "(.*?)"$/ do |field, value|
  fill_in field_id(field), with: value
end

When /^(?:|the .+ )fills in "([^"]*)" for "([^"]*)"(?: within "([^"]*)")?$/ do |value, field, selector_name|
  with_scope(to_selector(selector_name)) do
    fill_in(field, with: value)
  end
end

# Use this to fill in an entire form with data from a table. Example:

#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |

# TODO: Add support for checkbox, select og option
# based on naming conventions.

When /^(?:|the .+ )fills in the following(?: within "([^"]*)")?:$/ do |selector, fields|
  with_scope(to_selector(selector_name)) do
    fields.rows_hash.each do |field, value|
      with_scope(to_selector(selector_name)) do
        fill_in(field, with: value)
      end
    end
  end
end

When /^(?:|the .+ )selects "([^"]*)" from "([^"]*)"(?: within "([^"]*)")?$/ do |value, field, selector_name|
  with_scope(to_selector(selector_name)) do
    select(value, from: field_id(field))
  end
  wait_for_ajax
end

When /^(?:|the .+ )checks "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector_name|
  wait_for_ajax
  with_scope(to_selector(selector_name)) do
    check(field_id(field), visible: false)
  end
end

When /^(?:|the .+ )unchecks "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector_name|
  with_scope(to_selector(selector_name)) do
    uncheck(field_id(field), visible: false)
  end
end

When /^(?:|the .+ )chooses "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector_name|
  with_scope(to_selector(selector_name)) do
    choose(field)
  end
end

When /^(?:|the .+ )attaches the file "([^"]*)" to "([^"]*)"(?: within "([^"]*)")?$/ do |path, field, selector_name|
  with_scope(to_selector(selector_name)) do
    attach_file(field, File.join(Rails.root, 'features', 'files', path))
  end
end

Then /^(?:|the .+ )should see JSON:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual   = JSON.pretty_generate(JSON.parse(response.body))
  expect(expected).to eql actual
end

Then /^(?:|the .+ )should see "([^"]*)"(?: within "([^"]*)")?$/ do |text, selector_name|
  with_scope(to_selector(selector_name)) do
    expect(page).to have_content(text)
  end
end

Then /^(?:|the .+ )should see "([^"]*)"(?: within "([^"]*)")? at the new tab$/ do |text, selector_name|
  within_window @new_window do
    with_scope(to_selector(selector_name)) do
      expect(page).to have_content(text)
    end
  end
end

Then /^(?:|the .+ )should see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector_name|
  regexp = Regexp.new(regexp)
  with_scope(to_selector(selector_name)) do
    if self.respond_to? :expect
      expect(page).to have_xpath('//*', text: regexp)
    else
      assert page.has_xpath?('//*', text: regexp)
    end
  end
end

Then /^(?:|the .+ )should not see "([^"]*)"(?: within "([^"]*)")?$/ do |text, selector_name|
  with_scope(to_selector(selector_name)) do
    if self.respond_to? :expect
      expect(page).to have_no_content(text)
    else
      assert page.has_no_content?(text)
    end
  end
end

Then /^(?:|the .+ )should not see "([^"]*)"(?: within "([^"]*)")? at the new tab$/ do |text, selector_name|
  within_window @new_window do
    with_scope(to_selector(selector_name)) do
      expect(page).to have_no_content(text)
    end
  end
end

Then /^(?:|the .+ )should not see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector_name|
  regexp = Regexp.new(regexp)
  with_scope(to_selector(selector_name)) do
    if self.respond_to? :expect
      expect(page).to have_no_xpath('//*', text: regexp)
    else
      assert page.has_no_xpath?('//*', text: regexp)
    end
  end
end

Then /^the "([^"]*)" field(?: within "([^"]*)")? should contain "([^"]*)"$/ do |field, selector, value|
  with_scope(to_selector(selector_name)) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if self.respond_to? :expect
      expect(field_value).to match /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field(?: within "([^"]*)")? should not contain "([^"]*)"$/ do |field, selector, value|
  with_scope(to_selector(selector_name)) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if self.respond_to? :expect
      expect(field_value).to_not match /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within "([^"]*)")? should be checked$/ do |label, selector_name|
  with_scope(to_selector(selector_name)) do
    field_checked = find_field(label)['checked']
    if self.respond_to? :expect
      expect(field_checked).to be true
    else
      assert field_checked
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within "([^"]*)")? should not be checked$/ do |label, selector_name|
  with_scope(to_selector(selector_name)) do
    field_checked = find_field(label)['checked']
    if self.respond_to? :expect
      expect(field_checked).to be false
    else
      assert !field_checked
    end
  end
end

When /^(?:|the .+ )check Make as Entry Ruleset checkbox$/ do
  check 'rms_draft_ruleset_is_entry'
end

Then /^(?:|the .+ )should be at page - "(.*?)"$/ do |expect_path|
  wait_for_ajax
  sleep 2
  current_path  = URI.parse(current_url).path
  current_query = URI.parse(current_url).query

  if current_query.blank?
    expect(current_path).to eql expect_path
  else
    current_query = URI.unescape(current_query)
    expect("#{current_path}?#{current_query}").to eq expect_path
  end
end

Then /^(?:|the .+ )should be at external page - "(.*?)"$/ do |expect_url|
  expect(current_url).to eq expect_url
end

Then /^(?:|the .+ )should see a new browser window at page - "(.*?)"$/ do |expect_path|
  page.within_window windows.last do
    current_path  = URI.parse(current_url).path
    current_query = URI.parse(current_url).query
    if current_query.blank?
      expect(current_path).to eql expect_path
    else
      current_query = URI.unescape(current_query)
      expect("#{current_path}?#{current_query}").to eq expect_path
    end
  end
end

Then /^(?:|the .+ )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair { |k,v| expected_params[k] = v.split(',') }

  if self.respond_to? :expect
    expect(actual_params).to eql expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^(?:|the .+ )should see a message - "([^"]*)"?$/ do |text|
  expect(page).to have_content(text)
end

Then /^(?:|the .+ )should see a success message - "([^"]*)"?$/ do |text|
  expect(page).to have_content(text)
end

Then /^(?:|the .+ )should see an error message(?:| for "[^"]*" field) - "([^"]*)"?$/ do |text|
  expect(page).to have_content(text)
end

Then /^(?:|the .+ )should see an alert message - "([^"]*)"?$/ do |text|
  expect(page.driver.accept_modal(:alert)).to have_content(text)
end

When /^(?:|the .+ )accepts a confirm message - "([^"]*)"?$/ do |text|
  expect(page.driver.accept_modal(:confirm)).to have_content(text)
end

Then /^(?:|the .+ )should see a notification \- "(.*?)"$/ do |text|
  wait_for_ajax
  expect(page).to have_content(text)
end

Then /^(?:|the .+ )should not see a notification \- "(.*?)"$/ do |text|
  wait_for_ajax
  expect(page).to have_no_content(text)
end

And /^(?:|the .+ )close the notification$/ do
  find('.ui-dialog-titlebar-close').click
end

Then /^(?:|the .+ )should see a button - "([^"]*)"?$/ do |text|
  expect(has_css?("input[value='#{text}'][type=submit],input[value='#{text}'][type=button]")).to be_truthy
end

Then /^(?:|the .+ )should not see a button - "([^"]*)"?$/ do |text|
  expect(has_no_css?("input[value='#{text}'][type=submit],input[value='#{text}'][type=button]")).to be_truthy
end

Then /^(?:|the .+ )should see a disabled button - "([^"]*)"?$/ do |text|
  expect(find_button("#{text}")[:class].include?("disabled")).to be_truthy
end

Then /^(?:|the .+ )should see a disabled link - "([^"]*)"?$/ do |text|
  expect(find_link("#{text}")[:disabled]).to be_truthy
end

Then /^(?:|the .+ )should see a enabled link - "([^"]*)"?$/ do |text|
  expect(find_link("#{text}")[:disabled]).to be_falsey
end

Then /^(?:|the .+ )should not see a link - "([^"]*)"?$/ do |text|
  expect(has_no_link?("#{text}")).to be_truthy
end

Then /^(?:|the .+ )should see a checkbox - "([^"]*)"?$/ do |text|
  expect(has_css?("input[id*='#{text}'][type=checkbox]")).to be_truthy
end

Then /^(?:|the .+ )should not see a checkbox - "([^"]*)"?$/ do |text|
  expect(has_no_css?("input[id*='#{text}'][type=checkbox]")).to be_truthy
end

Then /^(?:|the .+ )should see a disabled checkbox - "([^"]*)"?$/ do |text|
  expect(page).to have_css("input[id*='#{text}'][type=checkbox][value='1']:disabled")
end

Then /^(?:|the .+ )should see a radio - "([^"]*)"?$/ do |text|
  text = text.parameterize.underscore
  expect(has_css?("input[id*='#{text}'][type=radio]")).to be_truthy
end

Then /^(?:|the .+ )should not see a radio - "([^"]*)"?$/ do |text|
  text = text.parameterize.underscore
  expect(has_no_css?("input[id*='#{text}'][type=radio]")).to be_truthy
end

When /^(?:|the .+ )choose "([^"]*)" option with "([^"]*)"?$/ do |option, field|
  field = field.parameterize.underscore
  find("input[id*=#{field}][value='#{option}']").click
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^(?:|the .+ )presses "(.*?)" button to add the email to "(.*?)"$/ do |button, section|
  button_id = "#add_#{section.downcase.gsub(' ','_')}_email"
  find(button_id).click
end

Then /^(?:|the .+ )should see "(.*?)" select for "(.*?)"$/ do |select_label, text|
  expect(page).to have_content(select_label)
  expect(page).to have_content(text)
end

Then /^there are no matching records found$/ do
  expect(page).to have_content('No matching records found')
end

When /^(?:|the .+ )wait for page reloaded$/ do
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop do
      break if !page.text.include?('Loading...')
      sleep(0.1)
    end
  end
  sleep 2
end

When /^(?:|the .+ )reload the page$/ do
  case Capybara.current_driver.to_s
  when /selenium/
    visit page.driver.browser.current_url
  when 'racktest'
    visit [ current_path, page.driver.last_request.env['QUERY_STRING'] ].reject(&:blank?).join('?')
  else
    raise "unsupported driver, use rack::test or selenium/webdriver"
  end
end

When /^(?:|the .+ )go back to the last page$/ do
  page.evaluate_script('window.history.back()')
end

Given /^(?:|the .+ )reopen browser$/ do
  Capybara.reset!
end
