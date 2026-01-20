<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit News</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h1>Edit Page</h1>

    <div class="mb-3">
        <form action="/news" method="POST">
            @csrf
            @method('PUT')

            <input type="hidden" name="id" value="{{ $news->id }}">

            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">Title</label>
                <input type="text" name="title" class="form-control" id="exampleFormControlInput1" value="{{ $news->title }}">
                
                @error('title')
                    <div class="text-danger">{{ $message }}</div>
                @enderror
            </div>

            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">Body textarea</label>
                <textarea name="body" class="form-control" id="exampleFormControlTextarea1" rows="3">{{ $news->body }}</textarea>
                
                @error('body')
                    <div class="text-danger">{{ $message }}</div>
                @enderror
            </div>

            <button type="submit" class="btn btn-primary">Edit</button>
        </form>
    </div>
</div>

</body>
</html>