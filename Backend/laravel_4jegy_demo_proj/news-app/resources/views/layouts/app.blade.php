<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hírek Portál</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand" href="{{ url('/news') }}">Hírek Portál</a>

        <div class="ms-auto">
            <ul class="navbar-nav">
                @guest
                    <li class="nav-item">
                        <a class="nav-link" href="{{ route('login') }}">Belépés</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{{ route('register') }}">Regisztráció</a>
                    </li>
                @endguest

                @auth
                    <li class="nav-item">
                        <span class="nav-link text-light">Szia, {{ Auth::user()->name }}!</span>
                    </li>
                    <li class="nav-item">
                        <form action="{{ route('logout') }}" method="POST" class="d-inline">
                            @csrf
                            <button type="submit" class="btn btn-link nav-link" style="border: none;">Kilépés</button>
                        </form>
                    </li>
                @endauth
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    @yield('content')
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
