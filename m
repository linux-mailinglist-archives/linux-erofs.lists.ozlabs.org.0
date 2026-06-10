Return-Path: <linux-erofs+bounces-3563-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lSn9LI/UKGpQKgMAu9opvQ
	(envelope-from <linux-erofs+bounces-3563-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jun 2026 05:05:51 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6194C6658C9
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jun 2026 05:05:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=buG81GDV;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3563-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3563-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZrJD004Zz2xjN;
	Wed, 10 Jun 2026 13:05:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781060747;
	cv=none; b=oLezKpm8UuQ/HihN2Ne+u5kdz+c//aSmg4YsI40uBjnuDVJNrfUG4oEcYruMTvT/hy2dS8R2hcVcqnsvd+AE67ftpw2/aQJHaukesgz144C3KEVoNwBAertDpdidJPMX914xYsjY5bzyw4H9SiALLxNmyGZfVKfC7FeAeNVXEptQudDg6UwsUqAfbZAkoo/DVQZYuXItzkhAnjJ7g082W8GYrfZ1UZm0TCgOcwFvLRB//iIv4fEILNmVJPkMyK+YWTVcxoG8iZ/ez2CmnAzYddDsHD6sij8zNdmYBhFdUS8ZzA0Fago0FjPEVHeJGNzNHXjLCvuC/IMxMfVLatAnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781060747; c=relaxed/relaxed;
	bh=/3y1DXBqK4hASYqGvG8VlKmJ9FLUEWajTyJcdgYqiT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/UdULCNY+/Gy1A3dAUKuU1W1zGxo4OPuv9+MysTTCVVqnqJu7u2a9CXRm9Mm+fZ3Ip8US1GgfpQuThc+v8Yneb6LnPYA0WM8t4fp7ztod58/3ZgT1zOhmPhChETCdk9SHy9pOKAMrrXkxgN5zDBZb50XxbK00yN5b4zCSnqpuf5VKDUk6j7j+3KhCOOQIOK82JJsnp+enE6MbBL+RSEowBUIK+pmB+brictEPHH60sOKlSOMET36VG4EnL6sOh2oZWlbaS4HeIUvGeqFS9FVNfi1IPx/kfJEWZw23aZ25Np3U5JpkNIWyCQkYV+6kXrj1ijZdaYbOc2jkERpkcl3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=buG81GDV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZrJ873RFz2xdb
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jun 2026 13:05:43 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781060738; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/3y1DXBqK4hASYqGvG8VlKmJ9FLUEWajTyJcdgYqiT8=;
	b=buG81GDVyTWbmPtr967LWtjatJgoDpCYw0tuZaCyfjN2FH5x3CZ+0Qs9ZZpY0rg+AbvrQMaQNHzgmD+zhgiGeXji+ApPlssgw7UO8mDnA4PHc9ioIpfJ9D/6FLPvSw20QPxaRelfot7RLamxWG7FJMyuOpzpKQHANM85u6S0Zhg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X4YdGUm_1781060733;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4YdGUm_1781060733 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Jun 2026 11:05:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: update the overview of the documentation
Date: Wed, 10 Jun 2026 11:05:32 +0800
Message-ID: <20260610030532.3170375-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3563-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6194C6658C9

Update the overview section to better reflect EROFS's design philosophy
as an immutable image filesystem, update the feature highlights with
recent capabilities, and remove outdated items.

The following detailed sections will be revised later since the overview
section is the most visible part of our documentation. Outdated or
ambiguous information could mislead new users and potential adopters.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst | 129 ++++++++++++++--------------
 1 file changed, 66 insertions(+), 63 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index fe06308e546c..85a8d5020347 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -7,83 +7,90 @@ EROFS - Enhanced Read-Only File System
 Overview
 ========
 
-EROFS filesystem stands for Enhanced Read-Only File System.  It aims to form a
-generic read-only filesystem solution for various read-only use cases instead
-of just focusing on storage space saving without considering any side effects
-of runtime performance.
-
-It is designed to meet the needs of flexibility, feature extendability and user
-payload friendly, etc.  Apart from those, it is still kept as a simple
-random-access friendly high-performance filesystem to get rid of unneeded I/O
-amplification and memory-resident overhead compared to similar approaches.
-
-It is implemented to be a better choice for the following scenarios:
-
- - read-only storage media or
-
- - part of a fully trusted read-only solution, which means it needs to be
+EROFS (Enhanced Read-Only File System) is a modern, efficient, and secure
+read-only kernel filesystem designed for various use cases including immutable
+system images, container images, application sandbox images, and dataset
+distribution.
+
+An immutable image filesystem can be regarded as an enhanced archive format
+which allows golden images to be built once and mounted everywhere -- images are
+bit-for-bit identical across all deployments and can be verified, audited, or
+shared without concerns about runtime modifications (in this model, all user
+writes should be redirected into another trusted filesystem, for example, via
+overlayfs for copy-on-write-style redirection, by design).
+
+EROFS is a dedicated implementation of the image filesystem idea above, with a
+flexible, hierarchical on-disk design so that needed features can be enabled on
+demand. Filesystem data in the core format is strictly block-aligned in order
+to perform optimally on all kinds of storage media, including block devices and
+memory-backed devices. The on-disk format is easy to parse and purposely avoids
+the unnecessary metadata redundancy found in generic writable filesystems, which
+can suffer from extra inconsistency issues -- making it ideal for security
+auditing and untrusted remote access. In addition, designs such as inline data,
+inline/shared extended attributes, and optimized (de)compression provide better
+space efficiency while maintaining high performance.
+
+In short, EROFS aims to be a better fit for the following scenarios:
+
+ - As part of a secure immutable storage solution, where it needs to be
    immutable and bit-for-bit identical to the official golden image for
-   their releases due to security or other considerations and
-
- - hope to minimize extra storage space with guaranteed end-to-end performance
-   by using compact layout, transparent file compression and direct access,
-   especially for those embedded devices with limited memory and high-density
-   hosts with numerous containers.
+   each individual copy, in order to meet security, data sharing, and/or
+   other requirements;
 
-Here are the main features of EROFS:
+ - Minimizing storage overhead with guaranteed end-to-end performance
+   by using compact (meta)data layout, optimized transparent data compression,
+   deduplication and direct access, especially for those embedded devices with
+   limited memory and high-density hosts with numerous containers.
 
- - Little endian on-disk design;
+Here is the list of highlights:
 
- - Block-based distribution and file-based distribution over fscache are
-   supported;
+ - Little endian on-disk design with 48-bit block addressing, supporting up
+   to 1 EiB filesystem capacity with 4 KiB block size;
 
- - Support multiple devices to refer to external blobs, which can be used
-   for container images;
+ - Two compact inode metadata layouts for space and performance efficiency:
 
- - 32-bit block addresses for each device, therefore 16TiB address space at
-   most with 4KiB block size for now;
+   ========================  ========  ======================================
+                             compact   extended
+   ========================  ========  ======================================
+   Inode core metadata size  32 bytes  64 bytes
+   Max file size             4 GiB     16 EiB (also limited by max. vol size)
+   Max uids/gids             65536     4294967296
+   Nanosecond timestamp      no        yes
+   Max hardlinks             65536     4294967296
+   ========================  ========  ======================================
 
- - Two inode layouts for different requirements:
+ - Support tailpacking inline data for better space efficiency and reduce
+   unneeded I/O amplification;
 
-   =====================  ============  ======================================
-                          compact (v1)  extended (v2)
-   =====================  ============  ======================================
-   Inode metadata size    32 bytes      64 bytes
-   Max file size          4 GiB         16 EiB (also limited by max. vol size)
-   Max uids/gids          65536         4294967296
-   Per-inode timestamp    no            yes (64 + 32-bit timestamp)
-   Max hardlinks          65536         4294967296
-   Metadata reserved      8 bytes       18 bytes
-   =====================  ============  ======================================
+ - Block-based and file-backed distribution are both supported;
 
- - Support extended attributes as an option;
+ - Multiple devices to reference external data blobs: inode data can be
+   optionally placed into external blobs, which enables image layering and data
+   sharing among different filesystems;
 
- - Support a bloom filter that speeds up negative extended attribute lookups;
+ - Inline and shared extended attributes with an optional bloom filter that
+   speeds up negative extended attribute lookups;
 
- - Support POSIX.1e ACLs by using extended attributes;
+ - POSIX.1e ACLs by using extended attributes;
 
- - Support transparent data compression as an option:
-   LZ4, MicroLZMA, DEFLATE and Zstandard algorithms can be used on a per-file
-   basis; In addition, inplace decompression is also supported to avoid bounce
-   compressed buffers and unnecessary page cache thrashing.
+ - Transparent data compression as an option: Supported algorithms (LZ4,
+   MicroLZMA, DEFLATE and Zstandard) can be selected on a per-inode basis.
+   Both the on-disk metadata and decompression runtime have been heavily
+   optimized to minimize the overhead for better performance.
 
- - Support chunk-based data deduplication and rolling-hash compressed data
-   deduplication;
+ - Merging tail-end data into a special inode as fragments;
 
- - Support tailpacking inline compared to byte-addressed unaligned metadata
-   or smaller block size alternatives;
+ - Chunk-based deduplication and rolling-hash compressed data deduplication;
 
- - Support merging tail-end data into a special inode as fragments.
+ - Direct I/O and FSDAX support on uncompressed inodes for use cases such as
+   secure containers, loop devices, and ramdisks that do not need page caching;
 
- - Support large folios to make use of THPs (Transparent Hugepages);
+ - Page cache sharing among inodes with identical content fingerprints on
+   the same machine.
 
- - Support direct I/O on uncompressed files to avoid double caching for loop
-   devices;
+For more detailed information, please refer to our documentation site:
 
- - Support FSDAX on uncompressed images for secure containers and ramdisks in
-   order to get rid of unnecessary page cache.
-
- - Support file-based on-demand loading with the Fscache infrastructure.
+- https://erofs.docs.kernel.org
 
 The following git tree provides the file system user-space tools under
 development, such as a formatting tool (mkfs.erofs), an on-disk consistency &
@@ -91,10 +98,6 @@ compatibility checking tool (fsck.erofs), and a debugging tool (dump.erofs):
 
 - git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
 
-For more information, please also refer to the documentation site:
-
-- https://erofs.docs.kernel.org
-
 Bugs and patches are welcome, please kindly help us and send to the following
 linux-erofs mailing list:
 
-- 
2.43.5


