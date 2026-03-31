<section class="order-section">
  <?php if ($orderSuccess && $selectedMeal): ?>
    <div class="order-success">
      <h2>Danke, <?= htmlspecialchars($orderDetails['customerName']) ?>!</h2>
      <p>Dein <strong><?= htmlspecialchars($selectedMeal['name']) ?></strong> 
         wird an <strong><?= htmlspecialchars($orderDetails['address']) ?></strong> geliefert.</p>
    </div>
  <?php else: ?>
    <div class="order-fail">
      <h2>Ups!</h2>
      <p>Da ist etwas schiefgelaufen. Bitte versuche es noch einmal.</p>
    </div>
  <?php endif; ?>
</section>
