# AI Testing Talk — Demo Project Ideas

**Generated:** April 8, 2026
**Context:** Brainstorming a demo project for the "How and Why to Get Started with Automated Testing in the Age of AI" talk. TypeScript + Vitest + GitHub Copilot. Small app (2-3 files), finance domain, starts messy ("legacy"), includes some I/O (API calls).

---

## Recommended: Invoice / Billing Calculator

A small invoicing system that calculates what a customer owes. Relatable, has real edge cases, and naturally supports both pure logic and I/O.

### Why This Works Well for the Talk

| Demo Need | How This Project Delivers |
|---|---|
| **Relatable domain** | Everyone understands invoices, discounts, and taxes |
| **Pure logic to test** | Line item calculations, discount rules, tax computation |
| **I/O to test** | Fetches tax rates from an API, saves invoices to a store |
| **Edge cases AI will miss** | Rounding errors, stacking discounts, zero-quantity lines, negative amounts |
| **"Legacy" starting point** | Easy to write a god-function that does everything in one big blob |
| **Clear refactoring path** | Extract pure calculation functions, separate I/O, add types |
| **Manager-friendly** | "This is the kind of code that calculates what you charge your customers. You want this tested." |

### Module Structure

**File 1: `invoice.ts` — The "legacy" version (starting point)**

One big function that does everything: fetches tax rates, calculates line items, applies discounts, rounds totals, and returns a result. Hard to test because it mixes pure logic with API calls.

```typescript
// The "legacy" version — everything in one function
export async function calculateInvoice(customerId: string, items: any[], discountCode?: string) {
  // Fetches tax rate from API (I/O mixed with logic)
  const response = await fetch(`https://api.tax-service.com/rates/${customerId}`);
  const { taxRate } = await response.json();
  
  // Calculates everything inline — no separation of concerns
  let subtotal = 0;
  for (const item of items) {
    subtotal += item.price * item.qty;
  }
  
  // Discount logic buried in the middle
  let discount = 0;
  if (discountCode === 'SAVE10') discount = 0.10;
  if (discountCode === 'SAVE20') discount = 0.20;
  if (discountCode === 'BOGO' && items.length > 1) {
    // Bug: doesn't handle the cheapest item correctly
    discount = items[0].price * items[0].qty / subtotal;
  }
  
  const afterDiscount = subtotal * (1 - discount);
  const tax = afterDiscount * taxRate;
  const total = afterDiscount + tax;
  
  // Saves to database (more I/O mixed in)
  await fetch('https://api.billing.com/invoices', {
    method: 'POST',
    body: JSON.stringify({ customerId, subtotal, discount, tax, total })
  });
  
  return { subtotal, discount: discount * subtotal, tax, total };
}
```

**Problems AI will exhibit when testing this:**
- Can't test without mocking `fetch` (over-mocking)
- Will hardcode tax rate values that happen to match
- Will miss the BOGO discount bug
- Will test the fetch calls instead of the math
- May not test rounding at all

**File 2: `invoice-calculator.ts` — The refactored version**

Pure calculation functions, separated from I/O:

```typescript
export interface LineItem {
  name: string;
  price: number;
  quantity: number;
}

export function calculateSubtotal(items: LineItem[]): number { ... }
export function applyDiscount(subtotal: number, discountCode?: string, items?: LineItem[]): { discountedTotal: number; discountAmount: number } { ... }
export function calculateTax(amount: number, taxRate: number): number { ... }
export function calculateInvoiceTotal(items: LineItem[], taxRate: number, discountCode?: string): InvoiceResult { ... }
```

**File 3: `invoice-service.ts` — The I/O layer**

Thin wrapper that calls the API and uses the pure functions:

```typescript
export class InvoiceService {
  constructor(private taxApi: TaxApiClient, private invoiceStore: InvoiceStore) {}
  
  async createInvoice(customerId: string, items: LineItem[], discountCode?: string): Promise<InvoiceResult> {
    const taxRate = await this.taxApi.getRate(customerId);
    const result = calculateInvoiceTotal(items, taxRate, discountCode);
    await this.invoiceStore.save(customerId, result);
    return result;
  }
}
```

### Demo Flow

**Demo 1 (after Act 2 — "the bad"):** ~3-4 min
1. Open `invoice.ts` (the legacy version)
2. Ask Copilot: "Write tests for this function"
3. Watch AI struggle: over-mock fetch, miss edge cases, hardcode values
4. Point out specific failures — tie back to the failure modes from slides

**Demo 2 (after Act 3a-3b — "the good"):** ~5-6 min
1. Open `invoice-calculator.ts` (the refactored version)
2. Ask Copilot: "Write tests for calculateSubtotal"
3. AI produces clean AAA tests — because the code is clean
4. Show it generating edge case tests (empty array, single item, many items)
5. Ask for discount tests — show it handling the BOGO logic correctly now
6. Show how descriptive function/param names lead to descriptive test names

**Demo 3 (after Act 3c — "the great"):** ~5-7 min
1. Show a Copilot agent skill or `.github/copilot-instructions.md` with testing standards
2. Use Copilot agent mode: "Generate a complete test suite for the invoice calculator module"
3. Show it following your standards (AAA, one assertion per test, descriptive names)
4. Optionally: show testing the `InvoiceService` with dependency injection (integration-style test)

---

## Alternative Ideas

### Option B: Subscription Billing

A subscription management system that handles plan changes, proration, and billing cycles.

**Modules:**
- `proration.ts` — calculates prorated charges when changing plans mid-cycle
- `billing-cycle.ts` — determines next billing date, handles monthly/annual
- `subscription-service.ts` — manages state, calls payment API

**Pros:** Very relatable for SaaS audience. Proration math is tricky and has great edge cases (leap years, month boundaries, upgrades vs downgrades). Good "this is the code that charges your credit card" weight.

**Cons:** Proration logic can be confusing to explain quickly. Date math adds complexity that isn't about testing.

---

### Option C: Expense Report / Reimbursement

An expense approval system that validates submissions, categorizes expenses, applies policy rules, and calculates reimbursement.

**Modules:**
- `expense-validator.ts` — validates receipts, checks per-diem limits, flags duplicates
- `reimbursement-calculator.ts` — applies mileage rates, meal caps, currency conversion
- `expense-service.ts` — submits to approval API, stores records

**Pros:** Everyone has filed expense reports — instantly relatable. Policy rules create natural edge cases (over-limit meals, international travel, duplicate submissions). Good mix of validation + calculation.

**Cons:** Policy rules might need too much explanation for the audience to follow.

---

### Option D: Loan Payment Calculator

Calculates monthly payments, amortization schedules, and payoff scenarios.

**Modules:**
- `payment-calculator.ts` — monthly payment, total interest, amortization schedule
- `payoff-scenarios.ts` — extra payments, refinancing comparison
- `rate-service.ts` — fetches current rates from API

**Pros:** Clean math, universally understood, edge cases in rounding (penny differences compound over 30 years). Very "this matters if it's wrong" gravitas.

**Cons:** Amortization math might lose some audience members. Less interesting to demo visually.

---

## Recommendation

**Go with Option A (Invoice/Billing Calculator).** It has the best combination of:
- **Instant audience comprehension** — no domain explanation needed
- **Clean narrative arc** — legacy blob → refactored modules → AI-tested
- **Real edge cases** — rounding, stacking discounts, zero quantities
- **Both pure logic and I/O** — shows unit AND integration testing
- **Manager appeal** — "This is the code that bills your customers"
- **Demo pacing** — each demo builds naturally on the previous one

---

## Notes

- The "legacy" version should be intentionally realistic, not cartoonishly bad. It should look like code someone wrote under time pressure — the kind of thing the audience has in their own codebase.
- The refactored version shouldn't be perfect — it should look like a reasonable improvement, not a textbook example. This makes the "AI generates great tests for decent code" message more believable.
- Consider seeding one subtle bug in the refactored version that AI-generated tests actually catch during the demo — a genuine "wow" moment.
