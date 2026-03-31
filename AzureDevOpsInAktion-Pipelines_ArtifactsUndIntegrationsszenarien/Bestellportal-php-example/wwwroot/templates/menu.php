<section class="menu-section">
  <h2>Unsere Speisekarte</h2>
  <div class="menu-grid">
    <?php foreach ($meals as $meal): ?>
    <article class="meal-card">
      <div class="meal-card-content">
        <h3><?= htmlspecialchars($meal['name']) ?></h3>
        <p><?= htmlspecialchars($meal['description']) ?></p>
        <p class="price">€<?= number_format($meal['price'],2,',','.') ?></p>
      </div>
      <form action="order.php" method="post" class="order-form">
        <input type="hidden" name="meal_id" value="<?= $meal['id'] ?>">
        <input type="text"   name="customer_name" placeholder="Ihr Name"      required>
        <input type="text"   name="address"       placeholder="Lieferadresse" required>
        <button type="submit">Jetzt bestellen</button>
      </form>
    </article>
    <?php endforeach; ?>
  </div>
</section>
