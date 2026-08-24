# Voshify Responsiveness & Layout Rules

## Project Context
This is a **Flutter frontend-only laundry application**.
The UI design is already finalized — **do not redesign, recolor, or change the visual identity**.

---

## Rules That Apply to EVERY Screen Create or Modify

### ✅ Preserve
- Existing Voshify colors, typography, spacing, animations, and component appearance
- Provider, IndexedStack, Navigator, and Theme architecture
- All existing functionality

### ❌ Never Do
- Do not redesign or change any screen's visual style
- Do not rewrite working screens unnecessarily
- Do not fix one screen while breaking another
- Do not use random padding/margin to hide overflow
- Do not use `ClipRect`, `FittedBox`, or `TextOverflow.clip` to hide layout problems
- Do not add unnecessary fixed `width` and `height` values
- Do not add a backend or change project architecture

---

## Layout Requirements (apply to every widget tree)

### Text
- All `Text` inside `Row` must be wrapped in `Expanded` or `Flexible`
- Use `maxLines` + `overflow: TextOverflow.ellipsis` for single-line truncation
- Never let text push a `Row` beyond screen width

### Rows & Columns
- Any `Row` with more than 2 children must be audited for overflow risk
- `Column` inside a scrollable must not have `Expanded` children without an explicit bounded height parent
- Prefer `Wrap` over `Row` for pill/chip groups that may wrap

### Fixed Sizes
- Avoid hardcoded pixel widths for content containers; use `double.infinity`, `Expanded`, or `Flexible`
- For square/circular containers use `AspectRatio` or equal width+height with `ConstrainedBox`

### Lists & Grids
- Every `ListView` / `GridView` inside a `Column` must have `shrinkWrap: true` + bounded height, or use `Expanded`
- Horizontal `ListView` must have an explicit fixed height or be inside a bounded parent

### Bottom Sheets & Dialogs
- Must handle `MediaQuery.of(context).viewInsets.bottom` for keyboard
- Use `SingleChildScrollView` wrapping form content so fields are visible when keyboard opens
- Always use `SafeArea` at the bottom

### Scrollable Screens
- Every screen with more content than fits must be wrapped in `SingleChildScrollView` or `ListView`
- Use `physics: const BouncingScrollPhysics()` for consistency
- Screens with a sticky bottom CTA: body must be scrollable and CTA in `bottomNavigationBar` or `Positioned` at bottom

### Stack & Positioned
- `Positioned` children must not overflow their `Stack` parent
- Use `Positioned.fill` when the child should fill the stack

### Safe Area
- Every screen's body must respect `SafeArea` (or the `AppBar` handles top padding)
- Bottom padding must account for `MediaQuery.of(context).padding.bottom`

### Keyboard
- Wrap form screens in `Scaffold(resizeToAvoidBottomInset: true)` (this is the default — never set it to `false` unless the screen has a map or full-screen canvas)
- Fields near the bottom must scroll into view when keyboard opens

### Screen Sizes
- Test mental model: 320px wide (small), 390px (normal), 430px (large), 600px+ (tablet)
- Do not hardcode widths based on assumed screen width

---

## After Every Change
Run:
```bash
flutter analyze
```
There must be **no errors** and **no layout overflow** introduced by the change.

The final result must look like the **same Voshify application** — just responsive and stable across all devices.
