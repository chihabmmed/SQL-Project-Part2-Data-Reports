
-- 2 -- all toastmasters events ---------------------------------
SELECT 
    *
FROM
    event
WHERE
    LOWER(event_name) LIKE '%toastmaster%';

-- 3 -- Toastmaster events displayed alongside the cities. ---------------------------------
-- Joining tables: event, grp and city
SELECT 
    event.event_id, city.city, event.event_name
FROM
    grp
        JOIN
    event ON event.group_id = grp.group_id
        JOIN
    city ON city.city_id = grp.city_id;

-- 4 -- "toastmaster" events count on Lets Meet ---------------------------------

SELECT 
    COUNT(event_name)
FROM
    event
WHERE
    LOWER(event_name) LIKE '%toastmaster%';
-- --another way
SELECT 
    SUM(events_name_count)
FROM
    (SELECT 
        COUNT(event_name) events_name_count
    FROM
        grp
    JOIN event ON event.group_id = grp.group_id
    JOIN city ON city.city_id = grp.city_id
    WHERE
        LOWER(event_name) LIKE '%toastmaster%') AS tbl1;

-- b) count of "toastermaster" events per city
SELECT 
    city.city, COUNT(event_name)
FROM
    grp
        JOIN
    event ON event.group_id = grp.group_id
        JOIN
    city ON city.city_id = grp.city_id
WHERE
    LOWER(event_name) LIKE '%toastmaster%'
GROUP BY city;

























