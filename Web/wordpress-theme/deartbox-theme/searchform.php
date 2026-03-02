<?php
/**
 * Search form template
 *
 * @package Deartbox
 */
?>

<form role="search" method="get" class="search-form" action="<?php echo esc_url(home_url('/')); ?>">
    <label class="sr-only" for="search-field"><?php _e('Search for:', 'deartbox'); ?></label>
    <input type="search" id="search-field" class="search-field" placeholder="<?php esc_attr_e('Cari artikel...', 'deartbox'); ?>" value="<?php echo get_search_query(); ?>" name="s">
    <button type="submit" class="search-submit">
        <?php deartbox_the_icon('search', 18); ?>
        <span class="sr-only"><?php _e('Search', 'deartbox'); ?></span>
    </button>
</form>
