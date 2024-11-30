# How to run the app

- Open the `MovieSearch.xcodeproj` file using Xcode.
- Once in Xcode run the app by either pressing the Run button or hitting `CMD + R` on your keyboard.

# Technical decisions

- Caching of images is done using `NSCache` using a custom component called `CachedAsyncImage`.
- `CachedAsyncImage` uses the `AsyncImage` component provided by SwiftUI.
- The `Movie` data model contains the optional fields `plot` & `imdbRating` so the same model can be reused for the two endpoint calls that the app performs.
- API encapsulation on `OMDBAPI` so it is centralized and the `API Key` is included in each request.
- SwiftUI's `AppStorage` is used for `UserDefaults` data handling.
