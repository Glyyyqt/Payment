<?php 
    session_start();
    require_once($_SERVER["DOCUMENT_ROOT"]."/app/config/Directories.php");

    include(ROOT_DIR."app/config/DatabaseConnect.php");
    $db = new DatabaseConnect();
    $conn = $db->connectDB();

    //this variable will hold product data from db
    $product = [];
    $id = @$_GET['id'];
    
    try {
        
        $sql  = "SELECT * FROM products WHERE products.id = $id "; //select statement here
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $product = $stmt->fetch();
        
    } catch (PDOException $e){
        echo "Connection Failed: " . $e->getMessage();
        $db = null;
    }


    require_once(ROOT_DIR."includes/header.php");

    if(isset($_SESSION["error"])){
        $messageErr = $_SESSION["error"];
        unset($_SESSION["error"]);
    }

    if(isset($_SESSION["success"])){
        $messageSucc = $_SESSION["success"];
        unset($_SESSION["success"]);
    }


?>
    <!-- Navbar -->
    <?php require_once(ROOT_DIR."includes/navbar.php"); ?>

    <!-- add page-guard -->
    <?php require_once(__DIR__."/../../components/page-guard.php"); ?> 

    <!-- Product Maintenance Form -->
    <div class="container my-5">
        <h2>Edit Product</h2>
        
        <!-- message response -->
        <?php if(isset($messageSucc)){ ?>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <strong><?php echo $messageSucc; ?></strong> 
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php } ?>    

        <?php if(isset($messageErr)){ ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong><?php echo $messageErr; ?></strong> 
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php } ?>

        <form action="<?php echo BASE_URL;?>app/product/update_product.php" method="POST" enctype="multipart/form-data" >
            <div class="row">
                <!-- Left Column: Product Image -->
                <div class="col-md-4 mb-3">
                    <label for="productImage" class="form-label">Product Image</label>
                    <input type="file" class="form-control" id="productImage" name="productImage" accept="image/*">

                    <div class="mt-3">
                        <img id="imagePreview" src="<?php echo BASE_URL.$product["image_url"]; ?>" alt="Image Preview" class="img-fluid" style="display: block; max-height: 300px;">
                    </div>
                </div>

                <!-- Right Column: Product Details -->
                <div class="col-md-8">
                    <div class="row">
                        <!--Product ID -->
                        <input type="hidden" class="form-control" id="id" name="id" value="<?php echo $product["id"]; ?>">
                        <input type="hidden" class="form-control" id="productImage2" name="productImage2" value="<?php echo $product["image_url"]; ?>">

                        <!-- Product Name -->
                        <div class="col-md-12 mb-3">
                            <label for="productName" class="form-label">Product Name</label>
                            <input type="text" class="form-control" id="productName" name="productName" placeholder="Enter product name" value="<?php echo $product["product_name"] ?>">
                        </div>

                        <!-- Product Category -->
                        <div class="col-md-12 mb-3">
                            <label for="category" class="form-label">Category</label>
                            <select id="category" name="category" class="form-select">
                                <option selected>Choose a category</option>
                                <option value="1" <?php echo ($product["category_id"]=="1"? "selected" : "");?> >Electronics</option>
                                <option value="2" <?php echo ($product["category_id"]=="2"? "selected" : "");?> >Fashion</option>
                                <option value="3" <?php echo ($product["category_id"]=="3"? "selected" : "");?> >Home Appliances</option>
                                <!-- Add more categories as needed -->
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Base Price -->
                        <div class="col-md-6 mb-3">
                            <label for="basePrice" class="form-label">Base Price</label>
                            <input type="number" class="form-control" id="basePrice" name="basePrice" placeholder="Enter Base Price" value="<?php echo $product["base_price"] ?>">
                        </div>

                        <!-- Number of Stocks -->
                        <div class="col-md-6 mb-3">
                            <label for="numberOfStocks" class="form-label">Number of Stocks</label>
                            <input type="number" class="form-control" id="numberOfStocks" name="numberOfStocks" placeholder="Enter number of stocks" oninput="calculateTotalPrice()" value="<?php echo $product["stocks"] ?>">
                        </div>

                        <!-- Unit Price -->
                        <div class="col-md-6 mb-3">
                            <label for="unitPrice" class="form-label">Unit Price</label>
                            <input type="number" step="0.01" class="form-control" id="unitPrice" name="unitPrice" placeholder="Enter unit price" oninput="calculateTotalPrice()" value="<?php echo $product["unit_price"] ?>">
                        </div>

                        <!-- Total Price (Automatically Calculated) -->
                        <div class="col-md-6 mb-3">
                            <label for="totalPrice" class="form-label">Total Price</label>
                            <input type="text" class="form-control" id="totalPrice" name="totalPrice" placeholder="Total Price" value="<?php echo $product["total_price"] ?>" readonly>
                        </div>
                    </div>

                    <!-- Product Description -->
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3" placeholder="Enter product description"> <?php echo $product["product_description"]; ?> </textarea>
                        </div>
                    </div>

                    <!-- Save Button (aligned to right) -->
                    <div class="row">
                        <div class="col-md-6 d-grid gap-2">
                            <a href="<?php echo BASE_URL; ?>views/admin/products/index.php" class="btn btn-outline-secondary">Cancel</a>
                        </div>
                        <div class="col-md-6 d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Update Product</button>
                        </div>
                    </div>

                </div>
            </div>
        </form>
    </div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
<script>
    const fileInput = document.getElementById('productImage');
    const imagePreview = document.getElementById('imagePreview');

    fileInput.addEventListener('change', function(event) {
        const file = event.target.files[0]; // Get the selected file

        if (file) {
            const reader = new FileReader();

            reader.onload = function(e) {
                imagePreview.src = e.target.result;
                imagePreview.style.display = 'block'; // Show the image
            }

            reader.readAsDataURL(file);
        }
    });

    function calculateTotalPrice() {
        const unitPrice = document.getElementById("unitPrice").value;
        const numberOfStocks = document.getElementById("numberOfStocks").value;
        const totalPrice = unitPrice * numberOfStocks;
        document.getElementById("totalPrice").value = totalPrice.toFixed(2);
    }
</script>    
<!-- Footer -->
<?php require_once(ROOT_DIR."includes/footer.php"); ?>
