<?php
/**
 * Template part for displaying post cards
 *
 * @package Deartbox
 */

$category = deartbox_first_category();
$reading_time = deartbox_reading_time();
?>

<article id="post-<?php the_ID(); ?>" <?php post_class('post-card'); ?>>
    <!-- Thumbnail -->
    <div class="post-card-thumbnail">
        <?php if (has_post_thumbnail()) : ?>
            <a href="<?php the_permalink(); ?>">
                <?php the_post_thumbnail('deartbox-card', array('alt' => get_the_title())); ?>
            </a>
        <?php else : ?>
            <a href="<?php the_permalink(); ?>">
                <img src="<?php echo esc_url(get_template_directory_uri()); ?>/assets/images/placeholder.jpg" alt="<?php the_title_attribute(); ?>">
            </a>
        <?php endif; ?>
        
        <?php if ($category) : ?>
            <a href="<?php echo esc_url(get_category_link($category->term_id)); ?>" class="post-card-category">
                <?php echo esc_html($category->name); ?>
            </a>
        <?php endif; ?>
    </div>

    <!-- Content -->
    <div class="post-card-content">
        <div class="post-card-meta">
            <span class="date">
                <?php deartbox_the_icon('calendar', 14); ?>
                <?php echo get_the_date(); ?>
            </span>
            <span class="reading-time">
                <?php deartbox_the_icon('clock', 14); ?>
                <?php echo $reading_time; ?> min
            </span>
        </div>

        <h2 class="post-card-title">
            <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
        </h2>

        <p class="post-card-excerpt">
            <?php echo wp_trim_words(get_the_excerpt(), 20, '...'); ?>
        </p>

        <a href="<?php the_permalink(); ?>" class="post-card-link">
            Baca Selengkapnya
            <?php deartbox_the_icon('arrow-right', 16); ?>
        </a>
    </div>
</article>
