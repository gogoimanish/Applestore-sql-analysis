CREATE TABLE applestore_combined AS

SELECT * FROM appleStore_description1

union ALL

SELECT * FROM appleStore_description2

UNION  ALL

SELECT * FROM appleStore_description3

UNION ALL

SELECT * FROM appleStore_description4
-----------------------------------------------------------------------------------------------------------------------
  
     ---CHECKING NUMBER OF UNIQUE APPS IN THE TABELS---
     
    * SELECT COUNT(DISTINCT ID) AS UNIQ_APPSID
     FROM AppleStore;
     
     * SELECT COUNT(DISTINCT ID) AS UNIQ_APPSID
      FROM applestore_combined
---------------------------------------------------------------------------------------------------------------------  
      ---CHECKING FOR ANY MISSING VALUES---
      
       SELECT count(*) as Missing_values 
       from AppleStore
      WHERE track_name IS NULL or prime_genre IS NULL or user_rating is null;
      
       
       SELECT count(*) as Missing_values
       from applestore_combined
      WHERE app_desc IS NULL;
-----------------------------------------------------------------------------------------------------------------------      
 ---Finding out the total number of apps per genre---
 
 SELECT prime_genre, count(*) app_num
 from AppleStore
 group by prime_genre
 order by app_num desc;
 ----------------------------------------------------------------------------------------------------------------------
  ---App rating---
  
  select min(user_rating) as min_rating,
  max(user_rating) as max_rating,
  avg(user_rating) as avg_rating
  from AppleStore;
----------------------------------------------------------------------------------------------------------------------
---where hgher ratings paid or free apps---AppleStore

select CASE
        when price > 0 then 'Paid'
        else 'free'
end as app_type,
avg(user_rating) as avg_rating
 from AppleStore
 group by app_type
----------------------------------------------------------------------------------------------------------------------
---if apps with higher language support has higher ratings---AppleStore

select 
case 
when lang_num <10 then '<10 languages'
when lang_num BETWEEN 10 and 30 then '10-30 languages'
else '>30 languages'
end as lang_supp,
avg(user_rating) as avg_rating
from AppleStore
group by lang_supp
order by avg_rating desc
-----------------------------------------------------------------------------------------------------------------------
---genres with low rating---

SELECT prime_genre,
avg(user_rating) as avg_rating
from AppleStore
GROUP by prime_genre
order by avg_rating ASC
limit 10;
-----------------------------------------------------------------------------------------------------------------------
---correlation between app desc length and user ratings---

SELECT
   case 
   when length(d.app_desc) <500 then 'short'
   when length(d.app_desc) between 500 and 1000 then 'medium'
   else'long'
   end as desc_length,
   avg(user_rating) as avg_rating
FROM
AppleStore a
JOIN
applestore_combined d
ON a.id=d.id
group  by desc_length
order by avg_rating desc;
-----------------------------------------------------------------------------------------------------------------------
---top rated apps for each category/genre---

SELECT
prime_genre,
track_name,
user_rating
      FROM
          (SELECT
          prime_genre,
          track_name,
          user_rating,
       Rank() 
           over(partition by prime_genre order by user_rating desc, rating_count_tot desc) as rank
       from AppleStore
       )as A
   where A.rank=1
------------------------------------------------------------------------------------------------------------------------
---RECOMMENDATION/INSIGHTS---

-PAID APPS HAVE BETTER RATINGS.
-APPS SUPPORTING 10-30 LANGUAGES HAVE BETTER RATINGS
-FINANCE,BOOK APPS HAVE LOW RATINGS
-APP DESCRIPTION LENGTH HAS A POSITIVE CORRELATION -> RATINGS
-NEW APPS SHOULD TARGET RATINGS 3.5 & ABOVE
-GAMES & ENTERTAINMENT HAVE HIGH COMPETTION
   
       
       from
       
         


