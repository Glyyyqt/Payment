<?php

if(!isset($_SESSION)){
    session_start();
}

require_once(__DIR__."/../config/Directories.php"); //to handle folder specific path
include("..\config\DatabaseConnect.php"); //to access database connection

//redirect to login page if not login
if(!isset($_SESSION["username"])){
    header("location: ".BASE_URL."login.php");
    exit;
}

$db = new DatabaseConnect(); //make a new database instance

if($_SERVER["REQUEST_METHOD"] == "POST"){
    //retrieve user input
    $totalOrder     = htmlspecialchars($_POST["total_order"]);
    $deliveryFee    = htmlspecialchars($_POST["delivery_fee"]);
    $totalAmount    = htmlspecialchars($_POST["total_amount"]);
    $paymentMethod  = htmlspecialchars($_POST["payment_method"]);
    $cardNumber     = htmlspecialchars($_POST["card_number"]);
    $userId         = $_SESSION["user_id"];
    $totalPrice     = 0;

    // validations
    if (trim($totalOrder) == "" || empty($totalOrder) || floatval($totalOrder) == 0.00) {
        $_SESSION["error"] = "Total Order cannot be zero";
        header("location: " . BASE_URL . "cart.php");
        exit;
    }

    //validation end    

    // Get all cart records of the user where status is 0
    try {
        $product = [];
        $conn = $db->connectDB();
        $sql = "SELECT id, product_id, user_id, quantity FROM carts WHERE carts.user_id = :p_user_id AND carts.status = 0";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':p_user_id', $userId);
        if(!$stmt->execute()){
            $_SESSION["error"] = "Failed to execute cart query ";
            header("location: " . BASE_URL . "cart.php");
            exit;
        }
        $carts = $stmt->fetchAll();

        $conn->beginTransaction();

        foreach ($carts as $cart){
            //update the cart of the user FROM status = 0 to status = 1
            $sql = "UPDATE carts SET carts.status = 1 WHERE carts.user_id = :p_user_id AND carts.id = :p_cart_id";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':p_user_id', $userId);
            $stmt->bindParam(':p_cart_id', $cart["id"]);
            if(!$stmt->execute()){
                $_SESSION["error"] = "Failed to update cart status";
                $conn->rollBack();
                header("location: ".BASE_URL."cart.php");
                exit;
            }

            //update the product table to deduct stocks
            $sql = "UPDATE products SET products.stocks = (products.stocks - :p_quantity) WHERE id = :p_product_id AND products.stocks >= :p_quantity";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':p_quantity', $cart["quantity"]);
            $stmt->bindParam(':p_product_id', $cart["product_id"]);
            if (!$stmt->execute()) {
                $_SESSION["error"] = "Failed to update product stocks";
                $conn->rollBack();
                header("location: ".BASE_URL."cart.php");
                exit;
            }

            //validate there is no record return from Update query above,
            //meaning no matching product with enough quantity exist
            if($stmt->rowCount() <= 0){
                $_SESSION["error"] = "Not enough stocks for this product";
                $conn->rollBack();
                header("location: ".BASE_URL."cart.php");
                exit;
            }
        }

        //insert record to orders table
        $sql = "INSERT INTO orders (order_date, payment_method, account_no, user_id,
                                    total_order, delivery_fee, total_amount, created_at, updated_at)
                values (NOW(), :p_payment_method, :p_account_no, :p_user_id,
                        :p_total_order, :p_delivery_fee, :p_total_amount, NOW(), NOW()
        )";
        $stmt = $conn->prepare($sql);
        $data = [
            ':p_payment_method' => $paymentMethod,
            ':p_account_no'     => $cardNumber,
            ':p_user_id'        => $userId,
            ':p_total_order'    => $totalOrder,
            ':p_delivery_fee'   => $deliveryFee,
            ':p_total_amount'   => $totalAmount
        ];
        if(!$stmt->execute($data)){
            $_SESSION["error"] = "Failed to insert record to orders table";
            $conn->rollBack();
            header("location: ".BASE_URL."cart.php");
            exit;
        }

        $conn->commit();
        $_SESSION["success"] = "Payment Success";
        header("location: ".BASE_URL."views/payment/success.php");
        exit;

    } catch (PDOException $e) {
        echo "Connection Failed: " . $e->getMessage();
        $db = null;
    }
}
