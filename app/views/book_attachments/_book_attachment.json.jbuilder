json.extract! book_attachment, :id, :book_id, :photo, :created_at, :updated_at
json.url book_attachment_url(book_attachment, format: :json)