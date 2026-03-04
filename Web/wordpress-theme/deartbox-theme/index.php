<?php
/**
 * Main template file
 *
 * @package Deartbox
 */

get_header();
?>

<!-- Blog Hero -->
<section class="blog-hero">
    <div class="container">
        <?php if (!is_home()) : ?>
            <?php deartbox_breadcrumbs(); ?>
        <?php endif; ?>

        <?php if (is_home() && !is_paged()) : ?>
            <h1>Blog D'ArtBox Packaging</h1>
            <p>Tips, inspirasi, dan insight seputar packaging premium untuk brand Anda</p>
        <?php elseif (is_category()) : ?>
            <h1><?php single_cat_title(); ?></h1>
            <?php the_archive_description('<p>', '</p>'); ?>
        <?php elseif (is_tag()) : ?>
            <h1><?php printf( esc_html__( 'Tag: %s', 'deartbox' ), single_tag_title( '', false ) ); ?></h1>
        <?php elseif (is_author()) : ?>
            <h1><?php printf( esc_html__( 'Artikel oleh: %s', 'deartbox' ), esc_html( get_the_author() ) ); ?></h1>
        <?php elseif (is_search()) : ?>
            <h1><?php printf( esc_html__( 'Hasil Pencarian: "%s"', 'deartbox' ), esc_html( get_search_query( false ) ) ); ?></h1>
        <?php elseif (is_archive()) : ?>
            <h1><?php the_archive_title(); ?></h1>
        <?php endif; ?>
    </div>
</section>

<!-- Posts Section -->
<section class="posts-section">
    <div class="container">
        <?php if (have_posts()) : ?>
            <div class="posts-grid">
                <?php while (have_posts()) : the_post(); ?>
                    <?php get_template_part('template-parts/content', 'card'); ?>
                <?php endwhile; ?>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <?php
                the_posts_pagination(array(
                    'mid_size'  => 2,
                    'prev_text' => deartbox_icon('arrow-left', 16) . ' Sebelumnya',
                    'next_text' => 'Selanjutnya ' . deartbox_icon('arrow-right', 16),
                ));
                ?>
            </div>

        <?php else : ?>
            <div class="no-posts">
                <h2>Tidak ada artikel ditemukan</h2>
                <p>Maaf, tidak ada artikel yang sesuai dengan pencarian Anda.</p>
                <a href="<?php echo esc_url(home_url('/')); ?>" class="btn-primary">Kembali ke Blog</a>
            </div>
        <?php endif; ?>
    </div>
</section>

<?php
get_footer();
