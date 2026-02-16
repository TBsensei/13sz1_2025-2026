@extends('layouts.app')

@section('content')
    <div class="card shadow-sm mt-4">
        <div class="card-header bg-warning text-dark">
            <h4 class="mb-0">Hír szerkesztése</h4>
        </div>
        <div class="card-body">

            @if ($errors->any())
                <div class="alert alert-danger">
                    <ul>
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form action="{{ route('news.update', $news->id) }}" method="POST">
                @csrf
                @method('PUT') <div class="mb-3">
                    <label for="title" class="form-label">Cím:</label>
                    <input type="text" name="title" class="form-control" id="title" value="{{ old('title', $news->title) }}" required>
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">Tartalom:</label>
                    <textarea name="content" class="form-control" id="content" rows="6" required>{{ old('content', $news->content) }}</textarea>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="{{ route('news.index') }}" class="btn btn-secondary">Mégse</a>
                    <button type="submit" class="btn btn-warning">Frissítés mentése</button>
                </div>
            </form>
        </div>
    </div>
@endsection
