@extends('layouts.app')

@section('content')
    <div class="card shadow-sm mt-4">
        <div class="card-header bg-info text-white d-flex justify-content-between align-items-center">
            <h3 class="mb-0">Hír részletei</h3>
            <a href="{{ route('news.index') }}" class="btn btn-light btn-sm">Vissza a listához</a>
        </div>
        <div class="card-body">
            <h1 class="card-title mb-3">{{ $news->title }}</h1>

            <hr>

            <div class="card-text lead">
                {!! nl2br(e($news->content)) !!}
            </div>

            <hr>
            <div class="text-muted">
                <small>Létrehozva: {{ $news->created_at }}</small>
            </div>
        </div>
        <div class="card-footer">
            <div class="d-flex gap-2">
                <a href="{{ route('news.edit', $news->id) }}" class="btn btn-warning">Szerkesztés</a>

                <form action="{{ route('news.destroy', $news->id) }}" method="POST" onsubmit="return confirm('Biztosan törlöd?')">
                    @csrf
                    @method('DELETE')
                    <button type="submit" class="btn btn-danger">Törlés</button>
                </form>
            </div>
        </div>
    </div>
@endsection
