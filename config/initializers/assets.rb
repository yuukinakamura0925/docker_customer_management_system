Rails.application.config.assets.version = "1.0"
Rails.application.config.assets.paths << Rails.root.join("node_modules")
# staff.css admin.css customer.cssの3つのcssファイルがプリコンパイルの対象となるように記述
Rails.application.config.assets.precompile += %w( staff.css admin.css customer.css)
