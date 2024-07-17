<?php include 'db.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management</title>
    <link rel="stylesheet" href="style.css">
    <script>
        function showSection(sectionId) {
            const sections = ['section1', 'section2', 'section3', 'section4'];
            sections.forEach(id => {
                document.getElementById(id).style.display = id === sectionId ? 'block' : 'none';
            });
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>StockTracker: Real-Time Inventory Monitoring System</h1>
        <div class="navbar">
            <button onclick="showSection('section1')">Products with Categories and Suppliers</button>
            <button onclick="showSection('section2')">Category Wise Quantity</button>
            <button onclick="showSection('section3')">Total Sales Amount</button>
            <button onclick="showSection('section4')">Supplier Details</button>
        </div>

        <div id="section1" class="section" style="display:none;">
            <h2>Products with Categories and Suppliers</h2>
            <table>
                <tr>
                    <th>Product Name</th>
                    <th>Category Name</th>
                    <th>Supplier Name</th>
                </tr>
                <?php
                $query1 = "SELECT p.ProductName, c.CategoryName, s.SupplierName
                            FROM Products p
                            INNER JOIN Categories c ON p.CategoryID = c.CategoryID
                            INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID";
                $result1 = $conn->query($query1);
                while ($row = $result1->fetch_assoc()) {
                    echo "<tr>
                            <td>{$row['ProductName']}</td>
                            <td>{$row['CategoryName']}</td>
                            <td>{$row['SupplierName']}</td>
                          </tr>";
                }
                ?>
            </table>
        </div>

        <div id="section2" class="section" style="display:none;">
            <h2>Total Quantity by Category</h2>
            <table>
                <tr>
                    <th>Category Name</th>
                    <th>Total Quantity</th>
                </tr>
                <?php
                $query2 = "SELECT c.CategoryName, SUM(p.QuantityInStock) AS TotalQuantity
                            FROM Products p
                            INNER JOIN Categories c ON p.CategoryID = c.CategoryID
                            GROUP BY c.CategoryName";
                $result2 = $conn->query($query2);
                while ($row = $result2->fetch_assoc()) {
                    echo "<tr>
                            <td>{$row['CategoryName']}</td>
                            <td>{$row['TotalQuantity']}</td>
                          </tr>";
                }
                ?>
            </table>
        </div>

        <div id="section3" class="section" style="display:none;">
            <h2>Total Sales Amount by Transaction Type</h2>
            <table>
                <tr>
                    <th>Transaction Type</th>
                    <th>Total Sales Amount</th>
                </tr>
                <?php
                $query3 = "SELECT TransactionType, SUM(Quantity * UnitPrice) AS TotalSalesAmount
                            FROM Transactions t
                            JOIN Products p ON t.ProductID = p.ProductID
                            GROUP BY TransactionType";
                $result3 = $conn->query($query3);
                while ($row = $result3->fetch_assoc()) {
                    echo "<tr>
                            <td>{$row['TransactionType']}</td>
                            <td>{$row['TotalSalesAmount']}</td>
                          </tr>";
                }
                ?>
            </table>
        </div>

        <div id="section4" class="section" style="display:none;">
            <h2>Supplier Details</h2>
            <table>
                <tr>
                    <th>Supplier Name</th>
                    <th>Email</th>
                    <th>City</th>
                </tr>
                <?php
                $query4 = "SELECT SupplierName, Email, City FROM Suppliers";
                $result4 = $conn->query($query4);
                while ($row = $result4->fetch_assoc()) {
                    echo "<tr>
                            <td>{$row['SupplierName']}</td>
                            <td>{$row['Email']}</td>
                            <td>{$row['City']}</td>
                          </tr>";
                }
                ?>
            </table>
        </div>
    </div>
</body>
</html>
