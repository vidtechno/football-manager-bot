# Player Dataset Architecture, Rating Standard, and Versioning Policy

## 1. Dataset Snapshot Date

The current dataset snapshot date is **`2026-08-19`**.
All first-team squads, official club rosters, market values, and attribute ratings represent current active status as of this snapshot.

---

## 2. Squad Inclusion & Exclusion Rules

Each of the 20 Gigants Mode clubs maintains a first-team squad of **18 to 30 players**:

- **Goalkeeper Minimum:** At least 2 active goalkeepers (`GK`) per club.
- **Defender Minimum:** At least 6 defenders (`CB`, `LB`, `RB`, `LWB`, `RWB`) per club.
- **Midfielder Minimum:** At least 6 midfielders (`CDM`, `CM`, `CAM`, `LM`, `RM`) per club.
- **Forward Minimum:** At least 4 forwards (`LW`, `RW`, `CF`, `ST`) per club.
- **Inclusions:** Officially registered first-team players, players loaned _into_ the club.
- **Exclusions:** Players loaned _out_ to another club, players who permanently left before the snapshot date, rumor/uncompleted transfers.
- **No Duplicate Assignments:** Every player canonical key is unique across the entire 20-club league dataset.

---

## 3. Position Mapping & Attribute Separation

Each player has:

- **Primary Position:** Exactly one position code from `enum_player_position` (`GK`, `CB`, `LB`, `RB`, `LWB`, `RWB`, `CDM`, `CM`, `CAM`, `LM`, `RM`, `LW`, `RW`, `CF`, `ST`).
- **Secondary Positions:** Zero or more valid position codes.
- **Goalkeepers (`GK`):** Must specify `reflexes`, `handling`, `positioning`, `aerial_ability`, `distribution`, `one_on_one` (1–99). Outfield attributes MUST be omitted/NULL.
- **Outfield Players (non-`GK`):** Must specify `pace`, `shooting`, `passing`, `dribbling`, `defending`, `physical` (1–99). Goalkeeper attributes MUST be omitted/NULL.

---

## 4. Financial & Market-Value Policies

- **Currency:** Euro (EUR).
- **Exact Numeric Integer:** All market values are exact non-negative integer EUR amounts.
- **Squad Market Value:** The total base squad value for a club is calculated as the exact sum of its 18–25 player market values.
- **Source Provenance:** Every market value specifies its snapshot date and source (`Transfermarkt` / official data).

---

## 5. Dataset Architecture & Reproducibility

- **JSON Data Source:** Stored in `data/football/2026-08-19/` (`clubs.json`, `players.json`, `sources.json`, `validation-report.json`).
- **Typed Validator:** `src/data/validate-dataset.ts` enforces all squad, position, attribute, value, and duplicate constraints.
- **Seed Generator:** `src/data/generate-seed-sql.ts` deterministically compiles `supabase/seed.sql`.
- **Validation Execution:** Vitest test suite (`tests/dataset-validation.test.ts`) verifies dataset integrity during CI (`npm run test`).
