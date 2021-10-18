-- 
-- 2 -- rating examination ---------------------------------
-- a
-- distinct ratings
SELECT DISTINCT
    rating
FROM
    grp
ORDER BY rating ASC;

-- categorizing and conting groups by ratings

SELECT 
    COUNT(CASE
        WHEN rating <= 0 THEN 0
    END) r_0,
    COUNT(CASE
        WHEN rating BETWEEN 1 AND 1.99 THEN rating = 1
    END) r_1,
    COUNT(CASE
        WHEN rating BETWEEN 2 AND 2.99 THEN rating = 2
    END) r_2,
    COUNT(CASE
        WHEN rating BETWEEN 3 AND 3.99 THEN rating = 3
    END) r_3,
    COUNT(CASE
        WHEN rating BETWEEN 4 AND 4.99 THEN rating = 4
    END) r_4,
    COUNT(CASE
        WHEN rating >= 5 THEN rating = 5
    END) r_5
FROM
    grp;
    
    -- % of groups rated 5 stars
SELECT 
    (r_5 / (r_0 + r_1 + r_2 + r_3 + r_4 + r_5)) * 100
FROM
    (SELECT 
        COUNT(CASE
                WHEN rating <= 0 THEN 0
            END) r_0,
            COUNT(CASE
                WHEN rating BETWEEN 1 AND 1.99 THEN rating = 1
            END) r_1,
            COUNT(CASE
                WHEN rating BETWEEN 2 AND 2.99 THEN rating = 2
            END) r_2,
            COUNT(CASE
                WHEN rating BETWEEN 3 AND 3.99 THEN rating = 3
            END) r_3,
            COUNT(CASE
                WHEN rating BETWEEN 4 AND 4.99 THEN rating = 4
            END) r_4,
            COUNT(CASE
                WHEN rating >= 5 THEN rating = 5
            END) r_5
    FROM
        grp) AS tbl1;

-- b.a -three groups with perfect 5 star ratings with most members and popular categories in new york 
-- ---------- Note: Ordering by members leads to automatic ordering by category popularity amongst members.

SELECT 
    group_id,
    group_name,
    category.category_id,
    category_name,
    city,
    rating,
    members
FROM
    grp
        JOIN
    city ON grp.city_id = city.city_id
        JOIN
    category ON grp.category_id = category.category_id
WHERE
    city.city = 'New York'
ORDER BY rating DESC , members DESC
LIMIT 3;

-- b.c -one group with a perfect 5 star ratings with most members and popular categories in san francisco
-- ---------- Note: Ordering by members leads to automatic ordering by category popularity amongst members.

SELECT 
    group_id,
    group_name,
    category.category_id,
    category_name,
    city,
    rating,
    members
FROM
    grp
        JOIN
    city ON grp.city_id = city.city_id
        JOIN
    category ON grp.category_id = category.category_id
WHERE
    city.city = 'San Francisco'
ORDER BY rating DESC , members DESC
LIMIT 1;

-- b.d -one group with a perfect 5 star ratings with most members and popular categories in chicago
-- ---------- Note: Ordering by members leads to automatic ordering by category popularity amongst members.

SELECT 
    group_id,
    group_name,
    category.category_id,
    category_name,
    city,
    rating,
    members
FROM
    grp
        JOIN
    city ON grp.city_id = city.city_id
        JOIN
    category ON grp.category_id = category.category_id
WHERE
    city.city = 'Chicago'
ORDER BY rating DESC , members DESC
LIMIT 1;












