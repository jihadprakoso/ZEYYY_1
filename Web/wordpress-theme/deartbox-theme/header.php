<?php
/**
 * Header template
 *
 * @package Deartbox
 */

if (!defined('ABSPATH')) {
    exit;
}

$main_site_url = deartbox_get_option('main_site_url', 'https://deartbox.com');
?>
<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="profile" href="https://gmpg.org/xfn/11">
    <?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>
<?php wp_body_open(); ?>

<div class="site-container">
    <header class="site-header" id="masthead">
        <div class="header-container">
            <!-- Logo -->
            <a href="<?php echo esc_url(home_url('/')); ?>" class="site-logo" rel="home">
                <?php if (has_custom_logo()) : ?>
                    <?php the_custom_logo(); ?>
                <?php else : ?>
                    <img src="<?php echo esc_url($main_site_url); ?>/assets/logo/deartbox-logo.svg" alt="<?php bloginfo('name'); ?>" width="40" height="40" class="brand-logo" data-logo-light="<?php echo esc_url($main_site_url); ?>/assets/logo/deartbox-logo.svg" data-logo-dark="<?php echo esc_url($main_site_url); ?>/assets/logo/deartbox-logo-dark.svg">
                <?php endif; ?>
                <div class="site-logo-text">
                    <?php bloginfo('name'); ?>
                    <span><?php bloginfo('description'); ?></span>
                </div>
            </a>

            <!-- Navigation -->
            <nav class="main-nav" id="site-navigation">
                <?php
                wp_nav_menu(array(
                    'theme_location' => 'primary',
                    'menu_class'     => 'nav-menu',
                    'container'      => false,
                    'fallback_cb'    => function() {
                        echo '<ul class="nav-menu">';
                        echo '<li><a href="' . esc_url(home_url('/')) . '">Blog</a></li>';
                        echo '</ul>';
                    },
                ));
                ?>
                
                <div class="nav-cta">
                    <!-- Theme Toggle -->
                    <button class="theme-toggle" id="themeToggle" aria-label="Toggle dark mode">
                        <span class="icon-sun"><?php deartbox_the_icon('sun'); ?></span>
                        <span class="icon-moon" style="display:none;"><?php deartbox_the_icon('moon'); ?></span>
                    </button>
                    
                    <!-- Back to Main Site -->
                    <a href="<?php echo esc_url($main_site_url); ?>" class="btn-back-main">
                        <?php deartbox_the_icon('arrow-left', 16); ?>
                        Kembali ke Website
                    </a>
                </div>
            </nav>

            <!-- Mobile Toggle -->
            <button class="mobile-toggle" id="mobileToggle" aria-label="Toggle menu" aria-expanded="false">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </header>

    <main class="site-main" id="main">
