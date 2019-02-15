When /^(?:|the .+ )uploads a image file - "([^"]*)"(?:| within "([^"]*)")$/ do |filename, selector_name|
  file_path = File.join(Rails.root, 'features', 'upload_files', filename)
  attach_file(:product_image, file_path)
end
