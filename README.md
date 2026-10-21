# Full Shopping App — Section 4: State Lifecycle & Navigation

This is a small Flutter app built step by step during **Section 4**. It has two screens, a **Login page** and a **Home page**. We use them to see how a `StatefulWidget` lives and dies, and how to move between screens with both **Navigator** and **go_router**.

The app runs on **go_router** by default. All other examples (Navigator, lifecycle prints, `setState`, `context.push`, path parameters) are written in the code as **commented blocks**, and each block has a short label above it. To try one, uncomment it and comment out the code it replaces.

---

## Learning Objectives

By the end of this section you should be able to:

1. **Explain the StatefulWidget lifecycle.** You should know when each of these runs:
   `createState` → `initState` → `didChangeDependencies` → `build` → `didUpdateWidget` → `setState` → `deactivate` → `dispose`
2. **Navigate with Navigator.** Use `push`, `pop` and `pushNamed`, send data *to* a screen, and get data *back* with `pop`.
3. **Navigate with go_router.** Know the difference between `context.go` and `context.push`, and when to use each.
4. **Explain why we use go_router.** It gives URL-based routing, named routes, and **path / query parameters**.

---

## Project Structure

```
lib/
├── main.dart        # GoRouter config, MyApp, LoginPage (+ commented examples)
└── home_page.dart   # HomePage (+ commented lifecycle and pop examples)
```

| File | What you will find |
|------|--------------------|
| `main.dart` | Router configuration, `MaterialApp.router`, the Login page, Navigator / go_router examples, and a `LifecycleParent` / `LifecycleChild` demo for `didUpdateWidget` |
| `home_page.dart` | The Home page, lifecycle method prints, and ways to go back (`context.go`, `Navigator.pop`, `context.pop`) |

---

## Getting Started

```bash
flutter pub get
flutter run
```

Open the **debug console** while the app runs. The lifecycle examples print messages there, so you can see the order in which the methods run.

---

## 1. StatefulWidget Lifecycle

| Method | When it runs |
|--------|--------------|
| `initState` | Once, when the State object is created. Use it for one-time setup. |
| `didChangeDependencies` | Right after `initState`, and again whenever inherited data the widget depends on changes. |
| `build` | The first time, and again after every `setState`. |
| `didUpdateWidget` | When the **parent** rebuilds this widget with new data. |
| `setState` | You call it to tell Flutter "my data changed, rebuild me". |
| `deactivate` | When the widget is removed from the tree. |
| `dispose` | Once, when the State is destroyed for good. Clean up controllers and listeners here. |

**Try it:**
- Uncomment the lifecycle methods in `LoginPageState` and `HomePageState`, then move between the pages and watch the console.
- Uncomment the **counter** block to see `build` run again after each `setState`.
- Uncomment the `LifecycleParent` / `LifecycleChild` classes at the bottom of `main.dart`, and `LifecycleParent()` inside the login page, to see `didUpdateWidget` in action.

---

## 2. Navigator (Imperative Navigation)

Navigator works like a **stack** of pages:

- `Navigator.push(...)` puts a new page **on top** of the stack.
- `Navigator.pop(context, result)` removes the top page and can **return data** to the page below.
- `Navigator.pushNamed(context, "/home", arguments: ...)` works like `push`, but uses a route name defined in `MaterialApp(routes: {...})`.

```dart
// Send data with the constructor, get the result back with await
final String? result = await Navigator.of(context).push<String>(
  MaterialPageRoute(builder: (context) => HomePage(name: "Atef")),
);

// On the HomePage
Navigator.of(context).pop("Welcome again , Atef");
```

**To switch the app to Navigator:**
1. In `MyApp`, uncomment the `MaterialApp(...)` block and comment out `MaterialApp.router(...)`.
2. In the Login button, uncomment one Navigator block and comment out `context.goNamed(...)`.
3. In `HomePage`, uncomment `Navigator.of(context).pop(...)` and comment out `context.go("/")`.

---

## 3. go_router: `context.go` vs `context.push`

| | `context.go(...)` | `context.push(...)` |
|---|---|---|
| Stack | **Replaces** the stack to match the URL | **Adds** a page on top of the stack |
| Back button | Usually no way back to the previous page | Yes, you can go back |
| Returning data | No | Yes: `await context.push<String>(...)` with `context.pop(value)` |
| Use it for | Moving to a new "place" in the app (e.g. after login) | Opening a temporary page you will come back from (e.g. details) |

```dart
context.go("/home?name=Atef");                                // go
final result = await context.push<String>("/home?name=Atef"); // push
context.pop("Welcome again");                                 // return data
```

---

## 4. Why go_router?

- **URL-based routing:** every screen has a path (`/`, `/home`, `/profile/Atef`), which is essential for **Flutter Web** and deep links.
- **Named routes:** use `context.goNamed("homePage")` so you don't hard-code paths everywhere.
- **Query parameters:** `/home?name=Atef` is read with `state.uri.queryParameters['name']`.
- **Path parameters:** `/profile/:name` is read with `state.pathParameters['name']`.

```dart
context.goNamed("homePage", queryParameters: {"name": "Atef"});
context.goNamed("profile", pathParameters: {"name": "Atef"});
```

---

## Coming Next: Section 5

This section is only an **introduction** to go_router. In **Section 5** we will go deeper and cover:

### go_router in depth
- **Sub-routes (nested routes):** building route trees such as `/home/product/:id`.
- **Redirecting:** using `redirect` to send users to the right page automatically (for example, to the login page when they aren't logged in).
- **How `go` really works compared to `push` and `pop`:** what happens to the navigation stack in each case, and how it relates to the classic Navigator.

### Saving data and forms
- **SharedPreferences:** saving simple data on the device (such as a login flag or a username) so it survives app restarts.
- **Forms, `GlobalKey<FormState>` and validation:** using `Form`, `TextFormField` and `validator` to check user input before submitting.

---

## Notes for Students

- Comment out the code you replace, don't delete it. That makes it easy to switch back.
- Uncomment **one example at a time** so you can clearly see what each one does.
- Keep the debug console open. The prints there are the best way to understand the lifecycle.
