<?php
namespace MahlzeitExpress;

class Order
{
    private int $mealId;
    private string $customerName;
    private string $address;

    public function __construct(int $mealId, string $customerName, string $address)
    {
        $this->mealId      = $mealId;
        $this->customerName = $customerName;
        $this->address      = $address;
    }

    public function save(): bool
    {
        // Hier würde in Echt ein DB-Insert oder API-Call stehen
        return true;
    }

    public function getDetails(): array
    {
        return [
            'mealId'       => $this->mealId,
            'customerName' => $this->customerName,
            'address'      => $this->address,
        ];
    }
}
