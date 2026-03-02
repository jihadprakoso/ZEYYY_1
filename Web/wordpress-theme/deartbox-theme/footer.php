<?php
/**
 * Footer template
 *
 * @package Deartbox
 */

if (!defined('ABSPATH')) {
    exit;
}

$main_site_url = deartbox_get_option('main_site_url', 'https://deartbox.com');
$phone = deartbox_get_option('contact_phone', '+62 819-5181-427');
$email = deartbox_get_option('contact_email', 'deartboxpackaging@gmail.com');
$address = deartbox_get_option('contact_address', 'Jl. Gandaria 1 No. 3, Gandaria Utara, Jakarta Selatan 12130');

// Social links
$instagram = deartbox_get_option('social_instagram', 'https://www.instagram.com/de_artbox');
$linkedin = deartbox_get_option('social_linkedin', 'https://www.linkedin.com/in/deartbox-packaging-b08696376/');
$youtube = deartbox_get_option('social_youtube', 'https://www.youtube.com/@deartboxPackaging-p6y');
$facebook = deartbox_get_option('social_facebook', 'https://www.facebook.com/people/Deartbox-Packaging/pfbid0XNX5tqGV4kKzkamBUK18YBJewpPDgnXJM3NCLWhu1T8KL5b1F4h3miUYdZXtd854l/');
?>

    </main><!-- #main -->

    <footer class="site-footer" id="colophon">
        <div class="container">
            <div class="footer-grid">
                <!-- Brand Column -->
                <div class="footer-brand">
                    <a href="<?php echo esc_url($main_site_url); ?>" class="footer-logo">
                        <img src="<?php echo esc_url($main_site_url); ?>/assets/logo/deartbox-logo-dark.svg" alt="deartbox" width="40" height="40">
                        <div>
                            <strong>deartbox Packaging</strong>
                            <span style="display:block;font-size:11px;opacity:0.7;">Box Anda, Misi Kami.</span>
                        </div>
                    </a>
                    <p>Produsen hardbox premium untuk brand Indonesia. Mitra produksi packaging custom yang tepercaya.</p>
                    
                    <div class="footer-social">
                        <?php if ($instagram) : ?>
                            <a href="<?php echo esc_url($instagram); ?>" target="_blank" rel="noopener noreferrer" aria-label="Instagram">
                                <?php deartbox_the_icon('instagram'); ?>
                            </a>
                        <?php endif; ?>
                        
                        <?php if ($linkedin) : ?>
                            <a href="<?php echo esc_url($linkedin); ?>" target="_blank" rel="noopener noreferrer" aria-label="LinkedIn">
                                <?php deartbox_the_icon('linkedin'); ?>
                            </a>
                        <?php endif; ?>
                        
                        <?php if ($youtube) : ?>
                            <a href="<?php echo esc_url($youtube); ?>" target="_blank" rel="noopener noreferrer" aria-label="YouTube">
                                <?php deartbox_the_icon('youtube'); ?>
                            </a>
                        <?php endif; ?>
                        
                        <?php if ($facebook) : ?>
                            <a href="<?php echo esc_url($facebook); ?>" target="_blank" rel="noopener noreferrer" aria-label="Facebook">
                                <?php deartbox_the_icon('facebook'); ?>
                            </a>
                        <?php endif; ?>
                    </div>
                </div>

                <!-- Quick Links -->
                <div class="footer-column">
                    <h4>Website Utama</h4>
                    <ul class="footer-links">
                        <li><a href="<?php echo esc_url($main_site_url); ?>/#features">Keunggulan</a></li>
                        <li><a href="<?php echo esc_url($main_site_url); ?>/#showcase">Portofolio</a></li>
                        <li><a href="<?php echo esc_url($main_site_url); ?>/#process">Proses</a></li>
                        <li><a href="<?php echo esc_url($main_site_url); ?>/#testimonials">Testimoni</a></li>
                        <li><a href="<?php echo esc_url($main_site_url); ?>/#contact">Kontak</a></li>
                    </ul>
                </div>

                <!-- Blog Links -->
                <div class="footer-column">
                    <h4>Blog</h4>
                    <ul class="footer-links">
                        <li><a href="<?php echo esc_url(home_url('/')); ?>">Semua Artikel</a></li>
                        <?php
                        $categories = get_categories(array('number' => 5));
                        foreach ($categories as $category) :
                        ?>
                            <li><a href="<?php echo esc_url(get_category_link($category->term_id)); ?>"><?php echo esc_html($category->name); ?></a></li>
                        <?php endforeach; ?>
                    </ul>
                </div>

                <!-- Contact Info -->
                <div class="footer-column">
                    <h4>Hubungi Kami</h4>
                    <ul class="footer-links">
                        <?php if ($address) : ?>
                            <li>
                                <a href="https://www.google.com/maps?q=<?php echo urlencode($address); ?>" target="_blank" rel="noopener noreferrer">
                                    <?php echo esc_html($address); ?>
                                </a>
                            </li>
                        <?php endif; ?>
                        
                        <?php if ($phone) : ?>
                            <li>
                                <a href="tel:<?php echo esc_attr(preg_replace('/[^0-9+]/', '', $phone)); ?>">
                                    <?php echo esc_html($phone); ?>
                                </a>
                            </li>
                        <?php endif; ?>
                        
                        <?php if ($email) : ?>
                            <li>
                                <a href="mailto:<?php echo esc_attr($email); ?>">
                                    <?php echo esc_html($email); ?>
                                </a>
                            </li>
                        <?php endif; ?>
                    </ul>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; <?php echo date('Y'); ?> deartbox Packaging — Bagian dari PT. Xerography Indonesia. Hak cipta dilindungi.</p>
            </div>
        </div>
    </footer>

    <!-- Sticky CTA -->
    <a href="https://wa.me/628195181427?text=<?php echo urlencode('Halo deartbox, saya tertarik untuk konsultasi hardbox premium'); ?>" class="sticky-cta" aria-label="Chat via WhatsApp" target="_blank" rel="noopener noreferrer">
        <?php deartbox_the_icon('whatsapp'); ?>
        <span class="sticky-cta-text">Chat Sekarang</span>
    </a>

</div><!-- .site-container -->

<?php wp_footer(); ?>
</body>
</html>
