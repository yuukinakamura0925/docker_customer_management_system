table_names = %w(staff_members administrators staff_events )

table_names.each do |table_name|
  #簡潔にファイルパスを取得 path = Rails.root.join("db/seeds/#{Rails.env}/#{table_name}.rb")でも一緒
  path = Rails.root.join("db", "seeds", Rails.env, "#{table_name}.rb")
  if File.exist?(path)
    puts "Creating #{table_name}...."
    require(path)
  end
end
