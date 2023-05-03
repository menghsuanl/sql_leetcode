-- use rank to find every seller's 2nd order item id
-- left join item with brand name
-- left join user's fav bran
-- check if item brands are equal
WITH sec_ord AS (
SELECT
u.user_id,
u.favorite_brand,
o.item_brand
FROM Users u
LEFT JOIN
(
    SELECT
    seller_id,
    item_brand
    FROM
    (
        SELECT
        seller_id,
        i.item_brand,
        DENSE_RANK() OVER (PARTITION BY seller_id ORDER BY order_date) AS rnk
        FROM Orders o
        INNER JOIN Items i
        ON o.item_id = i.item_id
    ) a
    WHERE a.rnk = 2
  ) o
ON u.user_id = o.seller_id
)


SELECT
user_id AS seller_id,
(CASE WHEN favorite_brand = item_brand THEN 'yes' ELSE 'no' END) AS 2nd_item_fav_brand
FROM sec_ord
