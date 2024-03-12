select 
-- from raw orders
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
{{ markup('ordersellingprice', 'ordercostprice' ) }}  as markup
from {{ ref('raw_orders') }} as O 
LEFT join {{ ref('raw_customer') }} as C 
ON O.customerid = c.customerid
LEFT join {{ ref('raw_product') }} as P 
ON O.productid = P.productid

{{limit_data_in_dev('orderdate')}}