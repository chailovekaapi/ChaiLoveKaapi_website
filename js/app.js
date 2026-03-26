document.addEventListener('DOMContentLoaded', () => {
    // Glass Nav Scroll Effect
    const nav = document.querySelector('.glass-nav');
    window.addEventListener('scroll', () => {
        nav.classList.toggle('scrolled', window.scrollY > 50);
    });

    // Mobile Menu Toggle
    const menuBtn = document.querySelector('.mobile-menu-btn');
    const navLinks = document.querySelector('.nav-links');

    if (menuBtn && navLinks) {
        menuBtn.addEventListener('click', () => {
            navLinks.classList.toggle('active');
        });
    }

    // Modal Logic (For Menu items)
    const modal = document.getElementById('menuModal');
    const closeBtn = document.querySelector('.close-modal');
    const menuCards = document.querySelectorAll('.menu-card');

    if (modal && closeBtn) {
        menuCards.forEach(card => {
            card.addEventListener('click', () => {
                const title = card.getAttribute('data-title');
                const desc = card.getAttribute('data-desc');
                const img = card.getAttribute('data-img');

                document.getElementById('modalTitle').textContent = title;
                document.getElementById('modalDesc').textContent = desc;
                document.getElementById('modalImg').src = img;

                modal.style.display = 'flex';
                // Trigger reflow for animation
                modal.offsetHeight;
                modal.classList.add('visible');
            });
        });

        const closeModal = () => {
            modal.classList.remove('visible');
            setTimeout(() => {
                modal.style.display = 'none';
            }, 300); // match CSS transition duration
        };

        closeBtn.addEventListener('click', closeModal);
        window.addEventListener('click', (e) => {
            if (e.target === modal) {
                closeModal();
            }
        });
    }
});
