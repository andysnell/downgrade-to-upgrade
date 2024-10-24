<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;
use Rector\Set\ValueObject\DowngradeLevelSetList;

return RectorConfig::configure()
    ->withImportNames(true, true, false)
    ->withPaths([
        __DIR__ . '/src',
        __DIR__ . '/lib',
    ])->withSets([
        DowngradeLevelSetList::DOWN_TO_PHP_74,
    ]);
