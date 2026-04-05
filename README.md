# FeedApp

iOS-приложение с лентой постов и экраном деталей, построенное на `MVVM + Coordinator`.

## Возможности

- Загрузка ленты постов
- Переход на экран деталей поста
- Загрузка комментариев
- Pull-to-refresh
- Кэширование изображений

## Стек

- Swift
- UIKit + SwiftUI (`UIHostingController`)
- Async/Await
- Архитектура: `MVVM + Coordinator`

## Структура проекта

- `FeedApp/Application` — `AppDelegate`, `SceneDelegate`
- `FeedApp/Presentation` — экраны, view models, coordinators
- `FeedApp/Network` — API-клиент и network models
- `FeedApp/Data` — data helpers (например, `ImageLoader`)

## Архитектура

- `Coordinator` отвечает за навигацию (`AppCoordinator`)
- `ViewModel` отвечает за состояние и загрузку данных
- `View` отображает состояние и отправляет user intents
- `ApiClientProtocol` используется для dependency injection

## Запуск

1. Открой `FeedApp.xcodeproj`
2. Выбери схему `FeedApp`
3. Запусти на симуляторе iOS 15+

## Сеть

Используются публичные endpoints:

- `https://jsonplaceholder.typicode.com/users`
- `https://jsonplaceholder.typicode.com/posts`
- `https://jsonplaceholder.typicode.com/comments`

Для изображений:

- `https://picsum.photos`

## Автор

Pavel
