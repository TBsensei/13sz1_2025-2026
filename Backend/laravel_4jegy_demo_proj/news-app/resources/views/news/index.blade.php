@extends('layouts.app')

@section('content')
    <div class="container mt-4">

        @if(session('success'))
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                {{ session('success') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        @endif

        <div class="row mb-4 align-items-center">
            <div class="col-md-6">
                <h1 class="mb-0">Hírek kezelése</h1>
            </div>

            <div class="col-md-6">
                <div class="d-flex justify-content-md-end align-items-center gap-2">
                    <form action="{{ route('news.index') }}" method="GET" class="d-flex" role="search">
                        <input class="form-control me-2" type="search" name="search"
                               placeholder="Keresés..." aria-label="Search"
                               value="{{ request('search') }}">
                        <button class="btn btn-outline-primary" type="submit">Keresés</button>
                    </form>

                    @auth
                        <a href="{{ route('news.create') }}" class="btn btn-success text-nowrap">
                            + Új hír
                        </a>
                    @endauth
                </div>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-body p-0">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th style="width: 5%">#</th>
                        <th style="width: 25%">Cím</th>
                        <th style="width: 45%">Tartalom (Rövidítve)</th>
                        <th style="width: 25%">Műveletek</th>
                    </tr>
                    </thead>
                    <tbody>
                    @forelse($news as $item)
                        <tr>
                            <td>{{ $item->id }}</td>
                            <td class="fw-bold">{{ $item->title }}</td>
                            <td>{{ Str::limit($item->content, 60) }}</td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="{{ route('news.show', $item->id) }}" class="btn btn-sm btn-info text-white" title="Megtekintés">
                                        👁️
                                    </a>

                                    @auth
                                        <a href="{{ route('news.edit', $item->id) }}" class="btn btn-sm btn-warning" title="Szerkesztés">
                                            ✏️
                                        </a>

                                        <form action="{{ route('news.destroy', $item->id) }}" method="POST" class="d-inline" onsubmit="return confirm('Biztosan törölni szeretnéd ezt a hírt?');">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="btn btn-sm btn-danger" title="Törlés">
                                                🗑️
                                            </button>
                                        </form>
                                    @endauth
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center py-4 text-muted">
                                <em>Nincs megjeleníthető hír az adatbázisban.</em>
                            </td>
                        </tr>
                    @endforelse
                    </tbody>
                </table>
            </div>
        </div>

        <div class="d-flex justify-content-center mt-4">
            {{ $news->appends(['search' => request('search')])->links() }}
        </div>
    </div>
@endsection
