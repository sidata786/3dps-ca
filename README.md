# 3DPS.ca — Canada's 3D Print Marketplace

A full-featured marketplace web app for 3D printed goods, connecting Canadian buyers with local and national makers.

## 🚀 Live Site
**GitHub Pages:** https://sidata786.github.io/3dps-ca

---

## ✅ Features Built

### For Buyers
- 🔍 Browse & search 3D printed items
- 📍 Local seller finder (by city or postal code)
- 🛒 Shopping cart with fee breakdown
- 💬 Direct messaging with sellers
- ❤️ Wishlist
- 🛡️ Buyer protection on every order

### For Sellers / Makers
- 🏪 Seller dashboard with sales stats
- 📋 Listing management
- ⭐ Featured listing promotions
- 💬 Built-in messaging with buyers
- 📊 Revenue tracking

### Monetization (Etsy-style)
| Fee | Amount | When |
|-----|--------|------|
| Listing fee | $0.20/item | When seller publishes a listing |
| Transaction fee | 6.5% | On every completed sale |
| Featured promotion | From $2.99/week | Optional seller upsell |

### Pages / Views
- **Home** — Hero, local trending, categories, how it works, seller CTA
- **Messages** — Real-time chat UI between buyers and sellers
- **Seller Dashboard** — Stats, listings, promotions

---

## 🛠️ Tech Stack
- **React 18** (via CDN — no build step needed)
- **Babel Standalone** (JSX in browser)
- **Google Fonts** — Syne + DM Sans
- **Pure CSS** — No Tailwind, no UI library
- **Static HTML** — Deploys perfectly to GitHub Pages

---

## 📦 Deploy to GitHub Pages

### First time setup:
```bash
git init
git add .
git commit -m "Initial commit — 3DPS.ca marketplace"
git branch -M main
git remote add origin https://github.com/sidata786/3dps-ca.git
git push -u origin main
```

### Enable GitHub Pages:
1. Go to https://github.com/sidata786/3dps-ca/settings/pages
2. Source: **Deploy from a branch**
3. Branch: **main** / **/ (root)**
4. Click **Save**
5. Live in ~2 minutes at: `https://sidata786.github.io/3dps-ca`

### Future updates:
```bash
git add .
git commit -m "Your update description"
git push
```

---

## 🗂️ File Structure
```
3dps-ca/
├── index.html      ← Full React app (single file)
├── 404.html        ← GitHub Pages SPA redirect
└── README.md       ← This file
```

---

## 🗺️ Roadmap (Future)
- [ ] Stripe payment integration
- [ ] Real backend (Supabase or Firebase)
- [ ] User accounts & auth (Firebase Auth)
- [ ] Image uploads for listings
- [ ] Email notifications
- [ ] Admin dashboard
- [ ] Mobile app (React Native)
- [ ] Stripe Connect for seller payouts

---

## 📄 License
© 2025 3DPS.ca Inc. All rights reserved.
