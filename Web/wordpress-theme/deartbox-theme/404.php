<?php
/**
 * 404 Page template
 *
 * @package Deartbox
 */

get_header();
?>

<section class="error-404">
    <div class="container">
        <h1>404</h1>
        <h2>Halaman Tidak Ditemukan</h2>
        <p>Maaf, halaman yang Anda cari tidak dapat ditemukan. Mungkin halaman telah dipindahkan atau dihapus.</p>
        
        <a href="<?php echo esc_url(home_url('/')); ?>" class="btn-primary">
            <?php deartbox_the_icon('arrow-left', 16); ?>
            Kembali ke Blog
        </a>
    </div>
</section>

<?php
get_footer();
