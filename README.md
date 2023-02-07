
![github-banner](https://user-images.githubusercontent.com/7218230/191119628-4d39c65d-465f-4011-9370-d53d7b54d8cc.png)

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Uffizzi - Open-source Preview Environments

#### Don't merge until you preview

Uffizzi is a tool that lets you preview pull requests before merging. Create on-demand Preview Environments for APIs, frontends, backends, databases, microservices, binaries and command-line tools. Each Preview Environment gets a secure HTTPS URL that is continually refreshed when you push new commits. Uffizzi also handles clean up, so your environments last only as long as you need them.  

Uffizzi is an open-source, off-the-shelf, cross-platform solution that works with any version control system, container registry, or CI platform.

<img width="600" alt="preview-url" src="https://user-images.githubusercontent.com/7218230/194924634-391aff82-8adf-473b-800e-a20dcdab82dd.png">

## Give us a star ⭐️
If you're interested in Uffizzi, give us a star. It helps others discover the project.

## Quickstart (~1 minute)

Go to the [`quickstart` repo](https://github.com/UffizziCloud/quickstart#uffizzi-quickstart--1-minute), then follow the instructions in the `README` to create a Preview Environment for a sample application.

## Use cases

Uffizzi is designed to integrate with any CI platform as a step in your pipeline. You can use Uffizzi to rapidly create:  

- Pull request environments  
- Debugging environments  
- Hotfix environments  
- Demo environments  
- Release environments
- Staging environments  

## What types of apps are supported by Uffizzi?

Uffizzi is designed for full-stack web applications and containerized services, including APIs, backends, frontends, databases, microservices, binaries and command line tools . Currently, application configurations must be defined via Docker Compose. Support for Helm and other configuration formats are on our [public roadmap](https://github.com/orgs/UffizziCloud/projects/2/views/1?layout=board). See [Docker Compose for Uffizzi ](https://docs.uffizzi.com/references/compose-spec/) to learn more about supported syntax.

## Why Uffizzi?

Uffizzi helps busy project leaders approve pull requests faster. Testing a live preview provides a more holistic way to assess a new feature or bug fix, rather than simply reviewing code changes. Uffizzi also removes the added step of pulling down the branch to test it locally: Uffizzi seamlessly integrates with CI providers like GitHub Actions and posts comments directly to pull request issues, so there is no additional step for the maintainer or the contributor.

## Project roadmap

See our high-level [project roadmap](https://github.com/orgs/UffizziCloud/projects/2/views/1?layout=board), including already delivered milestones.

## Set up Preview Environments for your application

(If you haven't completed the [quickstart guide](https://github.com/UffizziCloud/quickstart), we recommend starting there to understand how Uffizzi works and how it's configured.)  

There are two options to get Uffizzi:  

1. **Use [Uffizzi Cloud](https://uffizzi.com) (SaaS)** - This is fastest and easiest way to get started and includes two free concurrent Preview Environments for your team. It also includes some premium options like single sign-on (SSO) and password-protected preview URLs. If you want to use Uffizzi Cloud, you can follow this [step-by-step guide](https://docs.uffizzi.com/set-up-uffizzi-for-your-application) to configure Preview Environments for your own application.  

2. **Install open-source Uffizzi on your own Kubernetes cluster** - Alternatively, you can install Uffizzi on your own cluster by following the [self-hosted installation guide](INSTALL.md).

## Documentation

- [Main documentation](https://docs.uffizzi.com)
- [Docker Compose for Uffizzi ](https://docs.uffizzi.com/references/compose-spec/)
- [Quickstart guide](https://github.com/UffizziCloud/quickstart)

## Community

- [Slack channel](https://join.slack.com/t/uffizzi/shared_invite/zt-ffr4o3x0-J~0yVT6qgFV~wmGm19Ux9A) - Get support or discuss the project  
- [Subscribe to our newsletter](http://eepurl.com/hsws0b) - Receive monthly updates about new features and special events  
- [Contributing to Uffizzi](CONTRIBUTING.md) - Start here if you want to contribute
- [Code of Conduct](CODE_OF_CONDUCT.md) - Let's keep it professional

## FAQs

<details><summary><b>My team tests locally. Why do I need Preview Environments?</b></summary>
<ol>
  <li>Preview Environments more closely resemble production. Uffizzi deploys images built from your CI pipeline—similar to the ones deployed to a production environment. Uffizzi Preview Environments also include a full network stack, including a domain and TLS certificate.</li>
  <li>Preview Environments provide a quality gate to help keep dirty code out of your main branch. Teams can test new features or bug fixes in clean, isolated environments.</li>
  <li>Public preview URLs allow every stakeholder on a team to review features and bug fixes. This helps shorten the feedback loop between developer and reviewer/tester, resulting in faster releases.</li>
</ol>
</details>

<details><summary><b>How is Uffizzi different from Codespaces, Gitpod, etc.?</b></summary>
<p>Codespaces, Gitpod, and similar tools provide development environments hosted in the cloud. They let you open code editors like VS Code in your browser and make it easy to standardize development environments for your whole team. They can also provide developers access to more powerful machines than typically available on a laptop or desktop.</p>

<p>Uffizzi, by contrast, is downstream of these tools—i.e., Uffizzi Preview Environments are intended to be used once your code is ready for review. When added to your CI pipeline, Uffizzi will create a Preview Environment after a pull request is opened. Uffizzi works with whatever development method you choose—whether local or with cloud-based development environments like Gitpod or Codespaces.</p>

<p>Uffizzi is most useful for peer review, team leaders, QA, or anyone testing branches before they're merged with a shared branch such as main or master. </p>
</details>

<details><summary><b>How is Uffizzi different from GitHub Actions (or other CI providers)?</b></summary>
Uffizzi does not replace GitHub Actions or any other CI provider. Uffizzi previews are meant to be added as a step in your existing CI pipeline, after your container images are built and pushed to a container registry.
</details>

<details><summary><b>What about my database?</b></summary>
<p>All services defined by your Docker Compose file are deployed to Preview Environments as containers—this includes databases, caches, and other datastores. This means that even if you use a managed database service like Amazon RDS for production, you should use a database <i>image</i> in your Compose (See <a href="https://github.com/UffizziCloud/quickstart/blob/fc0afa8c7b62c342bdf5fda8f5dc5b25c7a23dab/docker-compose.uffizzi.yml#L14-L23">this example</a> that uses a <code>postgres</code> image from Docker Hub).</p>

<p>If your application requires test data, you will need to seed your database when your Preview Environment is created. Here are two methods for seeding databases:</p>
<ol>
  <li>Load an SQL dump file upon container initialization.</li>
  <li>Use a language/framework-specific migration tool such as <code>db:migrate</code> for Rails or <code>manage.py loaddata</code> for Django.</li>
</ol>  

<a href="https://www.uffizzi.com/preview-environments-guide/database-seeding">Learn more about database seeding in Uffizzi</a>
</details>

<details><summary><b>What do you mean by "environments"?</b></summary>
Uffizzi Preview Environments are deployed upon Kubernetes. Uffizzi performs a translation from Compose to Kubernetes, where your application is deployed as a Pod to an isolated Namespace within a cluster. This abstraction helps reduce a team's infrastructure footprint and associated overhead. Uffizzi also creates a unique hostname for each Preview Environment and provision a TLS certificate. Each Preview Environment exposes one socket that can receive HTTP traffic. Every container defined by your Compose can communicate with each other on an internal network via <code>localhost</code>. Application instances that belong to different Preview Environments may only communicate via the public Internet. See the <a href="./INSTALL.md">self-hosted installation guide</a> for more architecture details.
</details>

<details><summary><b>Does Uffizzi support monorepos/polyrepos?</b></summary>
Yes. Your CI pipeline will typically include a series of <code>build</code>/<code>push</code> steps for each of the components of your application. Uffizzi just needs to know the fully qualified container registry URL for where to find these built images.
</details>

<details><summary><b>Does Uffizzi support _____________?</b></summary>
Uffizzi is container-centric, so in general, if your application can be containerized, described with Docker Compose, and accepts HTTP traffic, Uffizzi can preview it. Uffizzi supports web applications, microservices, databases, binaries, and command-line tools.
</details>

<details><summary><b>How can my application services communicate?</b></summary>
Just like when you run <code>docker-compose up</code> locally, all the <code>services</code> defined in your Compose share a local network and can communicate via <code>localhost</code>. Application instances that belong to different Preview Environments may only communicate via the public Internet.
</details>

<details><summary><b>Can I connect Uffizzi with Netlify/Vercel?</b></summary>
Yes. While Uffizzi supports full-stack previews, some users who already leverage frontend platforms like <a href="https://www.netlify.com">Netlify</a> or <a href="https://vercel.com">Vercel</a> want to add Uffizzi previews for their APIs/backend. For help configuring this scenario see:  
<ul>
  <li><a href="https://github.com/UffizziCloud/netlify-uffizzi-previews">Netlify + Uffizzi</a></li>  
  <li><a href="https://github.com/UffizziCloud/foodadvisor">Vercel + Uffizzi</a></li>
</ul>
</details>

<details><summary><b>Is Uffizzi open source?</b></summary>
Yes. If you have access to a Kubernetes cluster, you can install Uffizzi via Helm. Follow the <a href="INSTALL.md">self-hosted installation guide</a>.
</details>

## License

This library is licensed under the [Apache License, Version 2.0](LICENSE).

## Security

If you discover a security related issues, please do **not** create a public github issue. Notify the Uffizzi team privately by sending an email to `security@uffizzi.com`.
