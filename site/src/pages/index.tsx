import type {ReactNode} from 'react';
import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Translate, {translate} from '@docusaurus/Translate';
import Layout from '@theme/Layout';
import Heading from '@theme/Heading';

import styles from './index.module.css';

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero hero--primary', styles.heroBanner)}>
      <div className="container">
        <Heading as="h1" className="hero__title">
          {siteConfig.title}
        </Heading>
        <p className="hero__subtitle">
          <Translate
            id="homepage.tagline"
            description="Hero subtitle on the homepage">
            OpenTelemetry-compatible structured logging for the dagstack ecosystem — severity, sinks, context propagation, redaction, AI-agent observability. One contract for Python, TypeScript, Go.
          </Translate>
        </p>
        <div className={styles.buttons}>
          <Link
            className="button button--secondary button--lg"
            to="/docs/intro">
            <Translate
              id="homepage.getStarted"
              description="Homepage CTA button label">
              Get started in 5 minutes
            </Translate>
          </Link>
        </div>
      </div>
    </header>
  );
}

export default function Home(): ReactNode {
  const {siteConfig} = useDocusaurusContext();
  const description = translate({
    id: 'homepage.tagline',
    message:
      'OpenTelemetry-compatible structured logging for the dagstack ecosystem — severity, sinks, context propagation, redaction, AI-agent observability. One contract for Python, TypeScript, Go.',
    description: 'Hero subtitle on the homepage',
  });
  return (
    <Layout title={siteConfig.title} description={description}>
      <HomepageHeader />
    </Layout>
  );
}
