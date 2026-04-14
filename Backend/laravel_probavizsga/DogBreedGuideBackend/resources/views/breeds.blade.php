<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kutya fajták</title>
</head>
<body>
<h1>Kutya fajták</h1>
<ul>
    @foreach($groups as $group)
        <li>
            <strong>{{ $group->name }}</strong>
            @if($group->types->count() > 0)
                <ul>
                    @foreach($group->types as $type)
                        <li>
                            {{ $type->name }} [sebesség = {{ $type->speed }}, élettartam = {{ $type->lifetime }}]
                        </li>
                    @endforeach
                </ul>
            @endif
        </li>
    @endforeach
</ul>
</body>
</html>
