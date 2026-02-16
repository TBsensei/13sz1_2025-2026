@extends('layouts.app')

@section('content')
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">Regisztráció</div>
                <div class="card-body">

                    <form action="{{ route('register.submit') }}" method="POST">
                        @csrf

                        <div class="mb-3">
                            <label for="name" class="form-label">Név</label>
                            <input type="text" name="name" class="form-control" value="{{ old('name') }}" required autofocus>
                            @error('name') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">E-mail cím</label>
                            <input type="email" name="email" class="form-control" value="{{ old('email') }}" required>
                            @error('email') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Jelszó (min. 6 karakter)</label>
                            <input type="password" name="password" class="form-control" required>
                            @error('password') <small class="text-danger">{{ $message }}</small> @enderror
                        </div>

                        <div class="mb-3">
                            <label for="password_confirmation" class="form-label">Jelszó újra</label>
                            <input type="password" name="password_confirmation" class="form-control" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Regisztráció</button>
                        </div>
                    </form>

                    <div class="mt-3 text-center">
                        <a href="{{ route('login') }}">Már van fiókod? Jelentkezz be!</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
