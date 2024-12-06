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
    $productId      = htmlspecialchars($_POST["id"]);
    $quantity       = htmlspecialchars($_POST["quantity"]);
    $userId         = $_SESSION["user_id"];
 
    // validations
        if(trim($productId) == "" || empty($productId)){
            $_SESSION["error"] = "Product Id field is empty";
                
            header("location: ".BASE_URL."views/product/product.php");
            exit;
        }

        if(trim($quantity) == "" || empty($quantity)){
            $_SESSION["error"] = "Quantity field is empty";
                
            header("location: ".BASE_URL."views/product/product.php");
            exit;
        }

        if(trim($userId) == "" || empty($userId)){
            $_SESSION["error"] = "User ID field is empty";
                
            header("location: ".BASE_URL."views/product/product.php");
            exit;
        }

        
    //validation end    
    
    //update record to database
    try{
        $product = [];
        $conn = $db->connectDB();
        $sql  = "SELECT * FROM products WHERE products.id = :p_product_id ";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':p_product_id', $productId);
        if(!$stmt->execute()){
            $_SESSION["error"] = "Cannot find the product";
            header("location: ".BASE_URL."views/product/product.php");
            exit;
        }
        $product = $stmt->fetch();
        $totalPrice = (floatval($quantity) * floatval($product["unit_price"]));
        //INSERT INTO CART
        $sql  = "INSERT INTO carts(user_id,product_id,quantity,unit_price,total_price,created_at,updated_at) VALUES (:p_user_id,:p_product_id,:p_quantity,:p_unit_price,:p_total_price,NOW(),NOW())  ";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':p_user_id',$userId);
        $stmt->bindParam(':p_product_id',$productId);
        $stmt->bindParam(':p_quantity',$quantity);
        $stmt->bindParam(':p_unit_price',$product["unit_price"]);
        $stmt->bindParam(':p_total_price',$totalPrice);
        if(!$stmt->execute()){      
            $_SESSION["error"] = "Failed to add to cart";
            header("location: ".BASE_URL."views/product/product.php");
            exit;
        }
        
        $_SESSION["success"] = "Successfully added to cart";
        header("location: ".BASE_URL."views/product/product.php?id=".$product["id"]);
        exit;
        
    } catch (PDOException $e){
        echo "Connection Failed: " . $e->getMessage();
        $db = null;
    }    
}