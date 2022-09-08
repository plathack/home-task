<?php

class Finance
{
    private float $balance = 0.0;

    private $describe;

    public function __construct($amount)
    {
        $this->balance = $amount;

        $this->describe = "$this->balance";
    }

    public function add(Finance $finance)
    {
        $financeCopy = clone $this;

        $financeCopy->balance += $finance->balance;

        $financeCopy->describe = "(" . $financeCopy->describe . " + $finance->balance)";

        return $financeCopy;
    }

    public function subtract(Finance $finance)
    {
        $financeCopy = clone $this;

        $financeCopy->balance -= $finance->balance;

        $financeCopy->describe = "(" . $financeCopy->describe . " - $finance->balance)";

        return $financeCopy;
    }

    public function asFloat()
    {
        return $this->balance;
    }

    public function describe()
    {
        return $this->describe;
    }
}

function Money($amount)
{
    return new Finance($amount);
}

$a = Money(10.0)->add(Money(20.0))->subtract(Money(5.0));
$b = Money(40.0)->subtract($a->subtract(Money(3.0)));
echo $a->asFloat() . PHP_EOL; // 25.0
echo $a->describe() . PHP_EOL; // ((10 + 20) – 5)
echo $b->asFloat() . PHP_EOL; // 18.0
echo $b->describe() . PHP_EOL; // (40.0 – (((10 + 20) - 5) – 3))
