---
name: priceCheckCollectibles
agent: agent
description: Price check collectible items across multiple buylist/pricing websites and compile results.
argument-hint: List of items to check and websites to search (e.g., "Pokemon cards: Charizard, Pikachu on PriceCharting, GameNerdz, CoolStuffInc")
tools: [agent, edit, execute, read, search, todo, vscode, playwright/*]
---

# Collectible Price Check Task

Price check the specified collectible items across the given websites and compile the results into a comparison table.

## Prerequisites

**IMPORTANT:** If no items/cards are provided in the user's request, you MUST ask the user to specify which items to search for. Do not proceed without a list of items to check.

**DO NOT** ask the user which websites to search. Always search the three standard sites listed below using the provided links.

## Websites to Search (Always Use These 3 Sites)

1. **PriceCharting search** (https://www.pricecharting.com) - Market price reference
2. **GameNerdz buy list** (https://buylist.gamenerdz.com/retailer/buylist?product_line=Pokemon) - Buylist for store credit/cash
3. **CoolStuffInc sell list** (https://www.coolstuffinc.com/main_selllist.php?s=pokemon) - Buylist for store credit/cash

## Workflow

1. **Create a todo list**: Use `#todo` to create a checklist with one item per card/collectible to track progress
2. **Process one card at a time with subagents**: For each card, use subagents with the #runSubagent tool to search all 3 sites simultaneously in parallel browser windows/tabs
3. **Mark items complete**: Update the todo list as each card is fully researched
4. **Save results**: After all cards are checked, save the compiled results to a markdown file in the workspace

**Parallel Search Strategy:** For each card, spawn 3 subagents with the #runSubagent tool to search PriceCharting, GameNerdz, and CoolStuffInc at the same time. This significantly speeds up the research process. Wait for all subagents to complete before moving to the next card.

## Instructions

1. For each item provided:
    - Search each specified website for the item
    - Extract pricing information (cash payout and store credit if applicable)
    - Note any important details (condition, variant, set name, etc.)

2. Search strategy by site type:
    - **Market price sites** (e.g., PriceCharting): Search with full item details (name, set, number)
    - **Buylist sites** (e.g., GameNerdz): Search with item name and number, wait for results to load
    - **Selllist sites** (e.g., CoolStuffInc): Search with ONLY the item name (no set/number), then locate the correct variant in results

3. Site-specific pricing notes:
    - **GameNerdz**: Displayed prices are STORE CREDIT values (with 25% bonus already included). Calculate cash payout by dividing by 1.25 (e.g., $218.95 credit ÷ 1.25 = $175.16 cash)
    - **CoolStuffInc**: Displays both cash and credit values. Credit includes 25% bonus.
    - **PriceCharting**: Shows market price (not a buylist offer)

4. For each site, note:
    - Whether displayed prices are cash or store credit
    - Any bonus percentages for store credit (e.g., 25% credit bonus)
    - Calculate the alternate value if only one is displayed

5. Provide a table summary comparing the best offers across sites (see below section)

## Results table format

Compile results into a single formatted table for all items. YOU MUST FOLLOW THIS TABLE FORMAT:

| Item Name | Offer Value | PriceCharting (Ungraded) | CoolStuffInc (Cash) | CoolStuffInc (Credit) | GameNerdz (Cash) | GameNerdz (Credit) | Best Alternative |
| --------- | ----------- | ------------------------ | ------------------- | --------------------- | ---------------- | ------------------ | ---------------- |
| Item 1    | $XX.XX      | $XX.XX (+X%)             | $XX.XX (+X%)        | $XX.XX (+X%)          | $XX.XX (+X%)     | $XX.XX (+X%)       | $XX.XX (+X%)     |
| Item 2    | $XX.XX      | $XX.XX (-X%)             | $XX.XX (-X%)        | $XX.XX (-X%)          | $XX.XX (-X%)     | $XX.XX (-X%)       | $XX.XX (-X%)     |

**Example:**

| Item Name            | Offer Value | PriceCharting (Ungraded) | CoolStuffInc (Cash) | CoolStuffInc (Credit) | GameNerdz (Cash) | GameNerdz (Credit) | Best Alternative |
| -------------------- | ----------- | ------------------------ | ------------------- | --------------------- | ---------------- | ------------------ | ---------------- |
| Charizard ex 223/197 | $150.00     | $180.00 (+20%)           | $140.00 (-7%)       | $175.00 (+17%)        | $136.00 (-9%)    | $170.00 (+13%)     | $180.00 (+20%)   |

**Note:** The percentage in parentheses shows the difference from the Offer Value. Positive (+) means the site value is higher than the offer; negative (-) means it's lower.

**Best Alternative column:** Shows the highest percentage difference found and the dollar amount you could potentially lose (or gain) by accepting the offer instead of the best alternative.

## Items to Check

${List the collectible items with identifying details (name, set, number, variant, etc.)}
