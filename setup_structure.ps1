$features = @("onboarding", "home", "movie_detail")
$layers = @("data/models", "data/datasources", "data/repositories", "domain/entities", "domain/repositories", "domain/usecases", "presentation/blocs", "presentation/views", "presentation/widgets")

foreach ($feature in $features) {
    foreach ($layer in $layers) {
        $path = "lib/features/$feature/$layer"
        New-Item -ItemType Directory -Force -Path $path | Out-Null
    }
}
