When(/^I click the expander icon$/) do
  @page.navbar_toggle.click
end

When(/^I click navbar brand link$/) do
  @page.navbar_brand.click
  sleep 1 # Wait jQuery animation.
end

When(/^I click navbar link "(.*?)"$/) do |name|
  link = @page.get_navbar_link(name)
  wait_til_clickable(link)
  link.click
  sleep 1 # Wait jQuery animation.
end

Then(/^I should see the correct homepage title$/) do
  assert_equal(SITE_TITLE, @driver.title)
end

Then(/^I should see all external links set to "target='_blank'"$/) do
  external_links = @page.all_external_links
  external_links.each do |link|
    assert_equal('_blank', link.attribute('target'))
  end
end

Then(/^I should (not have|have) clickable top bar links$/) do |target|
  assert_equal(true, is_link_clickable(@page.navbar_brand))
  assert_equal('YI ZENG', @page.navbar_brand.text)

  expected = target == 'have' ? true : false
  assert_equal(expected, is_link_clickable(@page.navbar_about))
  assert_equal(expected, is_link_clickable(@page.navbar_blog))
  assert_equal(expected, is_link_clickable(@page.navbar_contact))
end

Then(/^I should see main section$/) do
  assert_equal('YI ZENG', @page.navbar_brand.text)
  assert_equal('YI ZENG', @page.heading_brand.text)
  @page.header_social_link_buttons.each do |link|
    assert_equal(true, is_link_clickable(link))
  end
end

Then(/^I should see 'about' section$/) do
  assert_equal(true, @page.section_about.displayed?)
end

Then(/^I should see 'blog' section$/) do
  assert_equal(true, @page.section_blog.displayed?)
end

Then(/^I should see 'contact' section$/) do
  assert_equal(true, @page.section_contact.displayed?)
end
