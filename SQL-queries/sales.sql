SELECT
  SUM(orderdetails.quantityOrdered) as NbProdV,
  DATE_FORMAT(orderDate, '%Y-%m') as Date_commande,
  productLine as Category
FROM
  products
  INNER JOIN orderdetails ON products.productCode = orderdetails.productCode
  INNER JOIN orders ON orderdetails.orderNumber = orders.orderNumber
GROUP BY
  DATE_FORMAT(orderDate, '%Y-%m'),
  productLine
ORDER BY
  Date_commande DESC,
  Category ASC;