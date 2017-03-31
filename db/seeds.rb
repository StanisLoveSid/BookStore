require 'ffaker'
require 'carrierwave'

Author.destroy_all
Book.destroy_all
BookAttachment.destroy_all



images = [ 'https://dl.dropboxusercontent.com/1/view/3n32srbbowmwwgq/uploads/V05929_MockupCover.jpg',
           'https://dl.dropboxusercontent.com/1/view/m1bcsb3m0m3zw5t/uploads/190481140X.jpg',
           'https://dl.dropboxusercontent.com/1/view/l0ye9exg2zo20u4/uploads/6528OS.jpg',
           'https://dl.dropboxusercontent.com/1/view/ltemnv9m017nlo7/uploads/principles-of-beautiful-web-design.jpg',
           'https://dl.dropboxusercontent.com/1/view/23vp6yj7xq2xq3n/uploads/learning-web-design-a-beginners-guide.png',
           'https://dl.dropboxusercontent.com/1/view/xb26w0dinoncelx/uploads/d9e0ef5f476610f8fd86c9ef930d2ef3.jpg',
           'https://dl.dropboxusercontent.com/1/view/qvb2yleo7znc4oc/uploads/C06035.jpg' ]

Category.find_each do |category|
  rand(4..7).times do |n|
    Book.create!(title: "#{FFaker::Book.title} #{n}",
                 description: FFaker::Book.description.to_s[0..2000],
                 price: rand(9.99..65.99),
                 year_of_publication: rand(2005..2015),
                 materials: FFaker::Lorem.sentence,
                 demensions: rand(3.1..4.5),
                 category: category)
    BookAttachment.create! photo: images[rand(0..6)]
  end
end

Book.find_each do |book|
  book.book_attachments.create! photo: (BookAttachment.find(rand(BookAttachment.first.id..BookAttachment.last.id))).photo
  book.authors.create! name: FFaker::Name.name, bio: FFaker::Lorem::paragraph(5)
end
