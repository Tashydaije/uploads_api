json.extract! upload, :id, :filename, :created_at, :updated_at
json.url upload_url(upload, format: :json)