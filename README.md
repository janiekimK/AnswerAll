# README

# AnswerAll

AnwerAll ist eine Ruby Multi User Web Applikation, die Usern eine Platform gibt, Fragen jeglicher Art zu stellen und Antworten dazu zu geben.

## System Anforderungen

- Ruby 3.x
- Rails 8.0
- SQLite3
- Node.js & Yarn

## Setup Anleitung

1. Repository clonen (oder als .zip downloaden):

```bash
git clone [https://github.com/janiekimK/AnswerAll]
cd AnswerAll
```

2. Dependencies installieren:

```bash
bundle install
yarn install
```

3. Databanbank installieren:

```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Server starten:

```bash
rails server
```

5. Auf http://localhost:3000 gehen

6. Admin:

Um neuen Admin zu setzen im Terminal:

```bash
rails console

User.create!(
  name: "Admin User",
  email: "admin@example.com",
  password: "your_secure_password_here",
  password_confirmation: "your_secure_password_here",
  role: "admin"
)
```

Aktueller Test Admin:

Email: admin@admin
Passwort: adminadmin12

## Hauptfunktionen

- User Authentifikation und Autorisierung
- Fragen und Antworten Management
- Voting von Antworten
- Aktivitätsprotokoll
- Admin Dashboard
- Email Bestätigung
