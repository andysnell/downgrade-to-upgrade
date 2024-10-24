<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;

return RectorConfig::configure()
    ->withImportNames(true, true, false)
    ->withPaths([
        __DIR__ . '/src',
        __DIR__ . '/lib',
    ])->withPhpSets();
