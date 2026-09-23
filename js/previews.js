// Autoplay only visible previews, respecting reduced motion and user pause.
(() => {
  const videos = [...document.querySelectorAll('.flight-video')];
  const toggle = document.querySelector('.preview-toggle');
  const motion = window.matchMedia('(prefers-reduced-motion: reduce)');
  const visible = new Set();
  let paused = motion.matches;
  function updateButton() {
    if (!toggle) return;
    toggle.hidden = false;
    toggle.textContent = paused ? 'Play previews' : 'Pause previews';
    toggle.setAttribute('aria-pressed', String(paused));
  }
  function update(video) {
    if (paused || document.hidden || !visible.has(video)) video.pause();
    else { video.muted = true; video.play().catch(() => { /* Native controls remain available. */ }); }
  }
  if (!('IntersectionObserver' in window)) return; // Native controls work without JS.
  const observer = new IntersectionObserver(entries => {
    for (const entry of entries) {
      if (entry.isIntersecting) visible.add(entry.target);
      else visible.delete(entry.target);
      update(entry.target);
    }
  }, { threshold: 0.25 });
  videos.forEach(video => { video.muted = true; observer.observe(video); });
  toggle?.addEventListener('click', () => {
    paused = !paused;
    updateButton();
    videos.forEach(update);
  });
  motion.addEventListener('change', () => {
    paused = motion.matches;
    updateButton();
    videos.forEach(update);
  });
  document.addEventListener('visibilitychange', () => videos.forEach(update));
  updateButton();
})();
