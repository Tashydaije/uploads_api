json.partial! "uploads/upload", upload: @upload
json.extract! @upload, :id, :filename, :created_at, :updated_at