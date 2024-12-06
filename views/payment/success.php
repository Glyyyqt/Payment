<?php
session_start();
require_once(__DIR__."/../../app/config/Directories.php");

if(isset($_SESSION["success"])){
    $messageSucc = $_SESSION["success"];
    unset($_SESSION["success"]);
}
require_once(ROOT_DIR."/includes/header.php");
?>

<?php require_once(ROOT_DIR."/includes/navbar.php"); ?>

    <?php
    if(!isset($_SESSION["username"])){
        header("location: ".BASE_URL."login.php");
        exit;
    }
    ?>  

 <div class="container content mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header text-center bg-success text-white">
                    <h4><?php echo (isset($messageSucc) ? $messageSucc : "Payment Successful") ; ?></h4>
                </div>
                <div class="card-body text-center">
                    <i class="fas fa-check-circle fa-5x text-success mb-3"></i>
                    <p class="lead">Your payment has been successfully processed. Thank you for your purchase!</p>
                    <a href="<?php echo BASE_URL; ?>index.php" class="btn btn-success">Go to Home</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <?php require_once(ROOT_DIR."includes/footer.php"); ?>

