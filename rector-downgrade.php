<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;
use Rector\Set\ValueObject\DowngradeLevelSetList;

return static function (RectorConfig $config): void {
    $config->importNames(true);
    $config->importShortClasses(false);

    $config->paths([
        __DIR__ . '/src',
        __DIR__ . '/lib',
    ]);

    $config->sets([
        DowngradeLevelSetList::DOWN_TO_PHP_74
    ]);
};
