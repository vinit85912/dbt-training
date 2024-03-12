select 
-- from raw orders
{{ dbt_utils.generate_surrogate_key(['o.orderid', 'c.customerid','p.productid']) }} as SK_orders,
o.orderid,
o.orderdate,
o.shipdate,
o.shipmode,
o.ordersellingprice - o.ordercostprice as orderprofit,
o.ordersellingprice,
o.ordercostprice,
--from raw customer
c.customerid,
c.customername,
c.segment,
c.country,
--from raw prodcut
p.productid,
p.category,
p.productname,
p.subcategory,
{{ markup('ordersellingprice', 'ordercostprice' ) }}  as markup,
d.delivery_team
from {{ ref('raw_orders') }} as O 
LEFT join {{ ref('raw_customer') }} as C 
ON O.customerid = c.customerid
LEFT join {{ ref('raw_product') }} as P 
ON O.productid = P.productid
Left join {{ ref('delivery_team') }} as d
ON o.shipmode=d.shipmode