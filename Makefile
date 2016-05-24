# make decentralize
# Ben Trask <https://bentrask.com>
# CC0
# May 2016

# Please see README.md for more information.

decentralize: web other-goals

web: web-apps web-pages web-browsers zeronet dns public-key-infrastructure deployment

###

web-apps: wordpress wayback-machine facebook twitter google github other-apps

wordpress: porting-effort deployment mysql web-pages
	# https://wordpress.org [TODO] [use open source link?]
	# WordPress runs 25% of all websites.[TODO] If you want to talk about
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

wayback-machine: web-pages web-page-hashing deployment
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
	# all of the irreproducible parts of it (perhaps by making
	# multiple requests and computing an "average"), and then allowing
	# various parties to cryptographically sign the result. Such a
	# system requires a large number of users to get any reasonable
	# corroboration.

facebook: decentralize
	# Unresolved circular dependency

twitter: decentralize
	# Unresolved circular dependency

google: web-pages
	# In order to index data, you need to access it. That means that
	# storing data and providing a search engine are intrinsically
	# tied together. That means that if we can decentralize static
	# webpage hosting, then decentralized search is relatively easy.
	# No crawling necessary.
	# 
	# I believe that keeping Google in our corner is an important
	# long-term strategy. That means not trying to kill them (are
	# you feeling lucky?) and using the carrot more than the stick.
	# Note how Mozilla has faired after trying their luck with Yahoo.
	# The decentralized web will still need a great search engine,
	# just like we're not putting the Internet Archive out of
	# business either. That said, it's not healthy for us to be
	# entirely dependant on handouts.
	# 
	# It's also worth remembering that Google already has literally
	# almost all of the technology we're talking about to decentralize
	# the web, albeit on a company-wide rather than global scale.
	# They are a model to learn from.

github: other-apps
	# https://github.com
	# It seems remarkable that a social network built on a decentralized
	# data-store (Git) has network effects just as strong as any other
	# social network. This should be a lesson of caution to any eager
	# would-be decentralizers.
	# 
	# Past attempts to decentralize GitHub, such as GitTorrent[TODO],
	# have missed the mark. The social aspect seems to be what matters.
	# 
	# Like Google, GitHub has been very good to the open source
	# community, and we should be thankful. Unlike Google, we can
	# probably afford to piss them off, and the sooner we do, the
	# less messy the breakup will be (since their dependency is
	# constantly growing into our tools and platforms). Sorry GitHub.
	# 
	# That said, GitHub is a fairly advanced application, and the
	# open source equivalents are relatively unproven. We should
	# focus on popular open source applications with fewer network
	# effects first, before trying something this ambitious.

zeronet: web-apps web-page-sandboxing deployment
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

porting-effort:
	# Porting large, often "legacy" software projects isn't sexy.
	# But think about this: if a decentralization platform were
	# built well enough that porting existing apps en masse felt
	# feasible and rewarding, there are a lot of programmers who
	# might get excited about porting an app or two. Look at how
	# mobile apps were doing for like five years. That's the level
	# of adoption we need to aim for (so that it's okay if we
	# fall a little bit short).

###

other-apps: forums wikis todo-lists etherpad git
	# There are a large number of popular, open source applications
	# that are more practical to port than rewrite from scratch.
	# These might be easier initial targets than the really ambitious
	# goals like Facebook or Twitter. The idea is to start small,
	# prove the technologies, and build steam.
	# 
	# [TODO] server-side logic... various languages
	# [TODO] forums: reddit/etc?
	# gitlab, mailing lists...? messenger apps?
	# [TODO] we should list other requirements... low latency? push notifications?

forums: reddit

reddit: eventual-consistency
	# [TODO]

wikis:
todo-lists:

etherpad:

# [TODO] a single git repo actually requires strong-consistency?
git: eventual-consistency
	# https://git-scm.com
	# [TODO]
	# Supports eventual consistency (git merge) and strong consistency
	# (git rebase). Manually pushing, pulling, merging and rebasing
	# naturally has high latency. In strong consistency mode with
	# rebase, Git becomes centralized because one or more repositories
	# need to be un-rebase-able in order to know that writes are
	# committed.

###

dns: namecoin strong-consistency web-pages
	# Decentralizing DNS means "squaring Zooko's triangle."[TODO]
	# In other words it require strong consistency.
	# A decentralized domain name system called Namecoin already
	# exists, and is heavily used in ZeroNet. I don't know of
	# any serious problems with it, aside from the fact that
	# it isn't very poplar. By itself it doesn't have any driving
	# use cases, but in conjunction with a decentralized web
	# platform it could provide a lot of value.
	# 
	# For what it's worth, it would be better to build naming
	# on top of a secure transport (have domains point to public
	# keys) rather than building security on top of naming
	# (domain validation).
	# [TODO] what, really? this is about pk vs ip, not dns

namecoin:
	# https:// [TODO]

public-key-infrastructure: web-browsers
	# [TODO] oh god

###

web-pages: web-page-hashing web-page-sandboxing web-browsers

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

# [TODO] named data networking?
content-addressing: ipfs webtorrent stronglink hash-archive porting-effort
	# Content addressing is the foundation for a large number of
	# eventually consistent document stores. While it's simple
	# and powerful, porting existing apps to content addressing
	# systems is hard because most apps expect stronger consistency
	# guarantees. That said, content addressing itself doesn't
	# preclude strong consistency, if paired with something that
	# provides it (cf. strong-consistency).
	# 
	# Content addressing is a general technique for solving the
	# exactly-once message delivery problem in distributed systems.
	# It's strictly superior to UUIDs in nearly all cases.[TODO] When using
	# content addressing, you must be very careful what content is
	# used, since that defines the item's identity. Several systems
	# inject their own meta-data into their hashes, making them
	# mutually incompatible, unfortunately.

ipfs: web-apps filesystem web-browsers web-page-sandboxing deployment
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
	# existing apps unmodified. It has several proof-of-concept apps.[TODO]
	# [TODO] android port? NOTE: android port means "running apps"
	# since the cpu/bandwidth usage of a full ipfs node seems wasteful on mobile

webtorrent: client-libraries web-browsers
	# https://webtorrent.io
	# It's BitTorrent in the browser. Already here and working!
	# WebTorrent is probably already the most complete browser-based
	# content-addressable network, and once support is integrated
	# with existing BitTorrent clients, will have the largest userbase
	# by far.
	# 
	# It's still missing DHT support, which seems to be challenging
	# under current browser limitations.[TODO]
	# 
	# WebTorrent by itself is still just a transport protocol. Building
	# serverless apps directly on top of it requires a fair amount
	# of additional work, at least some of what ZeroNet provides.

stronglink: web-apps native-apps dns
	# https://github.com/btrask/stronglink
	# Disclosure: created by yours truly
	# StrongLink is a decentralized document store with powerful
	# querying (including full-text search), real-time syncing,
	# and pub-sub.
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

###

web-page-sandboxing: web-browsers suborigins
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
	# http:// [TODO]
	# Currently the same-origin policy ties the security permissions of
	# web pages to the location they are hosted from. This requires
	# tricks like alternate domain names for "untrusted content," and
	# in general falls down for hosting things for other people or
	# for cases where a domain name isn't available (e.g. localhost).
	# Suborigins let sites partition themselves arbitrarily finely.

# webassembly?
# no need to talk about sandboxing...
# ...dividing software horizontally rater than vertically?
web-browsers: browser-engines secure-sandbox
	# Web browsers themselves have become a point of centralization.
	# Web browsers have become too big to fail.
	# I don't think Servo makes the problem better, and in fact
	# it might make it worse. Browsers are as complex and patched
	# together as GPU drivers; we need a Vulkan for the web.
	# [TODO] vulkan link?
	#
	# Because web browsers are so large and complex, only the largest
	# companies can maintain them. Innovation is stiffled because
	# they are too monolithic and cannot possibly expose enough of
	# their inner workers for outsiders to try out new ideas.
	#
	# Browser extensions have deployment problems and still aren't
	# powerful enough.

browser-engines:
	# Browser engines have evolved into elaborate game engines.

secure-sandbox:
	# Secure, efficient sandboxing is the cornerstone of the web.

###

filesystem: strong-consistency content-addressing
	# The appeal of a decentralized POSIX-compatible file system is
	# that it would make porting applications to it extremely easy.
	# 
	# That said, distributed file systems are hard. Just ask NFS or
	# AndrewFS[TODO]. Database-backed file systems are slow. Just ask
	# WinFS.
	# 
	# A decentralized file system is going to be slow and very
	# likely to subtly break applications that expect strict POSIX
	# semantics (for example every application that uses SQLite[TODO]).
	# There are also problems with how you handle file locking,
	# given CAP.

mysql: sql

sql: strong-consistency content-addressing
	# SQL (and even most NoSQL databases) assume strong consistency.
	# There have been attempts like CQL[TODO] to build query languages
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

strong-consistency: blockchain
	# Eventually consistent databases are easy and make applications
	# hard; strongly consistent databases are hard and make
	# applications easy.
	#
	# I was very cynical about blockchains for a long time, so please
	# don't accuse me of simply buying into the hype. The reason I've
	# come to believe that blockchains (really, the blockchain) is
	# revolutionary is because they are the first successful way of
	# guaranteeing strong consistency (in the case of Bitcoin, known
	# as the double-spend problem) with an unknown number of peers,
	# many of which might be malicious. Other protocols like Raft
	# and Paxos are able to guarantee strong consistency as well,
	# but they require a known and relatively fixed number of peers
	# in order for voting to work. This was so revolutionary it was
	# known as "Squaring Zooko's Triangle,"[1] but the implications are
	# much larger than DNS or human-readable names.
	#
	# I prefer to to call the blockchain a "massively distributed"
	# database. It's very different from ordinary, strongly-consistent
	# databases like FoundationDB (RIP), CockroachDB, and VoltDB.
	# 
	# [1] http://www.aaronsw.com/weblog/squarezooko

blockchain: ethereum
	# The problem with using the blockchain as the basis for a strongly
	# consistent, massively distributed database is that it's slow.
	# Specifically, transactions only commit probabalistically, and
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
	# Smart contracts can perhaps be thought of as a limited form of
	# homomorphic encryption, making them primarily of use for
	# financial applications such as a decentralized exchange[1]
	# and TheDAO[2].
	# 
	# [1] https://etherex.org
	# [2] [TODO]

###

deployment: web-browsers native-apps sandstorm browser-extensions
	# The deployment (and polish) problem tends to be underrated
	# or ignored when talking about decentralization. People like
	# frying pans with grippy handles. Who's going to use your
	# thing without a grippy handle? That's how high the bar is.

# TODO this term is bad?
# why arent we talking about porting existing native apps to our platform?
# alternative: client-software? (merged with client-libraries below)
native-apps: client-libraries
	# Any decentralization platform should have a way of making,
	# running, and deploying native apps. At one end of the spectrum,
	# this could just be a library that native apps embed
	# to access the local repository and decentralized network.
	# At the other end, it could be a whole framework capable of
	# running WordPress decentralized with only minor modifications.
	# Ideally both.

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

stack-overflow: sql filesystem
	# If we want to move to a world where new and existing applications
	# are built "decentralized-first," we need to solve the Stack
	# Overflow problem. When programmers turn to SO to find out how to
	# query a database or copy and paste some snippet of code, we need
	# all of the examples to show the decentralized way of doing things.
	# For that to happen, there are basically two options:
	#   1. Update all of the answers on Stack Overflow with a new way
	#      of doing things and make everyone relearn everything.
	#   2. Build decentralized platforms that are bug-compatible with
	#      existing software stacks.
	# Obviously, neither of these options will be easy.

sandstorm:
	# http:// [TODO]
	# Typical users don't know how run servers, or want to.
	# Docker isn't the solution, but Sandstorm might be. I still
	# don't think it's a great solution compared with native clients,
	# especially on mobile, but it runs real apps right now. And
	# people aren't going to stop making web apps, so we need a
	# way for users to self-host them.

browser-extensions: web-browsers web-page-sandboxing
	# Browser extensions don't seem to be the be-all solution that
	# one might expect.
	#   1. The landscape is in turmoil because Firefox is dropping
	#      its extension API and switching to WebExtension (Chrome).
	#   2. Surprisingly, it isn't possible for Chrome extensions too
	#      add new URI protocol support.
	#   3. Some mobile browsers don't support extensions.
	#   ...
	#   n. Obviously, adoption is a problem.

###

other-goals: mesh-networks anonymity email

mesh-networks:
	# In my opinion, we cannot even seriously consider mesh networks
	# until the sneakernet makes a comeback. It's possible that
	# this will happen if the certificate authority model continues
	# to break down, and the web of trust finally becomes viable.
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
	# Email was designed to be federated, [TODO]


spam-prevention:
	# In my opinion, the reason spam is so difficult to prevent is
	# because the incentive to spam a network is the same incentive
	# to use it. In other words, if the ROI is positive, you will
	# attract users and spammers alike. It's very difficult for a
	# system to get popular in the first place without being
	# vulnerable to spam. For example, lots of people were attracted
	# to Twitter by the idea of "building a brand" and attracting
	# a huge following.

###

install: decentralize
	echo "Thank you for reading! :)"
	#rm -rf /



