document.addEventListener('DOMContentLoaded', function() {
  const grid = document.querySelector('.image-grid');
  if (!grid) return;
  
  const items = Array.from(grid.children);
  
  items.forEach((item, index) => {
    if (Math.random() < 0.3) {  // 30% chance
      const spacer = document.createElement('div');
      spacer.className = 'grid-spacer';
      item.after(spacer);
    }
  });
});
