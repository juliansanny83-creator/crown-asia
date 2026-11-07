# Crown Asia Projects — Docker hosting (free)

Serves the exported, wired Crown Asia landing page (`index.html`, 62 MB single
file, all 24 assets inlined) with nginx. The page's lead form POSTs to the
Apps Script bridge, which saves leads to the SJ CRM tab:

- Bridge: https://script.google.com/macros/s/AKfycbxpx5nTP7G6UvpiloXWiIrijx_EfdYz_ecPZl5ryFmyZrBzEr6pdoq2AQajER6WMd6Bkw/exec
- Do not remove the bridge URL from the page. No wa.me links in the page.

Original export (do not move it): `workspace/your_files/crown-asia-projects/crown-asia-projects.html`
Served copy in this folder: `index.html` (same file, copied 2026-11-07).

## Run locally

```sh
docker build -t crown-asia-projects .
docker run -d --name crown-asia-projects -p 8080:80 crown-asia-projects
# or
docker compose up -d --build
```

Open http://localhost:8080 — expect HTTP 200 and the title
"Crown Asia Projects — Belterre, Chateau Nissa & Granvida".

## Host it for free — Render (chosen host, 2026-11-07)

Render is the best fit found for a free Docker web service:

- Free compute plan: web services free of charge, 750 free instance hours
  per workspace per month (one service running all month fits), 512 MB RAM.
  Source: Render Docs, "Deploy for Free" — https://render.com/docs/free
- Free web services spin down after 15 minutes without traffic and take
  about a minute to wake on the next request. Not for production, fine for
  leads clicking a link.
- Render's own 2026 article says "No credit card is required" for free web
  services, but Render support/community posts say a card is *sometimes*
  requested for anti-abuse verification (a $1 hold, immediately released).
  So a card may be asked for at signup — that step can only be done by the
  user, in their own Render account.

Other options checked 2026-11-07:
- Fly.io — no free tier for new organisations, only a 2-hour / 7-day trial.
- Koyeb — 1 free web service (512 MB), but since Feb 2026 a credit card
  with a $29 pre-authorisation hold is required at signup.
- Railway — no free tier; $5 one-time trial credit, then $1/month credit.
- Hugging Face Spaces — free CPU Basic hardware, Docker SDK supported, no
  card mentioned; needs a Hugging Face account and the container to listen
  on port 7860 (this Dockerfile listens on 80, so it would need a small
  change). Viable fallback if Render asks for a card.
- Vercel Hobby / Netlify / Cloudflare Pages — free static hosting with no
  card, but they host the HTML directly, not the Docker container. If the
  goal is simply a free public link, hosting `index.html` on Vercel is the
  simplest route; the Docker files here are for the Docker route.

## Deploy on Render (user step — needs a Render account)

1. Push this folder to a GitHub repo (the 62 MB `index.html` is under
   GitHub's 100 MB per-file limit, but push it once, not repeatedly).
   Sign up at https://dashboard.render.com (Google sign-in works).
2. Dashboard → New → Web Service → connect the GitHub repo.
3. Runtime: Docker. Render builds from this `Dockerfile` automatically.
4. Choose the **Free** compute plan. Render injects a `PORT` env var —
   this image listens on port 80, so set the service's port accordingly
   in Render, or change the Dockerfile to listen on `$PORT`.
   NOTE: the current Dockerfile listens on 80; Render's default Docker
   flow expects the container to listen on the injected `$PORT`. Before
   deploying, either set Render's port to 80 or adapt the nginx config
   to use `$PORT` (e.g. `CMD` with envsubst). Test the live URL after
   deploy and fix this if the service does not come up.
5. Deploy. The live URL is `https://<service>.onrender.com` — verify it
   returns HTTP 200 and the Crown Asia hero, then share that link.

## Status 2026-11-07

Docker files are ready. **No live public URL was obtained from this VM, and
the image was NOT built or tested locally:** Docker was not installed, and
`apt-get install docker.io` produced no output for over 6 minutes and was
stopped. No Render/Koyeb/Fly/Hugging Face account is connected here, GitHub
is not logged in (`gh auth status`: not logged in) and Vercel is not
connected. Deployment stops at the Render signup step above, which only the
user can do (Render account + optional card verification). Do not claim a
public URL until it has been fetched live.
