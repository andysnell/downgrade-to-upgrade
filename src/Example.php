<?php

namespace AndySnell\DowngradeToUpgrade;

use GuzzleHttp\Psr7\Response;
use Psr\Http\Message\ResponseInterface;

class Example
{
    private \DateTimeInterface $datetime;

    public function __construct(?\DateTimeInterface $datetime = null)
    {
        $this->datetime = $datetime ?? new \DateTimeImmutable();
    }

    public function double($value): bool
    {
        return \is_real($value) || (\is_string($value) && \substr($value, 0, 1) === 'A');
    }

    public function nope(): void
    {
        throw new \RuntimeException('Go bye bye now');
    }

    public function respond(): ResponseInterface
    {
        return new Response();
    }

    public function __toString(): string
    {
        return "The time is " . $this->datetime->format(\DateTimeInterface::RFC3339);
    }
}
