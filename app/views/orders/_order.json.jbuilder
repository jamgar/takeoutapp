json.extract! order, :id, :customer, :confirmation, :total, :fullfilled, :created_at, :updated_at
json.url order_url(order, format: :json)
