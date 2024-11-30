# How to run the app

- Open the `MovieSearch.xcodeproj` file using Xcode.
- Once in Xcode run the app by either pressing the Run button or hitting `CMD + R` on your keyboard.

# Technical decisions

- Caching of images is done using `NSCache` using a custom component called `CachedAsyncImage`.
- `CachedAsyncImage` uses the `AsyncImage` component provided by SwiftUI.
- The `Movie` data model contains the optional fields `plot` & `imdbRating` so the same model can be reused for the two endpoint calls that the app performs.
- API encapsulation on `OMDBAPI` so it is centralized and the `API Key` is included in each request.
- SwiftUI's `AppStorage` is used for `UserDefaults` data handling.

# Screenshots

## Movies - Search
![Simulator Screenshot - iPhone 16 Pro - 2024-11-30 at 11 15 01](https://github.com/user-attachments/assets/47ad969b-a35e-4b72-93fa-f5a363698f1f)

## Favorites

![Simulator Screenshot - iPhone 16 Pro - 2024-11-30 at 11 15 09](https://github.com/user-attachments/assets/42065f10-ff85-488f-95f6-6852994c69f1)

## Movie Detail

![Simulator Screenshot - iPhone 16 Pro - 2024-11-30 at 11 15 28](https://github.com/user-attachments/assets/9f79ce86-9896-49d0-9f83-faa8b667fecb)

