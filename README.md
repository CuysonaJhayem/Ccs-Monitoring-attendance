# CCS College Days 2026 – Track & Field Attendance

Static site (no build step) + Supabase. Sep 29 – Oct 6, 2026 · AM/PM · Men/Women · Running/Jumping/Throwing.

## 1. Supabase setup (once)
1. supabase.com → New project.
2. **SQL Editor** → paste `supabase/schema.sql` → replace `YOUR-EMAIL@example.com` with your email → Run.
3. **Authentication → Users → Add user → Create new user**: same email + a password. Tick "Auto Confirm User".
4. **Authentication → Sign In / Providers**: turn OFF "Allow new users to sign up".
5. **Project Settings → API**: copy the Project URL and the `anon` `public` key into `config.js`.

## 2. Deploy
1. Upload everything to a GitHub repo (keep `vendor/` and `config.js`).
2. Vercel → Add New → Project → import repo → Framework Preset **Other** → Deploy.

## How saving works
- Every tap saves on the phone first, then uploads to Supabase. The chip in the header shows **Saved online**, **Saving…**, or **Offline · N to upload**.
- No signal? Keep marking. It uploads automatically when the internet comes back.
- Marks made before Supabase was connected upload automatically on first sign-in.
- Backup/Restore still works; Restore also replaces the online copy.

## Export
Summary tab → Excel (.xlsx) or Word (.doc).
