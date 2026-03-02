<?php
/**
 * Page template
 *
 * @package Deartbox
 */

get_header();

while (have_posts()) : the_post();
?>

<!-- Page Header -->
<section class="single-post-header">
    <div class="container">
        <h1 class="single-post-title"><?php the_title(); ?></h1>
    </div>
</section>

<!-- Page Content -->
<section class="single-post-content">
    <div class="container">
        <article id="page-<?php the_ID(); ?>" <?php post_class('post-content'); ?>>
            <?php the_content(); ?>
        </article>

        <?php
        // If comments are open or we have at least one comment
        if (comments_open() || get_comments_number()) :
            comments_template();
        endif;
        ?>
    </div>
</section>

<?php
endwhile;

get_footer();
