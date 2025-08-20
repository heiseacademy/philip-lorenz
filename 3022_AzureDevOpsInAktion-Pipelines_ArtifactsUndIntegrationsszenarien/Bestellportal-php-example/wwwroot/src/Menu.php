<?php
namespace MahlzeitExpress;

class Menu
{
    private array $meals;

    public function __construct()
    {
        $this->meals = [
            ['id' => 1, 'name' => 'Vegetarische Bowl',  'description' => 'Reis, Gemüse, Tofu',                   'price' => 8.50],
            ['id' => 2, 'name' => 'Hähnchen Wrap',      'description' => 'Wrap mit Hähnchen, Salat, Sauce',      'price' => 7.90],
            ['id' => 3, 'name' => 'Lachs mit Gemüse',    'description' => 'Lachsfilet, Brokkoli, Karotten',       'price' => 12.00],
            ['id' => 4, 'name' => 'Veganer Salat',       'description' => 'Quinoa, Avocado, Kichererbsen',        'price' => 9.20],
            ['id' => 5, 'name' => 'Beef Burger',         'description' => 'Rindfleisch, Käse, BBQ-Sauce',          'price' => 10.50],
            ['id' => 6, 'name' => 'Pasta Carbonara',     'description' => 'Spaghetti, Speck, Sahnesoße, Parmesan', 'price' => 11.00],
            ['id' => 7, 'name' => 'Thai Curry Red',          'description' => 'Rotes Curry mit Kokosmilch und Gemüse', 'price' => 10.80],
            ['id' => 8, 'name' => 'Caesar Salad',        'description' => 'Römersalat, Croutons, Caesar-Dressing', 'price' => 8.90],
            ['id' => 9, 'name' => 'CheeseBurger',        'description' => 'Käse, Salat, Tomate', 'price' => 9.90],
        ];
    }

    public function getMeals(): array
    {
        return $this->meals;
    }

    public function getMealById(int $id): ?array
    {
        foreach ($this->meals as $meal) {
            if ($meal['id'] === $id) {
                return $meal;
            }
        }
        return null;
    }
}
