<?php

use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use \Doctrine\ORM\EntityManager;
use \JobeetBundle\Entity\Job;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context, SnippetAcceptingContext
{
    /**
     * @var EntityManager
     */
    protected $em;
    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct(EntityManager $entityManager)
    {
        $this->em = $entityManager;
    }

    /**
     * @Given I have a new job with the details:
     */
    public function iHaveANewJobWithTheDetails(TableNode $table)
    {
        $job = new Job();

        foreach ($table->getRowsHash() as $key => $value)
        {
            $setter = $this->createSetterFromKey($key);

            $job->$setter($value);
        }

        $this->em->persist($job);
        $this->em->flush($job);
    }

    /**
     * @BeforeScenario @fixtures
     */
    public function cleanDatabase()
    {
        // @todo include doctrine fixtures and use orm purger to ensure database is clean before this scenario
    }

    /**
     * @param string $key
     *
     * @return string
     */
    protected function createSetterFromKey($key)
    {
        return sprintf("set%s", ucfirst($key));
    }
}
