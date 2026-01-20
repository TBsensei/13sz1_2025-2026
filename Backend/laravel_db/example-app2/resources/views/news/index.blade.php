<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>News List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h1>News List</h1>
    
    <a href="{{ url('/news/create') }}" class="btn btn-primary mb-3">Add New News</a>

    <table class="table table-striped" style="width: 100%;">
        <thead>
            <tr>
                <th>ID</th> <th>Title</th>
                <th>Body</th>
                <th>Actions</th> </tr>
        </thead>
        <tbody>
            @foreach ($news as $item)
                <tr>
                    <td>{{ $loop->iteration }}</td> 
                    
                    <td>{{ $item->title }}</td>
                    <td>{{ Str::limit($item->body, 50) }}</td>
                    
                    <td>
                        <a href="/news/{{ $item->id }}" class="btn btn-info btn-sm">Show</a>
                        <a href="/news/{{ $item->id }}/edit" class="btn btn-warning btn-sm">Edit</a>
                        
                        <form action="/news/{{ $item->id }}" method="POST" style="display:inline;">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Biztosan törlöd?')">Delete</button>
                        </form>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
</div>

</body>
</html>