SELECT
  *
FROM
  (
    SELECT
      employees.lastName,
      employees.firstName,
      salesRepEmployeeNumber,
      DATE_FORMAT(paymentDate, '%Y-%m') as payment_month,
      SUM(amount) as CA,
      RANK() OVER(
        PARTITION BY DATE_FORMAT(paymentDate, '%Y-%m')
        ORDER BY
          SUM(amount) DESC
      ) AS ranking
    FROM
      customers
      INNER JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
      INNER JOIN payments ON payments.customerNumber = customers.customerNumber
    GROUP BY
      salesRepEmployeeNumber,
      payment_month
  ) AS best_sell
ORDER BY
  payment_month DESC,
  CA DESC;