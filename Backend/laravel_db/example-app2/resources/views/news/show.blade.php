<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>News Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            News Details
        </div>
        <div class="card-body">
            <h5 class="card-title">{{ $news->title }}</h5>
            
            <p class="card-text">{{ $news->body }}</p>
            
            <hr>

            <div class="d-flex gap-2">
                <a href="/news" class="btn btn-secondary">Back to List</a>

                <a href="/news/{{ $news->id }}/edit" class="btn btn-warning">Edit</a>

                <form action="/news/{{ $news->id }}" method="POST">
                    @csrf
                    @method('DELETE')
                    <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>