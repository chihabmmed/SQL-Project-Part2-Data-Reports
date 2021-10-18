-- 1 -- quick look on the table grp_member
SELECT 
    *
FROM
    grp_member
LIMIT 3;

-- 2 -- members Growth over years ---------------------------------
SELECT 
    year_of_1st_grp_joined, COUNT(member_id)
FROM
    (SELECT 
        member_id, YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id) AS tbl1
GROUP BY year_of_1st_grp_joined
ORDER BY year_of_1st_grp_joined ASC;

-- a) rounded percentage change of growth in 2015 from that of 2014

SELECT ROUND(((8223 - 3771) / 3771) * 100, 0) AS num_memb_percent_diff_2014_2015;

-- b) rounded percentage change of growth in 2016 from that of 2015
SELECT ROUND(((10123 - 8223) / 8223) * 100, 0) AS num_memb_percent_diff_2015_2016;

-- c) rounded percentage change of growth in 2017 from that of 2016
SELECT ROUND(((10486 - 10123) / 10123) * 100, 0) AS num_memb_percent_diff_2016_2017;


-- 3 -----------------------------------
-- a -set sql allow updates
set sql_safe_updates = 0;
-- find distinct cities
SELECT DISTINCT
    city
FROM
    grp_member;

-- b -updating san francisco city column
UPDATE grp_member 
SET 
    city = 'San Francisco'
WHERE
    city IN ('San Francisco' , 'South San Francisco');

-- c -updating new york city column
UPDATE grp_member 
SET 
    city = 'New York'
WHERE
    city IN ('New York' , 'West New York');

-- d -updating chicago city column
UPDATE grp_member 
SET 
    city = 'Chicago'
WHERE
    city IN ('East Chicago' , 'West Chicago',
        'North Chicago',
        'Chicago Heights',
        'Chicago Ridge',
        'Chicago');

-- e- check edited distinct cities column
SELECT DISTINCT
    city
FROM
    grp_member;
-- f- set sql to block updates
set sql_safe_updates = 1;


-- 4 -- year over year growth of members per city ---------------------------------

SELECT 
    year_of_1st_grp_joined, COUNT(city) ny_count
FROM
    (SELECT 
        member_id, city, YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id
    HAVING city = 'New York') AS tbl1
GROUP BY year_of_1st_grp_joined
ORDER BY year_of_1st_grp_joined ASC;
 
-- b- year over year growth of members per city: san francisco
SELECT 
    year_of_1st_grp_joined, COUNT(city) san_francisco_count
FROM
    (SELECT 
        member_id, city, YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id
    HAVING city = 'San Francisco') AS tbl2
GROUP BY year_of_1st_grp_joined
ORDER BY year_of_1st_grp_joined ASC;

-- c- year over year growth of members per city: Chicago
SELECT 
    year_of_1st_grp_joined, COUNT(city) chicago_count
FROM
    (SELECT 
        member_id, city, YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id
    HAVING city = 'Chicago') AS tbl3
GROUP BY year_of_1st_grp_joined
ORDER BY year_of_1st_grp_joined ASC;

-- d- Joining tables year and cities to show growth side by side
SELECT 
    tblny.year_of_1st_grp_joined,
    ny_count,
    san_francisco_count,
    chicago_count
FROM
    (SELECT 
        year_of_1st_grp_joined, COUNT(city) ny_count
    FROM
        (SELECT 
        member_id, city, YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id
    HAVING city = 'New York') AS tbl1
    GROUP BY year_of_1st_grp_joined
    ORDER BY year_of_1st_grp_joined ASC) AS tblny
        JOIN
    (SELECT 
        year_of_1st_grp_joined, COUNT(city) san_francisco_count
    FROM
        (SELECT 
        member_id, city, YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id
    HAVING city = 'San Francisco') AS tbl2
    GROUP BY year_of_1st_grp_joined
    ORDER BY year_of_1st_grp_joined ASC) AS tblsf ON tblny.year_of_1st_grp_joined = tblsf.year_of_1st_grp_joined
        JOIN
    (SELECT 
        year_of_1st_grp_joined, COUNT(city) chicago_count
    FROM
        (SELECT 
        member_id, city, YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id
    HAVING city = 'Chicago') AS tbl3
    GROUP BY year_of_1st_grp_joined
    ORDER BY year_of_1st_grp_joined ASC) AS tblch ON tblny.year_of_1st_grp_joined = tblch.year_of_1st_grp_joined;


-- 5 -- 2017 year period: LetsMeet Growth -------------------------

SELECT 
    month_of_1st_grp_joined month_of_1st_grp_joined_2017,
    COUNT(member_id)
FROM
    (SELECT 
        *
    FROM
        (SELECT 
        member_id,
            MONTH(MIN(joined)) month_of_1st_grp_joined,
            YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id) AS tbl1
    WHERE
        year_of_1st_grp_joined = 2017) AS tbl2
GROUP BY month_of_1st_grp_joined
ORDER BY month_of_1st_grp_joined ASC;

-- b-member growth over year 2017 per month and per city(monthly)
-- New York City
SELECT 
    month_of_1st_grp_joined month_of_1st_grp_joined_2017,
    COUNT(member_id) ny_member_count
FROM
    (SELECT 
        *
    FROM
        (SELECT 
        member_id,
            city,
            MONTH(MIN(joined)) month_of_1st_grp_joined,
            YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id) AS tbl1
    WHERE
        year_of_1st_grp_joined = 2017
            AND city = 'New York') AS tbl2
GROUP BY month_of_1st_grp_joined
ORDER BY month_of_1st_grp_joined ASC;

-- San Francisco City
SELECT 
    month_of_1st_grp_joined month_of_1st_grp_joined_2017,
    COUNT(member_id) san_francisco_member_count
FROM
    (SELECT 
        *
    FROM
        (SELECT 
        member_id,
            city,
            MONTH(MIN(joined)) month_of_1st_grp_joined,
            YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id) AS tbl1
    WHERE
        year_of_1st_grp_joined = 2017
            AND city = 'San Francisco') AS tbl2
GROUP BY month_of_1st_grp_joined
ORDER BY month_of_1st_grp_joined ASC;

-- Chicago City
SELECT 
    month_of_1st_grp_joined month_of_1st_grp_joined_2017,
    COUNT(member_id) chicago_member_count
FROM
    (SELECT 
        *
    FROM
        (SELECT 
        member_id,
            city,
            MONTH(MIN(joined)) month_of_1st_grp_joined,
            YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id) AS tbl1
    WHERE
        year_of_1st_grp_joined = 2017
            AND city = 'Chicago') AS tbl2
GROUP BY month_of_1st_grp_joined
ORDER BY month_of_1st_grp_joined ASC;

-- c- Joining tables month and cities to show growth side by side in 2017
SELECT 
    tblny.month_of_1st_grp_joined_2017,
    ny_member_count,
    san_francisco_member_count,
    chicago_member_count
FROM
    (SELECT 
        month_of_1st_grp_joined month_of_1st_grp_joined_2017,
            COUNT(member_id) ny_member_count
    FROM
        (SELECT 
        *
    FROM
        (SELECT 
        member_id,
            city,
            MONTH(MIN(joined)) month_of_1st_grp_joined,
            YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id) AS tbl1
    WHERE
        year_of_1st_grp_joined = 2017
            AND city = 'New York') AS tbl2
    GROUP BY month_of_1st_grp_joined
    ORDER BY month_of_1st_grp_joined ASC) AS tblny
        JOIN
    (SELECT 
        month_of_1st_grp_joined month_of_1st_grp_joined_2017,
            COUNT(member_id) chicago_member_count
    FROM
        (SELECT 
        *
    FROM
        (SELECT 
        member_id,
            city,
            MONTH(MIN(joined)) month_of_1st_grp_joined,
            YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id) AS tbl1
    WHERE
        year_of_1st_grp_joined = 2017
            AND city = 'Chicago') AS tbl2
    GROUP BY month_of_1st_grp_joined
    ORDER BY month_of_1st_grp_joined ASC) AS tblchicago ON tblny.month_of_1st_grp_joined_2017 = tblchicago.month_of_1st_grp_joined_2017
        LEFT JOIN
    (SELECT 
        month_of_1st_grp_joined month_of_1st_grp_joined_2017,
            COUNT(member_id) san_francisco_member_count
    FROM
        (SELECT 
        *
    FROM
        (SELECT 
        member_id,
            city,
            MONTH(MIN(joined)) month_of_1st_grp_joined,
            YEAR(MIN(joined)) year_of_1st_grp_joined
    FROM
        grp_member
    GROUP BY member_id) AS tbl1
    WHERE
        year_of_1st_grp_joined = 2017
            AND city = 'San Francisco') AS tbl2
    GROUP BY month_of_1st_grp_joined
    ORDER BY month_of_1st_grp_joined ASC) AS tblsf ON tblny.month_of_1st_grp_joined_2017 = tblsf.month_of_1st_grp_joined_2017;






