<?php
/**
 * Single post template
 *
 * @package Deartbox
 */

get_header();

while (have_posts()) : the_post();
    $category = deartbox_first_category();
    $reading_time = deartbox_reading_time();
    $share_links = deartbox_social_share();
?>

<!-- Reading Progress Bar -->
<div class="reading-progress-wrap" aria-hidden="true">
    <div class="reading-progress" id="readingProgress"></div>
</div>

<!-- Post Header -->
<section class="single-post-header">
    <div class="container">
        <?php deartbox_breadcrumbs(); ?>

        <?php if ($category) : ?>
            <a href="<?php echo esc_url(get_category_link($category->term_id)); ?>" class="post-category-badge">
                <?php echo esc_html($category->name); ?>
            </a>
        <?php endif; ?>
        
        <h1 class="single-post-title"><?php the_title(); ?></h1>
        
        <div class="single-post-meta">
            <div class="author">
                <?php echo get_avatar(get_the_author_meta('ID'), 40); ?>
                <span><?php the_author(); ?></span>
            </div>
            <span class="date">
                <?php deartbox_the_icon('calendar', 14); ?>
                <?php echo get_the_date(); ?>
            </span>
            <span class="reading-time">
                <?php deartbox_the_icon('clock', 14); ?>
                <?php echo $reading_time; ?> menit baca
            </span>
        </div>
    </div>
</section>

<!-- Featured Image -->
<?php if (has_post_thumbnail()) : ?>
    <div class="single-post-featured">
        <?php the_post_thumbnail('deartbox-featured'); ?>
    </div>
<?php endif; ?>

<!-- Post Content -->
<section class="single-post-content">
    <div class="container">
        <article id="post-<?php the_ID(); ?>" <?php post_class('post-content'); ?>>
            <?php the_content(); ?>
        </article>

        <!-- Social Share -->
        <div class="social-share">
            <span class="social-share-label"><?php esc_html_e( 'Bagikan:', 'deartbox' ); ?></span>
            <div class="social-share-links">
                <a href="<?php echo esc_url( $share_links['facebook'] ); ?>" target="_blank" rel="noopener noreferrer" class="share-btn share-facebook" aria-label="Share on Facebook">
                    <?php deartbox_the_icon('facebook', 18); ?>
                </a>
                <a href="<?php echo esc_url( $share_links['twitter'] ); ?>" target="_blank" rel="noopener noreferrer" class="share-btn share-twitter" aria-label="Share on Twitter/X">
                    <?php deartbox_the_icon('x', 18); ?>
                </a>
                <a href="<?php echo esc_url( $share_links['linkedin'] ); ?>" target="_blank" rel="noopener noreferrer" class="share-btn share-linkedin" aria-label="Share on LinkedIn">
                    <?php deartbox_the_icon('linkedin', 18); ?>
                </a>
                <a href="<?php echo esc_url( $share_links['whatsapp'] ); ?>" target="_blank" rel="noopener noreferrer" class="share-btn share-whatsapp" aria-label="Share via WhatsApp">
                    <?php deartbox_the_icon('whatsapp', 18); ?>
                </a>
            </div>
        </div>

        <!-- Tags -->
        <?php
        $tags = get_the_tags();
        if ($tags) :
        ?>
            <div class="post-tags">
                <?php foreach ($tags as $tag) : ?>
                    <a href="<?php echo esc_url(get_tag_link($tag->term_id)); ?>">
                        #<?php echo esc_html($tag->name); ?>
                    </a>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>

        <!-- Post Navigation -->
        <nav class="post-navigation">
            <?php
            $prev_post = get_previous_post();
            $next_post = get_next_post();
            ?>
            
            <?php if ($prev_post) : ?>
                <a href="<?php echo esc_url(get_permalink($prev_post)); ?>" class="post-nav-link prev">
                    <span><?php deartbox_the_icon('arrow-left', 14); ?> Sebelumnya</span>
                    <strong><?php echo esc_html($prev_post->post_title); ?></strong>
                </a>
            <?php else : ?>
                <div class="post-nav-link prev empty"></div>
            <?php endif; ?>
            
            <?php if ($next_post) : ?>
                <a href="<?php echo esc_url(get_permalink($next_post)); ?>" class="post-nav-link next">
                    <span>Selanjutnya <?php deartbox_the_icon('arrow-right', 14); ?></span>
                    <strong><?php echo esc_html($next_post->post_title); ?></strong>
                </a>
            <?php endif; ?>
        </nav>

        <!-- Related Posts -->
        <?php
        $related = deartbox_related_posts(get_the_ID(), 3);
        if ($related->have_posts()) :
        ?>
            <section class="related-posts">
                <h3>Artikel Terkait</h3>
                <div class="posts-grid">
                    <?php while ($related->have_posts()) : $related->the_post(); ?>
                        <?php get_template_part('template-parts/content', 'card'); ?>
                    <?php endwhile; wp_reset_postdata(); ?>
                </div>
            </section>
        <?php endif; ?>

        <!-- Comments -->
        <?php
        if (comments_open() || get_comments_number()) :
            comments_template();
        endif;
        ?>
    </div>
</section>

<?php
endwhile;

get_footer();
