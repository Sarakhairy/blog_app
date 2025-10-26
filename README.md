# Blog App
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/Sarakhairy/blog_app)

A Flutter-based mobile application for creating and sharing blog posts. The project is built using Clean Architecture principles, ensuring a scalable and maintainable codebase. It leverages Supabase for backend services, including user authentication and file storage, and utilizes the BLoC pattern for state management.

## Features

*   **User Authentication**: Secure sign-up and sign-in functionality powered by Supabase Auth.
*   **Session Management**: Keeps users logged in across app restarts.
*   **Create Blog Posts**: A dedicated screen to write new blog posts, including a title and content.
*   **Image Uploads**: Pick an image from the device gallery and upload it to Supabase Storage as a feature image for the blog.
*   **Categorization**: Assign one or more topics (e.g., 'Technology', 'Business') to each blog post.
*   **Clean UI**: A minimalist and dark-themed user interface.

## Architecture & Tech Stack

*   **Architecture**: Clean Architecture (Presentation, Domain, Data layers) with a feature-first approach.
*   **State Management**: `flutter_bloc` for managing application state and `Cubit` for simpler state changes.
*   **Dependency Injection**: `get_it` for service location and managing dependencies.
*   **Backend**: Supabase for Authentication, Database (PostgreSQL), and Storage.
*   **Functional Programming**: `fpdart` for robust error handling using `Either`.
*   **Platform Support**: Built for Android & iOS.

## Project Structure

The project follows a clean and organized feature-first structure:

```
lib/
├── core/               # Shared utilities, theme, error handling, etc.
│   ├── common/         # Shared widgets and cubits (e.g., AppUserCubit).
│   ├── error/          # Custom exceptions and failure classes.
│   ├── secrets/        # Supabase credential constants.
│   ├── theme/          # App color palette and theme data.
│   └── usecase/        # Base use case interface.
├── features/           # Feature-based modules.
│   ├── auth/           # Authentication feature (signup/login).
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── blog/           # Blog feature (create, view).
│       ├── data/
│       ├── domain/
│       └── presentation/
├── init_dependencies.dart # Dependency injection setup with get_it.
└── main.dart           # Application entry point.
```

## Getting Started

Follow these instructions to get the project up and running on your local machine.

### Prerequisites

*   Flutter SDK installed.
*   A Supabase account.

### 1. Clone the Repository

```sh
git clone https://github.com/sarakhairy/blog_app.git
cd blog_app
```

### 2. Set Up Supabase Backend

1.  Go to [supabase.com](https://supabase.com) and create a new project.
2.  Navigate to the **SQL Editor** within your project dashboard.
3.  Run the following SQL script to create the necessary `blogs` table:

    ```sql
    -- Create the blogs table
    CREATE TABLE blogs (
      id UUID PRIMARY KEY,
      poster_id UUID NOT NULL,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      image_url TEXT NOT NULL,
      topics TEXT[] NOT NULL,
      updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
      FOREIGN KEY (poster_id) REFERENCES auth.users(id)
    );
    ```

4.  Set up Row Level Security (RLS) policies to control access to your data. Here are some example policies:

    ```sql
    -- 1. Enable RLS for the blogs table
    ALTER TABLE public.blogs ENABLE ROW LEVEL SECURITY;

    -- 2. Allow authenticated users to insert their own blogs
    CREATE POLICY "Allow authenticated users to insert blogs"
    ON public.blogs
    FOR INSERT TO authenticated
    WITH CHECK (auth.uid() = poster_id);

    -- 3. Allow all users (authenticated or not) to read blogs
    CREATE POLICY "Allow all users to read blogs"
    ON public.blogs
    FOR SELECT USING (true);
    ```

5.  Navigate to the **Storage** section and create a new public bucket named `blog_images`.

### 3. Configure Supabase Credentials

1.  Inside your Supabase project, go to **Project Settings > API**.
2.  Find your **Project URL** and **anon public** key.
3.  Open the file `lib/core/secrets/app_secrets.dart` in your code editor.
4.  Replace the placeholder values with your own Supabase credentials:

    ```dart
    // lib/core/secrets/app_secrets.dart
    class AppSecrets {
      static const supabaseUrl = 'YOUR_SUPABASE_URL';
      static const supabaseAnnonKey = 'YOUR_SUPABASE_ANON_KEY';
    }
    ```

### 4. Install Dependencies

Install the required packages for the project by running:

```sh
flutter pub get
```

### 5. Run the Application

Launch the app on your emulator or physical device:

```sh
flutter run