@extends('layouts.app')

@section('content')
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">Bejelentkezés</div>
                <div class="card-body">

                    <form action="{{ route('login.submit') }}" method="POST">
                        @csrf

                        <div class="mb-3">
                            <label for="email" class="form-label">E-mail cím</label>
                            <input type="email" name="email" class="form-control" value="{{ old('email') }}" required autofocus>
                            @error('email') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Jelszó</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-success">Belépés</button>
                        </div>
                    </form>

                    <div class="mt-3 text-center">
                        <a href="{{ route('register') }}">Nincs még fiókod? Regisztrálj!</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
