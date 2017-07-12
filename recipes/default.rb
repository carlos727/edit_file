# Cookbook Name:: edit_file
# Recipe:: default
# Edit configuration file
# Copyright (c) 2017 The Authors, All Rights Reserved.

#
# Variables
#
file_path = node["file"]["path"]
search_pattern = node["search"]["pattern"]
replace_with = node["replace"]["text"]
mail_to = node["mail"]["to"]
done, task, edited = false, false, false

#
# Main process
#
ruby_block 'Edit file' do
  block do
    text = File.read(file_path)
    unless text.include? replace_with
      if search_pattern.match text
        File.open("#{file_path}.back#{Time.now.strftime("%Y%m%d")}", 'w') { |file| file.write text }
        new_contents = text.gsub(search_pattern, replace_with[0..(replace_with.length - 2)])
        File.open(file_path, 'w') { |file| file.write new_contents }
        task = true
      end
    else
      done = true
    end
  end
  only_if { File.exist?(file_path) }
end

ruby_block 'Verify task' do
  block do
    if Tools.count_diff(file_path, "#{file_path}.back#{Time.now.strftime("%Y%m%d")}") >= 1
      edited = true
    else
      File.delete file_path
      File.rename "#{file_path}.back#{Time.now.strftime("%Y%m%d")}", file_path
    end
  end
  only_if { task }
end

ruby_block 'Send Email Edit' do
  block do
    if task
      message = "File #{File.basename(file_path)} located in #{File.dirname(file_path)} folder "
      message << 'has been edited.' if edited
      message << 'can not be edited.' unless edited
    else
      message = "File #{File.basename(file_path)} located in #{File.dirname(file_path)} folder doesn't need to be edited."
    end
    Chef::Log.info message
    Tools.simple_email mail_to, :message => message, :subject => "Chef Edit File on Node #{Chef.run_context.node.name}"
  end
  not_if { done }
end
