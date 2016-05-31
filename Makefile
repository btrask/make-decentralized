# make decentralized
# Ben Trask <https://bentrask.com>
# May 2016
# License: CC0
# 
# Like every Makefile, this document forms a dependency graph. Unlike an
# ordinary Makefile, there are two ways to process this one:
#   1. Start with a goal, and process its dependencies recursively.
#   2. Cheat: break an assumption that necessitates the dependencies in the
#      first place.
# After all, no one can tell you how to invent something until after the fact.
# 
# The dependencies listed here are intended to be reasonable, not absolute.
# 
# If you don't remember Makefile syntax:
# 
# - The term before a colon is a goal
# - The terms after a colon are the dependencies of the goal
# - The following lines are instructions for building the goal
# 
# The instructions herein may not be machine-readable. :)
#
# If you're interested in contributing to this document, pull requests
# are welcome: https://github.com/btrask/make-decentralized
# 
# Other documents:
# 
# - Locking the Web Open: A Call for a Distributed Web
#   <http://brewster.kahle.org/2015/08/11/locking-the-web-open-a-call-for-a-distributed-web-2/>
# - The internet has been stolen from you. Take it back, nonviolently.
#   <https://medium.com/@flyingzumwalt/the-internet-has-been-stolen-from-you-take-it-back-nonviolently-248f8d445b87>
# - Why Decentralized?
#   <http://www.decentralizedweb.net/learn-more/>

###

decentralized: web other-goals

web: web-apps zeronet dns public-key-infrastructure cloudflare \
     web-pages web-browsers deployment

###

web-apps: porting-effort facebook twitter \
           wordpress wayback-machine google github \
           other-apps
	# So far, a lot of the effort on decentralizing the web has focused
	# on writing new applications from scratch. Greenfield projects are
	# fun and exciting, but it's hard to build a new ecosystem from
	# scratch. Our primary interest is in decentralization, not in any
	# particular application domain, so the apps we write are bound to
	# be worse than apps by people who are focused on their one domain
	# above all else. Many applications are so large and established that
	# trying to compete with them would be suicide even if we weren't
	# doing it on a new and unproven platform. It can be difficult to
	# tell what the requirements of the applications are and whether the
	# platform is meeting them when both are in flux (and that's why
	# many decentralized platforms are failing to meet application
	# requirements like strong-consistency or low-latency). When you
	# couple several unproven ideas together, the risk grows
	# exponentially.
	# 
	# This is why I believe porting existing applications, starting from
	# simple open source projects and gradually building steam, is so
	# important. My vision of our success is a web that sucks just as
	# much as the web we have today, except in one way: that it's no
	# longer centralized. Then we can start working on the other problems.

porting-effort: stack-overflow deployment
	# Porting large, often "legacy" software projects isn't sexy.
	# But think about this: if a decentralization platform were
	# built well enough that porting existing apps en masse felt
	# feasible and rewarding, there are a lot of programmers who
	# might get excited about porting an app or two. Look at how
	# mobile apps were doing for like five years. That's the level
	# of adoption we need to aim for (so that it's okay if we
	# fall a little bit short).
	# 
	# Almost all existing web apps have a sever-side component
	# that must be taken into account. Deployment and ideally
	# sandboxing are big issues.

stack-overflow: sql filesystem
	# If we want to move to a world where new and existing applications
	# are built "decentralized-first," we need to solve the Stack
	# Overflow problem. When programmers turn to SO to find out how to
	# query a database or copy and paste some snippet of code, we need
	# all of the examples to show the decentralized way of doing things.
	# For that to happen, there are basically two options:
	#   1. Update all of the answers on Stack Overflow with new APIs
	#      and protocols and make everyone relearn everything.
	#   2. Build decentralized platforms that are bug-compatible with
	#      existing software stacks.
	# Obviously, neither of these options will be easy, but I believe
	# that backward compatibility almost always wins.

###

# These goals are too ambitious to be worth thinking about for the
# time being. We can tackle them once we do everything else.
# 
# Even if we never make a mark on Facebook or Twitter, our efforts will
# still be worthwhile.

facebook: decentralized
	# Unresolved circular dependency

twitter: decentralized
	# Unresolved circular dependency

###

wordpress: mysql web-pages
	# https://make.wordpress.org/core/handbook/
	# WordPress runs 25% of all websites.[1] If you want to talk about
	# decentralizing the web, you need to talk about WordPress.
	# 
	# There are basically two approaches to decentralizing WordPress.
	# You could decentralize it as an application, which means
	# letting people run their own copies locally, while synchronizing
	# the application state (mostly kept in MySQL) somehow. This
	# further subdivides into approaches that are WordPress-specific
	# (such as porting WordPress to an eventually consistent
	# datastore), versus approaches that are more general (such as
	# creating a decentralized MySQL).
	# 
	# Alternatively, you could just find a way to decentralize
	# static web pages, and treat WordPress as a static-site generator.
	# Handling comments and other interactive features and plugins
	# this way might be difficult. Cheating like this might help for
	# blog platforms, but it falls down quickly for other web apps.
	# 
	# If we want to port WordPress to a decentralized datastore,
	# perhaps we could get some support by starting with porting it
	# to PostgreSQL, adding a proper database abstraction layer.
	# This is plausible because there is already pent-up demand for
	# Postgres support. Plug-ins might be an issue.
	# 
	# [1] https://w3techs.com/blog/entry/wordpress-powers-25-percent-of-all-websites

wayback-machine: web-pages web-page-hashing
	# https://web.archive.org
	# Along with WordPress, the Wayback Machine is a promising and
	# high-value target for our initial decentralization efforts.
	# We also appear to have the support of its developers, which is
	# fantastic!
	# 
	# Once you have a decentralized page host, there is very little
	# left for a Wayback Machine to do. The hardest part is probably
	# ingesting new pages: if you'd like to allow user submissions,
	# you need a way to reasonably prove the user got the archive
	# from the site they say they did, at the time they claim. As far
	# as I understand, TLS doesn't help with this, unfortunately.
	# 
	# One solution is to only accept archives from a list of trusted
	# archivists, but that's not very decentralized.
	# 
	# The only other solution I'm aware of is what I call "trustless
	# decentralized archiving," where you just try to ensure that
	# other people can reproduce a given page archive by stripping
	# all of the irreproducible parts of it (perhaps by loading a page
	# several times and computing an "average"), and then allowing
	# various parties to cryptographically sign the result. Such a
	# system requires a large number of users to get any reasonable
	# corroboration.

google: web-pages
	# https://www.google.com
	# In order to index data, you need to access it. That means that
	# storing data and searching it are intrinsically linked (no pun
	# intended). That means that if we can decentralize static webpage
	# hosting, then decentralized search is relatively easy. No
	# crawling necessary.
	# 
	# I believe that keeping Google in our corner is an important
	# long-term strategy. That means not trying to kill them (are
	# you feeling lucky?) and using the carrot more than the stick.
	# Note how Mozilla has faired after trying their luck with Yahoo.
	# The decentralized web will still need a great search engine,
	# just like we're not putting the Internet Archive out of
	# business either. That said, it's not healthy for us to be
	# entirely dependent on handouts.
	# 
	# Google has published some information on many of its distributed
	# systems, including GFS[1], Spanner[2], and Chubby[3]. They can't
	# be copied directly, due to differences between intranet and
	# internet services, but they are still worth studying.
	# 
	# [1] http://research.google.com/archive/gfs.html
	# [2] http://research.google.com/archive/spanner.html
	# [3] http://research.google.com/archive/chubby.html

github: other-apps
	# https://github.com
	# It seems remarkable that a social network built on a decentralized
	# data-store (Git) has network effects just as strong as any other
	# social network. This should be a lesson of caution to any eager
	# would-be decentralizers.
	# 
	# Past attempts to decentralize GitHub, such as GitTorrent[1][2],
	# seem have missed the mark. The social aspect seems to be what
	# matters. GitLab[3] seems promising.
	# 
	# GitHub is a fairly advanced application, and the open source
	# equivalents are relatively unproven. We should focus on popular
	# open source applications with fewer network effects first,
	# before trying something this ambitious.
	# 
	# [1] https://github.com/cjb/GitTorrent
	# [2] https://github.com/cjb/GitTorrent/issues/75
	# [3] https://about.gitlab.com/contributing/

###

# This section is just a brief overview. There are far too many apps to
# cover. Pull requests welcome: https://github.com/btrask/make-decentralized

other-apps: chat voip forums git wikis todo-lists mailing-lists etherpad
	# There are a large number of popular, open source applications
	# that are more practical to port than rewrite from scratch.
	# These should be easier initial targets than the really ambitious
	# goals like Facebook, Twitter, or even GitHub. The idea is to
	# start small, prove the technologies, and build steam.

chat: slack low-latency

slack: eventual-consistency low-latency
	# https://slack.com
	# Yes, it's ironic that the Decentralized Web Summit is being
	# organized over Slack.
	# 
	# For a decentralized Slack, we already have Matrix and (ahem) IRC.
	# They can even bridge to existing Slack channels. Pretty much all
	# of these systems only rely on weak consistency, which means they
	# could eventually be unified with the decentralized content
	# addressing systems.

voip: eventual-consistency low-latency
	# VOIP streams are typically P2P UDP, for latency and efficiency.
	# The rest of the system could use a decentralized platform for
	# discovering contacts and other things.

forums: reddit sql

reddit: eventual-consistency
	# https://github.com/reddit/reddit
	# From what I understand, Reddit has already been ported to
	# Cassandra, an eventually consistent database. That should make
	# it much easier to port it to one of the decentralized content
	# addressing systems, especially if a CQL compatibility layer
	# were made.

git: strong-consistency content-addressing
	# https://git-scm.com
	# For completeness, Git itself (or mainly the "porcelain") could
	# be ported to a decentralized platform. Git is already
	# decentralized, so the advantages of doing this are probably
	# low (although it'd be a good demo!).
	# 
	# For decentralized Git hosting, see 'github'.

wikis: mediawiki strong-consistency
	# The implementation of a wiki is very similar to Git, and in
	# fact there are already wikis built on top of it[1]. One
	# problem is that every wiki supports different features and
	# syntax, so moving content between them is nearly impossible.
	# 
	# [1] https://en.wikipedia.org/wiki/List_of_wiki_software

mediawiki: mysql
	# https://www.mediawiki.org/wiki/Special:MyLanguage/Developer_hub
	# Of course we'd all like to decentralize Wikipedia and the
	# other Wikimedia projects, but I think that's best done by the
	# Wikimedia Foundation and community, once there is a viable
	# platform for them to build on.

todo-lists:
mailing-lists: email
etherpad:
# countless others...

###

zeronet: web-apps web-page-virtualization deployment
	# https://zeronet.io
	# ZeroNet is best described as a framework, runtime and hosting
	# platform for building decentralized web apps. It has several
	# of its own apps including ZeroBlog and ZeroTalk which look
	# very slick and are usable today.
	#
	# However, porting most existing apps to ZeroNet seems pretty
	# much impossible, and because ZeroNet has a large runtime
	# component, there are sandboxing issues.[1] There are also
	# deployment questions, since it relies on a local Python server.
	# 
	# [1] https://github.com/HelloZeroNet/ZeroNet/issues/157

dns: zookos-triangle
	# To be clear, hierarchy and delegation are not the same as
	# decentralization. DNS as it exists today is centralized,
	# despite being distributed (they're not antonyms).
	# 
	# Decentralized DNS is a well-known example of Zooko's triangle,
	# which was believed unsolvable for a long time and arguably
	# still poorly understood.

public-key-infrastructure: web-browsers dns
	# One might argue that certificate authorities provide a degree
	# of decentralization today, but I would say it is another
	# example of hierarchy and delegation (cf. dns) which is really
	# "false liquidity."
	# 
	# Web browsers have the most influence over the root certificates
	# of anyone (including the user) and control HSTS[1]; therefore
	# browsers themselves are the ultimate certificate authorities.
	# Domain validation could be rolled into the HSTS site overnight
	# and the entire process would become vastly simpler and more
	# secure (not to mention cheaper). Basically it's a mess.
	# 
	# In the long run, a secure DNS might be able to let us eliminate
	# root certificates entirely, but there are some problems.[2][3]
	# 
	# [1] https://hstspreload.appspot.com
	# [2] http://sockpuppet.org/blog/2015/01/15/against-dnssec/
	# [3] https://dnscurve.org

cloudflare: content-distribution-networks denial-of-service
	# https://www.cloudflare.com

content-distribution-networks: content-addressing

denial-of-service:
	# Decentralization itself is probably a solution to denial-of-
	# service attacks. It does several things:
	#   1. Makes it easier for the internet to "route around" damage.
	#   2. Makes attacking someone for hosting something less
	#      socially acceptable, because now instead of attacking the
	#      author, you're attacking random people.
	#   3. Makes it easier to keep, use, and even share your own
	#      copies offline, protecting them from attacks.

###

web-pages: web-page-hashing web-page-virtualization web-browsers

web-page-hashing: content-addressing
	# If you're going to mirror web pages across voluntary, untrusted
	# peers, content addressing is pretty much the only option.
	# However, strict content addressing using off-the-shelf
	# cryptographic hash algorithms doesn't work very well on modern
	# web pages with dynamic content: comments, ads, MOTDs, and other
	# stuff changing that isn't the core page content and should
	# ideally be ignored.
	#
	# This is doubly important for a decentralized Wayback Machine,
	# because it's hard enough to verify that someone's archive
	# of a webpage really did come from the site they say it did,
	# even if other people have a chance of getting an "equivalent"
	# page so they can corroborate.
	# 
	# The WARC format is not directly suitable for content addressing,
	# although a content addressing system could store responses with
	# associated HTTP headers like WARC does.

eventual-consistency: content-addressing

content-addressing: ipfs webtorrent named-data stronglink hash-archive
	# Content addressing is the foundation for a large number of
	# eventually consistent document stores. While it's simple and
	# powerful, porting existing apps to content addressing systems is
	# hard because most apps expect stronger consistency guarantees.
	# That said, content addressing itself doesn't preclude strong
	# consistency, if paired with something that provides it (cf.
	# strong-consistency).
	# 
	# Content addressing is a general technique for solving the
	# exactly-once message delivery problem in distributed systems.
	# It's strictly superior to UUIDs in nearly all cases.[1] When
	# using content addressing, you must be very careful what content
	# is used, since that defines the item's identity. Several systems
	# inject their own meta-data into their hashes, making them
	# mutually incompatible, unfortunately.[1]
	# 
	# [1] https://bentrask.com/?q=hash://sha256/59fd0cb6d129452290291a75
	# [2] https://bentrask.com/?q=hash://sha256/f1da36906f842142b97e745d

ipfs: web-apps filesystem web-browsers web-page-virtualization deployment
	# https://ipfs.io
	# IPFS probably needs no introduction. It's already quite popular
	# and still growing. It features a powerful networking layer
	# with a DHT for peer discovery, a file system interface,
	# and the ability to load web pages in unmodified browsers using
	# IPFS paths.
	# 
	# In my opinion, the biggest challenges facing IPFS are apps and
	# deployment (including usability by non-technical users). IPFS's
	# file system interface is not standard enough to support running
	# existing apps unmodified. It has several proof-of-concept
	# apps.[1] It probably needs a thin(ner) client for mobile devices
	# with limited battery life and bandwidth caps.
	# 
	# [1] https://github.com/ipfs/apps/issues

webtorrent: client-libraries web-browsers
	# https://webtorrent.io
	# It's BitTorrent in the browser. Already here and working!
	# WebTorrent is probably already the most complete browser-based
	# content-addressable network, and once support is integrated
	# with existing BitTorrent clients, will have the largest userbase
	# by far.
	# 
	# It's still missing DHT support, which seems to be challenging
	# under current browser limitations.[1]
	# 
	# WebTorrent by itself is still just a transport protocol. Building
	# serverless apps directly on top of it requires a fair amount
	# of additional work (ZeroNet is one example of this). Or it could
	# be as easy as an automated system for sending magnet links over
	# Matrix (or any other low-latency pub-sub protocol).
	# 
	# [1] https://github.com/feross/webtorrent/issues/288

named-data:
	# http://named-data.net
	# Named Data Networking is a network protocol that bakes
	# content addressing into the network itself. This is obviously
	# a problem for adoption, and it also casts ISPs as the primary
	# resolvers, giving them more power.

stronglink: web-apps native-apps dns
	# https://github.com/btrask/stronglink
	# Disclosure: created by yours truly
	# StrongLink is a decentralized document store with powerful
	# querying (including full-text search), real-time (low-latency)
	# syncing and pub-sub.
	# 
	# StrongLink places emphasis on the URIs (content addresses)
	# themselves for interoperability, rather than focusing
	# on the network protocol. Instead of providing a DHT, it uses
	# the Git model where you configure other repositories to pull
	# from.
	# 
	# Currently it's just a database server with a built-in blogging
	# platform. It's written to work as an embedded library, although
	# the API is still unstable. Only a few other proof-of-concept
	# apps have been built on it.

hash-archive:
	# https://hash-archive.org
	# Disclosure: created by yours truly
	# The Hash Archive is a project to map documents from all sources
	# to content addresses. For example, you can put in a URL, which it
	# will fetch and compute the hash using several algorithms and
	# display it in several formats. You can also find URLs for a hash,
	# and track URLs over time. There are plans to import other
	# databases of hashes and add support for BitTorrent and IPFS
	# hashes. Also includes a list of "critical" URLs for monitoring.

low-latency:
	# Some applications have a particular need for low-latency updates.
	# Protocols with more latency are eventually replaced by protocols
	# with less.

###

web-page-virtualization: web-browsers suborigins
	# Here's a theory: every computing environment should be able
	# to efficiently virtualize itself by running the guest system
	# natively and trapping on "unsafe" operations. X86 has finally
	# gained this ability; will the web be next?
	# 
	# Being able to sandbox and control one web page from inside
	# another is crucial for web pages that host or manipulate other
	# pages, which is very difficult right now (even from native code,
	# because browser engines aren't built to do this). Server-side
	# techniques (static recompilation) don't play well with
	# JavaScript. And being able to do this reliably, rather than
	# ad-hoc, is important for security.

suborigins: web-browsers
	# https://w3c.github.io/webappsec-suborigins/
	# Currently the same-origin policy ties the security permissions of
	# web pages to the location they are hosted from. This requires
	# tricks like alternate domain names for "untrusted content," and
	# in general falls down for hosting things for other people or
	# for cases where a domain name isn't available (e.g. localhost).
	# Suborigins let sites partition themselves arbitrarily finely.

web-browsers:
	# Web browsers themselves have become a point of centralization.
	# Web browsers have become too big to fail.
	# 
	# I don't think Servo makes the problem better, and in fact
	# it might make it worse. Browsers are as complex and patched
	# together as GPU drivers; we need a Vulkan for the web.[1]
	#
	# Because web browsers are so large and complex, only the largest
	# companies can maintain them. Innovation is stifled because
	# they are too monolithic and cannot possibly expose enough of
	# their inner workers for outsiders to try out new ideas.
	# 
	# Web developers are also limited if we expect to use web
	# technologies to fix the web itself. Don't be limited by what
	# browser developers deign to give you. Learn C, C++, and Rust.
	# 
	# [1] https://www.gamedev.net/topic/666419-what-are-your-opinions-on-dx12vulkanmantle/#entry5215019

###

filesystem: strong-consistency content-addressing
	# The appeal of a decentralized POSIX-compatible file system is
	# that it would make porting applications to it extremely easy.
	# 
	# That said, a decentralized file system is going to be slow and
	# very likely to subtly break applications that expect strict POSIX
	# semantics (for example every application that uses SQLite[1]).
	# There are also problems with how you handle file locking,
	# given CAP.
	# 
	# [1] https://www.sqlite.org/faq.html#q5

mysql: sql

sql: strong-consistency content-addressing
	# SQL (and even most NoSQL databases) assume strong consistency.
	# There have been attempts like CQL[1] to build query languages
	# that support eventual consistency, but they aren't very widely
	# used (cf. stack-overflow).
	# 
	# SQL runs transactions in "immediate mode" (meaning the database
	# waits while the application issues statements one at a time),
	# which is a problem in a distributed setting. Databases like
	# FoundationDB impose a 5 second transaction timeout, but even
	# that is vulnerable to abuse in an open network. In the long
	# run, we will need to switch to a "deferred mode" so that apps
	# can issue a "transaction program" in one shot. However that
	# will lose the portability advantages of supporting SQL in the
	# first place.
	# 
	# [1] https://cassandra.apache.org/doc/cql3/CQL.html

zookos-triangle: strong-consistency
	# https://web.archive.org/web/20011020191610/http://zooko.com/distnames.html
	# Zooko's triangle says that it's hard to have secure,
	# human-readable names in a distributed system. Aaron Swartz
	# told us this problem was solved by the blockchain[1], and since
	# then it has worked in practice (cf. namecoin). 
	# 
	# My perspective is that this is merely one example of
	# decentralized strong consistency, which is why it was "accidentally"
	# solved by Bitcoin while they were trying to address the
	# double-spend problem. Zooko's "security" requirement means that
	# either everyone must agree that there is a single mapping for
	# each name, possibly because there is only a single owner allowed
	# to change it. As far as I'm aware, this is a novel result.
	# 
	# [1] http://www.aaronsw.com/weblog/squarezooko

strong-consistency: blockchain
	# Eventually consistent databases are easy and make applications
	# hard; strongly consistent databases are hard and make
	# applications easy.
	# 
	# I was very cynical about blockchains for a long time, so please
	# don't accuse me of simply buying into the hype. The reason I've
	# come to believe that blockchains are revolutionary is because
	# they are the first successful way of guaranteeing strong
	# consistency (in the case of crypto-currencies, known as the
	# double-spend problem) with an unknown number of peers, many of
	# which might be malicious. Other protocols like Paxos are able to
	# guarantee strong consistency as well, but they require a known
	# and relatively fixed number of peers in order for voting to work.
	# This was so revolutionary it was known as "Squaring Zooko's
	# Triangle," (cf. zookos-triangle) but the implications are much
	# larger than DNS or human-readable names.
	#
	# I prefer to to call the blockchain a "massively distributed"
	# database. It's very different from ordinary, strongly-consistent
	# databases like FoundationDB (RIP), CockroachDB, and VoltDB.
	# 
	# To be clear, the blockchain doesn't need to store much data at
	# all. It only needs to provide _ordering_ for data stored
	# elsewhere (such as in a content-addressing system).

blockchain: ethereum namecoin
	# The problem with using the blockchain as the basis for a strongly
	# consistent, massively distributed database is that it's slow.
	# Specifically, transactions only commit probabilistically, and
	# the "settling time" is based on how long it takes messages to
	# spread throughout the whole network. In Bitcoin, this is roughly
	# 10-30 minutes per transaction. For logically independent
	# transactions, you can issue them in parallel, up to around 7
	# transactions per second.
	# 
	# In Ethereum, which is the fastest "traditional" blockchain that
	# I know of, transactions confirm in as little as 2-3 minutes,
	# owing to its clever blockchain design[1].
	# 
	# Unfortunately, BigchainDB/IPDB doesn't seem applicable here,
	# because it offers weaker guarantees against Sybil attacks.
	# 
	# [1] https://blog.ethereum.org/2014/07/11/toward-a-12-second-block-time/

ethereum:
	# https://www.ethereum.org
	# To me, the exciting part of Ethereum is the blockchain that
	# confirms transactions significantly faster than Bitcoin's
	# (~3 minutes versus ~30 minutes).
	# 
	# Smart contracts could be very useful for databases and apps
	# built on top of Ethereum, to lessen the reliance on cryptography
	# for controlling what untrusted users can do. (Think of smart
	# contracts as a limited form of homomorphic encryption[1].)
	# 
	# [1] https://en.wikipedia.org/wiki/Homomorphic_encryption

namecoin:
	# https://www.namecoin.info/
	# Namecoin is here today and is heavily used by ZeroNet. I don't
	# know of any serious problems with it, aside from the fact that
	# it isn't very poplar. By itself it doesn't have any driving
	# use cases, but in conjunction with a decentralized web
	# platform it could provide a lot of value.

###

deployment: web-browsers native-apps sandstorm browser-extensions
	# The deployment (and polish) problem tends to be underrated or
	# ignored when talking about decentralization. People like frying
	# pans with grippy handles. Who's going to use your program
	# without a grippy handle? That's how high the bar is.

native-apps: client-libraries
	# A decentralization platform might have a graphical "management
	# interface," but that should not be our focus. Ideally, these
	# platforms should be mostly self-managing and transparent to
	# end users. The focus should be on client libraries that allow
	# existing (and new) apps to use your platform.
	# 
	# Of course, existing native apps can and should be ported, in
	# the same way that web apps should be (cf. web-apps). On desktop
	# platforms, it might be enough to present a standard filesystem
	# (cf. filesystem) where native apps can store their data.

client-libraries: stack-overflow
	# Whatever form your decentralization platform takes, we'll need
	# libraries we can embed in other applications to use it.
	# 
	# Note that iOS restricts apps from spawning child processes, so
	# everything needs to run in a single address space. You can't
	# rely on a daemon process. Each app has its own sandbox so you
	# can't share data either.
	# 
	# Also remember: battery life and bandwidth caps.
	# 
	# These requirements preclude a lot of tools in the web developer
	# comfort zone.

sandstorm:
	# https://sandstorm.io
	# Typical users don't know how run servers, or want to.
	# Docker isn't the solution, but Sandstorm might be. I still
	# don't think it's a great solution compared with native clients,
	# especially on mobile, but it runs real apps right now. And
	# people aren't going to stop making web apps, so we need a
	# way for users to self-host them.

browser-extensions: web-browsers web-page-virtualization
	# Browser extensions don't seem to be the be-all solution that
	# one might expect.
	#   1. The landscape is in turmoil because Firefox is dropping
	#      its extension API and switching to WebExtension (Chrome).
	#   2. Surprisingly, it isn't possible for Chrome extensions to
	#      add new URI protocol support.
	#   3. Some mobile browsers don't support extensions.
	#   ...
	#   n. Obviously, adoption is a problem.

###

other-goals: mesh-networks anonymity email

mesh-networks:
	# In my opinion, we cannot even seriously consider mesh networks
	# until the sneakernet makes a comeback. By that I mean that mesh
	# networks should perhaps be thought of as an advanced form of
	# offline communications, rather than as a second Internet (at
	# least to start with). It's possible that this will become viable
	# if the certificate authority model continues to break down, and
	# the web of trust finally reaches critical mass.
	# 
	# Frankly, I'm not holding my breath.

anonymity:
	# Law enforcement has found several wedge issues against anonymity:
	# - Money laundering
	# - Tax evasion
	# - Child pornography
	# - Bomb threats
	# Realistically, we can't get our rights back unless we come up with
	# an alternate way of tackling these problems.
	# 
	# A police state is powered by criminals.

email: spam-prevention
	# Email was designed to be federated, but a large amount of its
	# flexibility has been lost over time, mainly in the war against
	# spam.
	# 
	# I think protocols need to use store-and-forward delivery in
	# order to let users receive messages directly to their mobile
	# devices.
	# 
	# Latency is another big reason why email isn't suitable for
	# building other systems on top of (cf. low-latency).
	# 
	# End-to-end encryption is also a problem.

spam-prevention:
	# In my opinion, the reason spam is so difficult to prevent is
	# because the incentive to spam a network is the same incentive
	# to use it. In other words, if the ROI is positive, you will
	# attract users and spammers alike. That means it's very difficult
	# for a system to get popular in the first place without being
	# vulnerable to spam. For example, lots of people were attracted
	# to Twitter by the idea of "building a brand" and attracting
	# a huge following.

###

install: decentralized
	@ echo "Thank you for reading! :)"


