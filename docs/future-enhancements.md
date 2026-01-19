# Future Enhancements

## Multilingual Firebase Content

**Status:** Proposed  
**Priority:** Medium  
**Related Issue:** TBD (create GitHub issue)

### Problem
The current i18n implementation only translates static UI elements (buttons, navigation, section headers). Dynamic content from Firebase (event titles, descriptions, course names) remains in the original language (Vietnamese).

For English-speaking users, content like "Tập Hát" (Choir Practice) appears untranslated.

---

## Proposed Solutions

### Option A: Hybrid Approach (Recommended)
**Best if event types rarely change** ← This appears to be the case per user feedback.

Store only **event type keys** in Firebase, translate titles in the app:

**Firebase:**
```json
{
  "eventType": "choir_practice",
  "dayOfWeek": "friday",
  "time": "19:00"
}
```

**ARB files:**
```json
// app_en.arb
"event_choir_practice": "Choir Practice",
"event_prayer_meeting": "Prayer Meeting",
"event_youth_group": "Youth Group"

// app_vi.arb  
"event_choir_practice": "Tập Hát",
"event_prayer_meeting": "Nhóm Cầu Nguyện",
"event_youth_group": "Nhóm Thanh Niên"
```

**Pros:** 
- Full i18n support like navigation labels
- No Firebase schema changes needed
- No duplicate content in database

**Cons:**
- Requires app update to add new event types (but they rarely change)

---

### Option B: Dual-Language Firebase Content
**Best if event types change frequently**

Store both English and Vietnamese versions in Firebase:

```json
{
  "title_en": "Choir Practice",
  "title_vi": "Tập Hát"
}
```

**Pros:**
- Admins can add new events without app changes

**Cons:**
- Doubles content in Firebase
- Admin portal needs dual-language forms
- Existing content needs manual translation

---

## Recommendation

Based on user feedback that **event types rarely change** (maybe 1-2 times per year), **Option A (Hybrid)** is recommended. It's simpler and provides full i18n support.

## Discussion Points for Lock

1. Is the current Firebase-driven architecture necessary for this use case?
2. How often are truly new event types added?
3. Would the hybrid approach work for the admin workflow?

