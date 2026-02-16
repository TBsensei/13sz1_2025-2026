@extends('layouts.app')

@section('content')
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Új hír létrehozása</h4>
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

            <form action="{{ route('news.store') }}" method="POST">
                @csrf

                <div class="mb-3">
                    <label for="title" class="form-label">Cím:</label>
                    <input type="text" name="title" class="form-control" id="title" value="{{ old('title') }}" placeholder="Add meg a hír címét...">
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">Tartalom:</label>
                    <textarea name="content" class="form-control" id="content" rows="5"></textarea>                </div>

                <div class="d-flex justify-content-between">
                    <a href="{{ route('news.index') }}" class="btn btn-secondary">Vissza</a>
                    <button type="submit" class="btn btn-success">Mentés</button> </div>
            </form>
        </div>
    </div>
@endsection
