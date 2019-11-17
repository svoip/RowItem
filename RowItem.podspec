
Pod::Spec.new do |s|
  s.name             = 'RowItem'
  s.version          = '1.0.0'
  s.summary          = 'A declarative framework for building vertically-stacked views.'
  s.description      = 'A simple abstraction over how to display "stacked views" that are also resizable in orientation changes.'
  s.homepage         = 'https://github.com/svoip/RowItem'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sardorbek Ruzmatov' => 'svoip.mobile@gmail.com' }
  s.source           = { :git => 'https://github.com/svoip/RowItem.git', :tag => s.version.to_s }
  s.source_files = 'Sources/Classes/**/*.swift'
  
end
