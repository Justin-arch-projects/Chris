# Cristomar Floor Board: setup with Supabase + GitHub Pages

See the steps Claude provided. Live site: https://justin-arch-projects.github.io/Chris/

## Supabase (database and shop login)

1. **SQL Editor** → **New query** → paste `setup.sql` → **Run**. You should see "Success."
2. **Authentication** → **Sign In / Providers**: Email on; turn **off** "Allow new users to sign up"; save.
3. **Authentication** → **Users** → **Add user** → **Create new user**: shop email + password, tick **Auto Confirm User**.
4. **Project Settings** → **API**: copy the **Project URL** and the **anon / publishable** key (never the service_role / secret key).

## GitHub

- Edit `config.js` here (pencil icon), paste the URL and key between the quotes, **Commit changes**.
- GitHub Pages is already on: branch **main**, folder **/ (root)**.

## iPhone

Open the link in **Safari**, sign in with the shop login, then **Share** → **Add to Home Screen**.

## Good to know

- The anon/publishable key is designed to be public. The shop login plus the row-level security in `setup.sql` keep the data private.
- The repository is public, so anyone can see the page's code, but not the rug data.
- Supabase's free plan pauses a project after about a week with no activity. If it pauses, click **Restore** in the Supabase dashboard.
