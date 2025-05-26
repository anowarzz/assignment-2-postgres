## 1. What is PostgreSQL?

### PostgreSQL কি ?

ডেটা সংরক্ষন করার জন্য আমরা বিভিন্ন ধরনের Database ব্যবহার করে থাকি । এটি হতে পারে Relational Database অথবা Non Relational Database ।

PostgreSQL হচ্ছে একটি শক্তিশালী, ওপেন-সোর্স রিলেশনাল ডাটাবেজ ম্যানেজমেন্ট সিস্টেম (RDBMS)। আমরা এটি ডেটা স্টোর করা , কোয়েরি করা, আর ডাটা ম্যানেজ করতে ব্যবহার করতে পারি ।

এটি SQL স্ট্যান্ডার্ড মেনে চলে এবং JSONB, full-text search, আর ACID ট্রানজ্যাকশনের মতো অ্যাডভান্সড ফিচার সাপোর্ট করে, যা Postgres কে সবার নিকট আরো নির্ভরযোগ্য আর জনপ্রিয় করেছে ।

PostgreSQL এর সুবিধাগুলো:

- **ওপেন-সোর্স:** PostgreSQL ফ্রি এবং কাস্টমাইজযোগ্য এবং এর বড় কমিউনিটির সাপোর্ট আছে
- **ACID কমপ্লায়েন্ট:** ডেটা নিরাপদ ও নির্ভরযোগ্য থাকে
- **আধুনিক ফিচার:** JSONB, ফুল-টেক্সট সার্চ এবং জিও ডেটা সাপোর্ট করে
- **স্কেলেবিলিটি:** ছোট থেকে বড় সব ধরনের অ্যাপে ব্যবহার করা যায়
- **নিরাপত্তা:** ভালো অথেনটিকেশন ও এনক্রিপশন সাপোর্ট করে

একটি ছোট উদাহরন এর মধ্যেমে আমরা PostgreSQL এর মধ্যে Data কিভাবে Store করা হয় তা নিচে দেখতে পারি ।

```sql
-- বই এর ডেটা রাখতে books নামে  একটি Table তৈরী করার জন্য
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    price INTEGER
);
-- books নামক Table এর মধ্যে ডেটা Insert করার জন্য
INSERT INTO books (title, price) VALUES ('PostgreSQL এর হাতেখড়ি', 250);

--books টেবিলের মধে থেকে সবগুলো ডেটা দেখার জন্য
SELECT * FROM books;`

```

**ডেটার আউটপুট হবে নিচের মত**

| book_id | title                 | price |
| ------- | --------------------- | ----- |
| 1       | PostgreSQL এর হাতেখড়ি | 250   |

<br/>
<br/>
<br/>

## 2. Explain the **Primary Key** and **Foreign Key** concepts in PostgreSQL.

**Primary Key এবং Foreign Key কী?**

ডেটাবেজ ডিজাইনের সময় সবচেয়ে গুরুত্বপূর্ণ জিনিসগুলোর মধ্যে একটা হলো ‍**Primary Key** এবং **Foreign Key**। PostgreSQL-এ এই দুটো কনসেপ্ট ডেটার মধ্যে সম্পর্ক তৈরি করতে ও ডেটাকে ইউনিক ও নিরাপদ রাখতে সাহায্য করে।

### **Primary Key**

Primary Key এমন একটি কলাম বা কলাম এর সমষ্টি যা প্রতিটি রেকর্ডকে ইউনিকভাবে শনাক্ত করে থাকে। Primar Key এর বৈশিষ্ট্য গুলো হলো:

- এটি NULL থাকতে পারে না
- এক টেবিলে একটিই Primary Key থাকতে পারে
- সাধারণত ID টাইপের ফিল্ডেই এটা ব্যবহার করা হয়.

### **Foreign Key**

Foreign Key একটি কলাম যা অন্য একটি টেবিলের Primary Key কে রেফার করে, যার মাধ্যমে দুইটি টেবিলের মধ্যে সম্পর্ক তৈরি হয়। Foreign Key এর বৈশিষ্ট্য গুলো হলো:

- এটি মূলত রিলেশন বা কানেকশন দেখায়
- একাধিক Foreign Key একটি টেবিলে থাকতে পারে
- Parent টেবিলের ডেটা ডিলিট বা আপডেট হলে চেইন রিঅ্যাকশন ঘটে (যদি কনস্ট্রেইন্ট সেট করা থাকে)

### Primary Key এবং Foreign Key এর উদাহরণ:

ধরা যাক আমাদের দুইটা টেবিল আছে `students` এবং `courses`:

```sql
-- Students টেবিল
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Courses টেবিল যেখানে student_id হচ্ছে Foreign Key
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    student_id INTEGER REFERENCES students(student_id)
);

```

এখানে `students.student_id` হলো **Primary Key**

আর `courses.student_id` হলো **Foreign Key**

যার মাধ্যমে বোঝানো হচ্ছে কে কোন কোর্সে এনরোল করেছে।

---

এইভাবে Primary ও Foreign Key ব্যবহার করে আমরা ডেটাবেজে সম্পর্ক তৈরি করতে পারি, ভুল রেকর্ড ঢোকা ঠেকাতে পারি, এবং ডেটা কনসিসটেন্ট রাখতে পারি।

<br/>
<br/>
<br/>

## 3. Explain the purpose of the `WHERE` clause in a `SELECT` statement.

**SELECT এর মধ্যে WHERE clause কেন ব্যবহার করা হয়?**

আমরা যখন PostgreSQL-এ `SELECT` দিয়ে ডেটা কোয়েরি করে আনি, তখন সাধারণভাবে সব রেকর্ডই চলে আসে। কিন্তু অনেক সময় আমাদের দরকার হয় নির্দিষ্ট কিছু শর্ত অনুযায়ী ডেটা ফিল্টার করে দেখানোর । তখনই আমরা ব্যবহার করি `WHERE` clause।

### **WHERE clause এর কাজ কী?**

`WHERE` clause ব্যবহার করা হয় ডেটার উপর শর্ত বসানোর জন্য।

যার অর্থ হলো, টেবিলের সব রেকর্ড না এনে – শুধু যেগুলোর সাথে শর্ত মিলে, সেগুলোকেই নিয়ে আসা।

#### **WHERE clause এর বৈশিষ্ট্য:**

- `WHERE` = শর্ত দিয়ে ডেটা ফিল্টার করা
- সব কলামেই ব্যবহার করা যায়
- `SELECT`, `UPDATE`, `DELETE`—সব জায়গায় `WHERE` কাজ করে

### উদাহরণঃ

ধরি আমাদের একটা `students` নামের টেবিল আছে:

```sql

SELECT * FROM students WHERE age > 18;

```

এই কোয়েরিটা শুধু সেইসব Student দেরকে দেখাবে, যাদের বয়স ১৮ বছরের বেশি।

### WHERE ব্যবহার করে আরও কিছু শর্তের উদাহরণঃ

```sql
-- যাদের নাম 'Anika' তাদের দেখাও
SELECT * FROM students WHERE name = 'Anika';

-- যাদের বয়স ২০ বা তার বেশি
SELECT * FROM students WHERE age >= 20;

-- যাদের বিভাগ 'Science' নয়
SELECT * FROM students WHERE department != 'Science';
```

---

<br/>
<br/>
<br/>

## 4. What are the `LIMIT` and `OFFSET` clauses used for?

### **LIMIT আর OFFSET কেন ব্যবহার করা হয় ?**

আমরা অনেক সময়ই ডেটাবেজ থেকে এক সাথে সকল ডেটা দেখতে চাইনা , বিশেষ করে যখন টেবিলে হাজার হাজার রেকর্ড থাকে তার মধ্যে থেকে প্রতি রিকুয়েষ্টে অল্প কিছু করে রেকর্ড দেখতে চাই।
তখন `LIMIT` আর `OFFSET` আমাদের কাজে লাগে ।
এগুলো মূলত পেজিনেশন বা ডেটাকে ছোট ছোট ভাগে ভাগ করে দেখানোর জন্য ব্যবহার হয়।

### **LIMIT এর কাজ**

`LIMIT` দিয়ে আমরা বলে দিই, কতগুলো রেকর্ড দেখাতে হবে।

যেমন, শুধু প্রথম ১০টা রেকর্ড দেখাও।

### **OFFSET এর কাজ**

`OFFSET` দিয়ে আমরা বলে দেই, প্রথমে থেকে কতগুলো রেকর্ড বাদ দিয়ে পরেরগুলো দেখাবে।

যেমন, প্রথম ১০টা বাদ দিয়ে পরেরগুলো দেখাও।

### LIMIT এবং OFFSET এর ব্যবহার করার একটি উদাহরণঃ

```sql

-- ডেটা টেবিল থেকে প্রথম ৫টা রেকর্ড দেখানোর জন্য
SELECT * FROM students LIMIT 5;

-- প্রথম ৫টা বাদ দিয়ে পরের ৫টা ডেটা দেখানোর জন্য
SELECT * FROM students LIMIT 5 OFFSET 5;

```

<br/>
<br/>
<br/>

## 5. Explain the `GROUP BY` clause and its role in aggregation operations.

**GROUP BY clause কী এবং এটা কেন দরকার হয়?**

আমরা যখন PostgreSQL-এ ডেটা নিয়ে কাজ করি, অনেক সময় চাই যে একই ধরনের ডেটা গুলো একসাথে গ্রুপ করে তাদের ওপর গাণিতিক বিভিন্ন অপারেশন (যেমন যোগ, গড়, গণনা) করতে। তখন আমরা `GROUP BY` ব্যবহার করতে পারি ।

### **GROUP BY এর কাজ কী?**

`GROUP BY` দিয়ে টেবিলের রেকর্ডগুলোকে একটি নির্দিষ্ট কলামের মান অনুসারে ভাগ করে ফেলা হয়।

তারপর আমরা প্রতিটি গ্রুপের জন্য আলাদা করে aggregation (যেমন `COUNT()`, `SUM()`, `AVG()`) ইতাদি ব্যবহার করতে পারি।

### উদাহরণঃ

ধরি আমাদের একটা `sales` টেবিল আছে যেখানে `region` ও `amount` কলাম আছে:

```sql

SELECT region, SUM(amount) FROM sales GROUP BY region;

```

এখানে `region` অনুযায়ী সব সেলসগুলোকে ভাগ করা হয়েছে, তারপর প্রতিটি অঞ্চলের মোট বিক্রয় (amount) এক সাথে দেখানো হয়েছে।

---

### Group By এর আরেকটা উদাহরণ:

```sql

SELECT department, COUNT(*) FROM employees GROUP BY department;
```

এখানে (department) অনুযায়ী কর্মচারীদের Group করে তার সংখ্যা বের করা হয়েছে।
