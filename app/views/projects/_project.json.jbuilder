json.extract! project, :id, :title, :description, :github_url, :created_at, :updated_at
json.url project_url(project, format: :json)
