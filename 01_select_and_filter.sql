-- Lesson 01: SELECT, WHERE, AND, OR and inclusive boundaries
-- Synthetic learning data; amounts use one common arbitrary currency.
-- Practice by Vladimir Trifonov. Setup and comments prepared with AI assistance.
-- Orders queries were solved independently; transaction queries below include
-- corrections discussed during review.
-- Run once in a fresh SQLite database, from top to bottom.
-- CREATE TABLE and INSERT prepare the examples; these topics will be studied later.

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    city TEXT,
    amount INTEGER
);

INSERT INTO orders (order_id, city, amount) VALUES
    (1, 'Prague', 1200),
    (2, 'Tashkent', 800),
    (3, 'Prague', 2500),
    (4, 'Brno', 1700);

-- A: All orders from Prague. Expected order IDs: {1, 3}.
SELECT * FROM orders WHERE city = 'Prague';

-- B: Orders from Prague strictly above 1500. Expected order ID: {3}.
SELECT * FROM orders WHERE city = 'Prague' AND amount > 1500;

CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    city TEXT,
    amount INTEGER,
    status TEXT
);

INSERT INTO transactions (transaction_id, city, amount, status) VALUES
    (1, 'Prague', 1200, 'completed'),
    (2, 'Tashkent', 800, 'pending'),
    (3, 'Prague', 2500, 'completed'),
    (4, 'Brno', 1700, 'rejected'),
    (5, 'Prague', 600, 'pending'),
    (6, 'Tashkent', 3200, 'completed'),
    (7, 'Brno', 900, 'completed'),
    (8, 'Prague', 1500, 'completed');

-- 1: IDs and amounts of completed transactions.
-- Review: added the missing status filter.
-- Expected transaction IDs: {1, 3, 6, 7, 8}.
SELECT transaction_id, amount
FROM transactions
WHERE status = 'completed';

-- 2: All columns for amounts between 1000 and 2500, inclusive.
-- Correct in the original solution. Expected transaction IDs: {1, 3, 4, 8}.
SELECT *
FROM transactions
WHERE amount >= 1000 AND amount <= 2500;

-- 3: Completed transactions in Prague or Tashkent, all columns.
-- Review: conditions were correct; changed SELECT transaction_id to SELECT *.
-- Expected transaction IDs: {1, 3, 6, 8}.
SELECT *
FROM transactions
WHERE status = 'completed'
  AND (city = 'Tashkent' OR city = 'Prague');

-- 4: Pending or rejected transactions strictly above 1000, all columns.
-- Review: changed SELECT transaction_id to SELECT * and >= to >.
-- Expected transaction ID: {4}.
SELECT *
FROM transactions
WHERE (status = 'rejected' OR status = 'pending')
  AND amount > 1000;

-- Learning notes:
-- SELECT chooses columns; WHERE filters rows.
-- AND takes precedence over OR; parentheses make the grouping explicit.
-- >= includes the boundary; > excludes it.
-- A pending transaction of exactly 1000 would match >= 1000, but not > 1000.
-- Without ORDER BY, result row order is not guaranteed.
