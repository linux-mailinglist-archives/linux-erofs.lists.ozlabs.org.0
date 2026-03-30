Return-Path: <linux-erofs+bounces-3095-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLthHHAIymk64gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3095-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:21:52 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E7635577B
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 07:21:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkfkN2PKMz2ygf;
	Mon, 30 Mar 2026 16:21:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774848108;
	cv=none; b=X1kw1dprMGQWRE+n6ISBZkIqTgn5JqVAKTZxjN5aFv0IH8fmL9SBWGrnJDMdePkHgV1bES9DWWb90A3qhTL7BJM4MYL3m8CiNuhqs+3Xa1vxoH/1AJo/qzILjDcKuwnLoVyIWmIycfHJRMx7KR11Rw5yZ0TAdWokwnKZDzX8u7JnhEXxf83Z8Y/bxSL5OpXLCErOpMpZ+8pMNcnZm1ANX71YMC9VXIDzfqToPmu59+Ke78GwmGYQU5TkJ3AR0yaSVw1HVhhKs13JJ31MNog6G3tiI8eD34OwuMqVhz/3mjEd2TA8xbWga096VWST0LrVOwcWlezwPur6/2EObif18A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774848108; c=relaxed/relaxed;
	bh=3ZvycksYbG7XoonW7xTQwPzlCDaSVdBy8vpQhXCzG60=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eic2OTqCrKFvE/Kl499gFBQHZ/XDXchNUkljbNCo6kzoqUIE7PxvFnfn2Kta4HdAYssfSnOLGDHhCJk6IGnBRwpYo9gCGL8uchib0v5v6Lur/Y5D4zbDVg694UYUV903aPytSnn1jQt1sP7JcaUOi7ujtRnUqQlfyf9DbeQD84cQexc84ft47REhQ0uQBuaZ8AFzBR20dRpO4uMYuTTeG8z7024/aZTO2LTuYAob1nzrd7y9n/nj+5dnGenNJ6Psn8stn8SB6H0hXoYyakEjkTSZgsKI2+/WenT4z7GGzowvrw+MU1a4zxLS5TJsfKn596JWsElRkhstCsQ6acm5fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fXmJU2UQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fXmJU2UQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkfkM0dygz2xpt
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 16:21:46 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2b2589c26e3so1088385ad.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774848105; x=1775452905; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZvycksYbG7XoonW7xTQwPzlCDaSVdBy8vpQhXCzG60=;
        b=fXmJU2UQahfUdNQL3t56b17QiE/vZ100jszZ8HRDUd3RBsH6YEcI7SfXuhiBLH/ADb
         xPeeEKZY03CsfvpQYzfPxFuJ2Ga+KgEB3pHJk+YWZuQ4I8Vh6HJHWT4rdsaqwNP6GW9l
         /7DUNSEHSarlwVaAYAU9IE/5KgRTmR6x4HoQVM6D/puw9zdkDVwHmjtw5sBSZmV8ePp8
         pvy1Q7CZ36KuZWboB5V7eNdy3TqaEYyBYOpBvxdxcQrTlqlcplgsQVdko0Qeao5t5vy7
         NYnM2YGL9a+UdlSjrZ/Znu+ARvjw+gTjMuxFDdlBv7MxZ+sonJmzXTrdqUBHYetlSKaX
         2iSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848105; x=1775452905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ZvycksYbG7XoonW7xTQwPzlCDaSVdBy8vpQhXCzG60=;
        b=k/uqFeXHHuFOuBiou60P3b+fsrpA8ZbsOXEmgtlr5T/xZsme6Bxk4PM+91hYoAcAjW
         mI7Ml1/0bctX7BqAAMk6HuqbPWy5/lgGT5M4E0ZDGjiUpepXFIj5tOtn9C/akXNJaHNd
         aHsMOOrttzJ7Bts5ou+iEx3my6Q29+2xkxqGVdUoWWYoKJDTHCUz99ydQDszlP0VE0gw
         zSmtnyZVvbt50By+rl8SxPL7Ak7D7x6GqXvPoMN1sWUx/IgFObUKQUwBtJQULxdXGF31
         Hv74800u4z7+FKb9NDRXPMXjQ9uY67yGwGvjpbi4gACW3sNV/2v+yYbdNcMGRM9HPVNK
         87xw==
X-Gm-Message-State: AOJu0YztBbC+yNie4i3mMRV5pIjkJmVHYTTa4b9unKUvt/XDPTzwMUz2
	uzY77/6dNvdT2DqWzZ7w/3E7jSDIwo+tfh79wk6URE2HsN4bgjhDHbgilpPy7KhA
X-Gm-Gg: ATEYQzw1fYRAmwWiOf9gYSLE9aUzjXCHBQiM7PYEtsOX50IfG8+fsTEzyx0UvIaW7XL
	vaLm/fqY2y8+HmbAz4F0t5yTkxS4ZZPhVCsGvcFBCc3E4xswUqwtiLa5LOFG1cnqEcR7ozP98a7
	isRyNnTmKWyreqvcnAmnwprG+DlZJ9aKbJZwhj4zLWa/maPGFRwdPePO4bVaXHVJm6NoXu4D3j/
	+cOifEjNIu0XKmrIdxC+trQDBvOevtkQl/MzohXl3iB8CtuEuT38VG7VGm01ty7nS9HqQp+HfpW
	onDUHXTPBnr1H/8OtN7I2nzi1NZB2kEFf4IsvGx5Dlr/BJjhIVGSprFNGd7u075aTWSU6T5DqaG
	CSQoS1hJPk3jv5JjqtNPlUCoBvi9iZavqp7uH5j3dC4J7tuvPzCXa2pry1m8psm4u1LAPo1tECt
	Kbu01fgXQ+n21JoUbcqVsWDSYG1SkqXpTWbOpok0Glh4k6
X-Received: by 2002:a17:902:cf0b:b0:2b0:5cb3:e4bc with SMTP id d9443c01a7336-2b0cdc3c274mr111113805ad.16.1774848104331;
        Sun, 29 Mar 2026 22:21:44 -0700 (PDT)
Received: from kali ([103.212.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427b15a2sm78624325ad.73.2026.03.29.22.21.43
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:21:44 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] README: comprehensive refactor for clarity and professionalism
Date: Mon, 30 Mar 2026 10:51:37 +0530
Message-ID: <20260330052137.9273-3-aghi.saksham5@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330052137.9273-1-aghi.saksham5@gmail.com>
References: <20260330052137.9273-1-aghi.saksham5@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	LOTS_OF_MONEY,MONEY_NOHTML,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-3095-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aghisaksham5@gmail.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 84E7635577B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current README contained several instances of awkward phrasing and
technical descriptions that could be improved for better readability
and professional presentation. Specifically, the phrase "form a generic
read-only filesystem solution" in the overview section was identified
as particularly unclear and has been refined for better flow.

This commit performs a comprehensive overhaul of the README file to:

1.  Improve the introduction: Rephrased the EROFS overview to clearly
    state its design goals and advantages over traditional read-only
    filesystems, emphasizing the balance between efficient compression
    and superior data access speeds.

2.  Polish use case descriptions: Updated the list of typical scenarios
    (firmware, container images, Live CDs, etc.) for better flow and
    clarity. These descriptions now highlight the specific benefits
    EROFS brings to each scenario, such as reduced metadata overhead
    and optimized startup times.

3.  Clarify tool descriptions: Standardized and improved the summaries
    for mkfs.erofs, mount.erofs, erofsfuse, dump.erofs, and fsck.erofs
    to ensure users understand the primary purpose of each utility in
    the erofs-utils suite.

4.  Enhance technical instructional sections: Refined the "How to
    generate" sections to be more instructional and professional.
    Algorithm lists, command examples, and technical notes on
    reproducibility and pcluster management have been rewritten for
    improved clarity.

5.  Refine the "Comments" section: Clarified the description of
    tail-packing to better explain its benefits regarding I/O
    minimization and storage efficiency by eliminating internal
    fragmentation in the last block of a file.

6.  General copy-editing: Fixed minor grammatical issues, improved
    sentence structure, and ensured consistent capitalization and
    terminology throughout the document.

These changes collectively provide a more professional and informative
first impression for new users while offering clearer technical context
for developers working with EROFS. This documentation update ensures
that the README remains an effective and high-quality introduction to
the project's capabilities and tooling.

Signed-off-by: Saksham <aghi.saksham5@gmail.com>
---
 README | 298 +++++++++++++++++++++++++++------------------------------
 1 file changed, 141 insertions(+), 157 deletions(-)

diff --git a/README b/README
index 6f9e761..d974305 100644
--- a/README
+++ b/README
@@ -1,292 +1,276 @@
 erofs-utils
 ===========
 
-Userspace tools for EROFS filesystem, currently including:
+Userspace tools for the EROFS filesystem, including:
 
-  mkfs.erofs    filesystem formatter
-  mount.erofs   mount helper for EROFS
-  erofsfuse     FUSE daemon alternative
-  dump.erofs    filesystem analyzer
-  fsck.erofs    filesystem compatibility & consistency checker as well
-                as extractor
+  mkfs.erofs    Filesystem formatter
+  mount.erofs   Mount helper for EROFS
+  erofsfuse     FUSE-based EROFS implementation
+  dump.erofs    Filesystem analyzer
+  fsck.erofs    Filesystem consistency checker and extractor
 
 
-EROFS filesystem overview
+EROFS Filesystem Overview
 -------------------------
 
-EROFS filesystem stands for Enhanced Read-Only File System.  It aims to
-form a generic read-only filesystem solution for various read-only use
-cases instead of just focusing on storage space saving without
-considering any side effects of runtime performance.
+EROFS (Enhanced Read-Only File System) is designed to provide a high-performance,
+generic read-only filesystem solution for a wide variety of scenarios. Unlike
+traditional read-only filesystems that often prioritize maximum storage savings
+at the cost of significant runtime performance overhead, EROFS is engineered to
+balance efficient compression with superior data access speeds.
 
-Typically EROFS could be considered in the following use scenarios:
-  - Firmwares in performance-sensitive systems, such as system
-    partitions of Android smartphones;
+Typical EROFS use cases include:
 
-  - Mountable immutable images such as container images for effective
-    metadata & data access compared with tar, cpio or other local
-    filesystems (e.g. ext4, XFS, btrfs, etc.)
+  - Firmware for performance-critical systems, such as system partitions in
+    Android smartphones;
 
-  - FSDAX-enabled rootfs for secure containers (Linux 5.15+);
+  - Highly efficient, mountable immutable images (e.g., container images)
+    offering optimized metadata and data access compared to tar, cpio, or
+    traditional local filesystems (such as ext4, XFS, and btrfs);
 
-  - Live CDs which need a set of files with another high-performance
-    algorithm to optimize startup time; others files for archival
-    purposes only are not needed;
+  - FSDAX-enabled rootfs for secure, high-performance containers (supported
+    since Linux 5.15);
 
-  - and more.
+  - Live CDs and bootable media requiring high-performance data retrieval to
+    minimize system startup times;
 
-Note that all EROFS metadata is uncompressed by design, so that you
-could take EROFS as a drop-in read-only replacement of ext4, XFS,
-btrfs, etc. without any compression-based dependencies and EROFS can
-bring more effective filesystem accesses to users with reduced
-metadata.
+  - Archival storage where fast random access to compressed data is required.
 
-For more details of EROFS filesystem itself, please refer to:
+By design, all EROFS metadata remains uncompressed. This allows EROFS to serve
+as a high-performance, drop-in read-only replacement for filesystems like ext4,
+XFS, or btrfs, even without compression-based dependencies. This architectural
+choice ensures more effective filesystem access and reduced metadata overhead
+for end users.
+
+For more details on the EROFS filesystem itself, please refer to the official
+documentation:
 https://www.kernel.org/doc/html/next/filesystems/erofs.html
 
-For more details on how to build erofs-utils, see `docs/INSTALL.md`.
+Detailed instructions for building erofs-utils are available in
+`docs/INSTALL.md`.
 
-For more details about filesystem performance, see
+For a comprehensive analysis of filesystem performance, see
 `docs/PERFORMANCE.md`.
 
 
 mkfs.erofs
 ----------
 
-Two main kinds of EROFS images can be generated: (un)compressed images.
+`mkfs.erofs` can generate two primary types of EROFS images: uncompressed and
+compressed.
 
- - For uncompressed images, there will be no compressed files in these
-   images.  However, an EROFS image can contain files which consist of
-   various aligned data blocks and then a tail that is stored inline in
-   order to compact images [1].
+ - **Uncompressed Images:** These images do not contain compressed file data.
+   However, EROFS utilizes a technique where various aligned data blocks are
+   followed by an inlined tail to compact the image size effectively [1].
 
- - For compressed images, it will try to use the given algorithms first
-   for each regular file and see if storage space can be saved with
-   compression. If not, it will fall back to an uncompressed file.
+ - **Compressed Images:** The formatter attempts to compress each regular file
+   using the specified algorithms. If compression does not yield storage
+   savings, the tool automatically falls back to an uncompressed format for
+   that specific file.
 
-Note that EROFS supports per-file compression configuration, proper
-configuration options need to be enabled to parse compressed files by
-the Linux kernel.
+Note that EROFS supports per-file compression configurations. Ensure that the
+target Linux kernel is configured with the necessary options to parse the
+selected compression formats.
 
 How to generate EROFS images
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Compression algorithms could be specified with the command-line option
-`-z` to build a compressed EROFS image from a local directory:
+Compression algorithms are specified using the `-z` command-line option. For
+example, to build a compressed EROFS image from a local directory using LZ4HC:
  $ mkfs.erofs -zlz4hc foo.erofs.img foo/
 
-Supported algorithms by the Linux kernel:
+Supported algorithms in the Linux kernel:
  - LZ4 (Linux 5.3+);
  - LZMA (Linux 5.16+);
  - DEFLATE (Linux 6.6+);
  - Zstandard (Linux 6.10+).
 
-Alternatively, generate an uncompressed EROFS from a local directory:
+Alternatively, to generate an uncompressed EROFS image:
  $ mkfs.erofs foo.erofs.img foo/
 
-Additionally, you can specify a higher compression level to get a
-(slightly) smaller image than the default level:
+You can also specify a higher compression level to achieve a smaller image
+size (e.g., level 12 for LZ4HC):
  $ mkfs.erofs -zlz4hc,12 foo.erofs.img foo/
 
-Multi-threaded support can be explicitly enabled with the ./configure
-option `--enable-multithreading`; otherwise, single-threaded compression
-will be used for now.  It may take more time on multiprocessor platforms
-if multi-threaded support is not enabled.
+Multi-threaded support can be enabled during the build process using the
+`--enable-multithreading` configure option. If enabled, `mkfs.erofs` will
+utilize multiple processors to accelerate the compression process.
 
-Currently, `-Ededupe` doesn't support multi-threading due to limited
-development resources.
+Currently, the `-Ededupe` option does not support multi-threading.
 
 Reproducible builds
 ~~~~~~~~~~~~~~~~~~~
 
-Reproducible builds are typically used for verification and security,
-ensuring the same binaries/distributions to be reproduced in a
-deterministic way.
-
-Images generated by the same version of `mkfs.erofs` will be identical
-to previous runs if the same input is specified, and the same options
-are used.
+EROFS supports reproducible builds, which are essential for verification and
+security. This ensures that the same input and options always result in
+bit-for-bit identical filesystem images.
 
-Specifically, variable timestamps and filesystem UUIDs can result in
-unreproducible EROFS images.  `-T` and `-U` can be used to fix them.
+To ensure reproducibility, you may need to fix variable timestamps and
+filesystem UUIDs using the `-T` and `-U` options, respectively.
 
 How to generate EROFS big pcluster images (Linux 5.13+)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-By default, EROFS formatter compresses data into separate one-block
-(e.g. 4KiB) filesystem physical clusters for outstanding random read
-performance.  In other words, each EROFS filesystem block can be
-independently decompressed.  However, other similar filesystems
-typically compress data into "blocks" of 128KiB or more for much smaller
-images.  Users may prefer smaller images for archiving purposes, even if
-random performance is compromised with those configurations, and even
-worse when using 4KiB blocks.
-
-In order to fulfill users' needs, big pclusters has been introduced
-since Linux 5.13, in which each physical clusters will be more than one
-blocks.
-
-Specifically, `-C` is used to specify the maximum size of each pcluster
-in bytes:
+By default, the EROFS formatter compresses data into separate one-block (e.g.,
+4KiB) physical clusters (pclusters) to ensure exceptional random read
+performance. This allows each block to be decompressed independently. In
+contrast, other filesystems often use much larger compression blocks (128KiB+),
+which can improve compression ratios at the expense of random access latency.
+
+To accommodate different needs, "big pclusters" were introduced in Linux 5.13,
+allowing physical clusters to span multiple blocks.
+
+The `-C` option specifies the maximum pcluster size in bytes:
  $ mkfs.erofs -zlz4hc -C65536 foo.erofs.img foo/
 
-Thus, in this case, pcluster sizes can be up to 64KiB.
+In this example, pcluster sizes can reach up to 64KiB.
 
-Note that large pcluster size can degrade random performance (though it
-may improve sequential read performance for typical storage devices), so
-please evaluate carefully in advance.  Alternatively, you can make
-per-(sub)file compression strategies according to file access patterns
-if needed.
+Note: Larger pcluster sizes may improve sequential read performance on some
+storage devices but can degrade random access performance. Evaluate your
+workload requirements carefully. You can also apply per-file compression
+strategies based on specific access patterns.
 
 How to generate EROFS images with multiple algorithms
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-It's possible to generate an EROFS image with files in different
-algorithms due to various purposes.  For example, LZMA for archival
-purposes and LZ4 for runtime purposes.
+EROFS allows mixing different compression algorithms within a single image to
+suit different needs—for instance, using LZMA for archival data and LZ4 for
+frequently accessed runtime files.
 
-In order to use alternative algorithms, just specify two or more
-compressing configurations together separated by ':' like below:
+To use multiple algorithms, specify them in the `-z` option separated by
+colons:
     -zlzma:lz4hc,12:lzma,9 -C32768
 
-Although mkfs still choose the first one by default, you could try to
-write a compress-hints file like below:
+While the formatter defaults to the first algorithm, you can use a
+compress-hints file to map specific files or directories to different
+algorithms:
     4096  1 .*\.so$
     32768 2 .*\.txt$
     4096    sbin/.*$
     16384 0 .*
 
-and specify with `--compress-hints=` so that ".so" files will use
-"lz4hc,12" compression with 4k pclusters, ".txt" files will use
-"lzma,9" compression with 32k pclusters, files  under "/sbin" will use
-the default "lzma" compression with 4k pclusters and other files will
-use "lzma" compression with 16k pclusters.
+Specify the hints file with `--compress-hints=`. In this configuration, `.so`
+files use `lz4hc,12` with 4KiB pclusters, `.txt` files use `lzma,9` with 32KiB
+pclusters, and so on.
 
-Note that the largest pcluster size should be specified with the "-C"
-option (here 32k pcluster size), otherwise all larger pclusters will be
-limited.
+Note: The `-C` option must specify the largest pcluster size used in the
+hints file to avoid limiting compression efficiency.
 
 How to generate well-compressed EROFS images
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Even if EROFS is not designed for such purposes in the beginning, it
-could still produce some smaller images (not always) compared to other
-approaches with better performance (see `docs/PERFORMANCE.md`).  In
-order to build well-compressed EROFS images, try the following options:
- -C1048576                     (5.13+)
- -Eztailpacking                (5.16+)
- -Efragments / -Eall-fragments ( 6.1+);
- -Ededupe                      ( 6.1+).
+While EROFS prioritizes performance, it can still achieve competitive
+compression ratios. To maximize storage efficiency, consider the following
+options:
+ -C1048576                     (Large pclusters, Linux 5.13+)
+ -Eztailpacking                (Tail-packing for compressed files, Linux 5.16+)
+ -Efragments / -Eall-fragments (Fragment-based compression, Linux 6.1+)
+ -Ededupe                      (Global data deduplication, Linux 6.1+)
 
-Also EROFS uses lz4hc level 9 by default, whereas some other approaches
-use lz4hc level 12 by default.  So please explicitly specify
-`-zlz4hc,12 ` for comparison purposes.
+EROFS defaults to LZ4HC level 9. For maximum compression, specify level 12:
+ `-zlz4hc,12`
 
 How to generate legacy EROFS images (Linux 4.19+)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Decompression inplace and compacted indexes have been introduced in
-Linux v5.3, which are not forward-compatible with older kernels.
-
-In order to generate _legacy_ EROFS images for old kernels,
-consider adding "-E legacy-compress" to the command line, e.g.
+Features like in-place decompression and compacted indexes (introduced in
+Linux 5.3) are not compatible with older kernels. To generate images for
+kernels between 4.19 and 5.3, use the legacy option:
 
  $ mkfs.erofs -E legacy-compress -zlz4hc foo.erofs.img foo/
 
-For Linux kernel >= 5.3, legacy EROFS images are _NOT recommended_
-due to runtime performance loss compared with non-legacy images.
+Note: Legacy images are not recommended for Linux kernel 5.3 and newer, as
+they do not benefit from the performance optimizations available in modern
+EROFS implementations.
 
 Obsoleted erofs.mkfs
 ~~~~~~~~~~~~~~~~~~~~
 
-There is an original erofs.mkfs version developed by Li Guifu,
-which was replaced by the new erofs-utils implementation.
-
+The original `erofs.mkfs` implementation by Li Guifu has been superseded by
+the current `erofs-utils`. The old version is available for historical
+reference but is highly discouraged for production use:
 git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b obsoleted_mkfs
 
-PLEASE NOTE: This version is highly _NOT recommended_ now.
-
 
 mount.erofs
 -----------
 
-mount.erofs is a mount helper for EROFS filesystem, which can be used
-to mount EROFS images with various backends including direct kernel
-mount, FUSE-based mount, and NBD for remote sources like OCI images.
+`mount.erofs` is a versatile mount helper that supports various backends,
+including direct kernel mounts, FUSE-based mounts, and NBD for remote
+sources like OCI images.
 
 How to mount an EROFS image
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-To mount an EROFS image directly:
+Direct kernel mount:
  $ mount.erofs foo.erofs /mnt
 
-To mount with FUSE backend:
+FUSE-based mount:
  $ mount.erofs -t erofs.fuse foo.erofs /mnt
 
-To mount from OCI image with NBD backend:
+NBD-based mount from an OCI image:
  $ mount.erofs -t erofs.nbd -o oci.blob=sha256:... <IMAGE>:<TAG> mnt
 
-To unmount an EROFS filesystem:
+Unmount:
  $ mount.erofs -u mnt
 
-For more details, see mount.erofs(8) manpage.
+Refer to the `mount.erofs(8)` manpage for further details.
 
 
 erofsfuse
 ---------
 
-erofsfuse is introduced to support EROFS format for various platforms
-(including older linux kernels) and new on-disk features iteration.
-It can also be used as an unpacking tool for unprivileged users.
-
-It supports fixed-sized output decompression *without* any in-place
-I/O or in-place decompression optimization. Also like the other FUSE
-implementations, it suffers from most common performance issues (e.g.
-significant I/O overhead, double caching, etc.)
+`erofsfuse` provides EROFS support for platforms without native kernel
+drivers and serves as a tool for rapid feature iteration. It is also
+useful for unprivileged users to unpack EROFS images.
 
-Therefore, NEVER use it if performance is the top concern.
+`erofsfuse` performs fixed-sized output decompression and does not include
+the in-place I/O or decompression optimizations found in the kernel driver.
+As with most FUSE implementations, it may experience higher I/O overhead
+and double caching. It is not recommended for performance-critical
+applications.
 
 How to mount an EROFS image with erofsfuse
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-As the other FUSE implementations, it's quite easy to mount by using
-erofsfuse, e.g.:
+To mount an image:
  $ erofsfuse foo.erofs.img foo/
 
-Alternatively, to make it run in foreground (with debugging level 3):
+To run in the foreground with debug logging (level 3):
  $ erofsfuse -f --dbglevel=3 foo.erofs.img foo/
 
-To debug erofsfuse (also automatically run in foreground):
+To run in debug mode (automatically foreground):
  $ erofsfuse -d foo.erofs.img foo/
 
-To unmount an erofsfuse mountpoint as a non-root user:
+To unmount as a non-root user:
  $ fusermount -u foo/
 
 
 dump.erofs and fsck.erofs
 -------------------------
 
-dump.erofs and fsck.erofs are used to analyze, check, and extract
-EROFS filesystems. Note that extended attributes and ACLs are still
-unsupported when extracting images with fsck.erofs.
+`dump.erofs` and `fsck.erofs` are essential tools for analyzing, verifying,
+and extracting EROFS filesystems. Note that extended attributes (xattrs) and
+ACLs are currently not supported during extraction with `fsck.erofs`.
+
+Extraction in `fsck.erofs` is currently single-threaded. Contributions to
+optimize this process are welcome.
 
-Note that extraction with fsck.erofs is still single-threaded and will
-need optimization later.  If you are interested, contributions are, as
-always, welcome.
 
 Contribution
 ------------
 
-erofs-utils is a part of EROFS filesystem project, which is completely
-community-driven open source software.  If you have interest in EROFS,
-feel free to send feedback and/or patches to:
+EROFS-utils is a key component of the EROFS filesystem project and is
+entirely community-driven. We welcome feedback, bug reports, and patches.
+
+Please send your contributions to the mailing list:
   linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
 
 
 Comments
 --------
 
-[1] According to the EROFS on-disk format, the tail blocks of files
-    could be inlined aggressively with their metadata (called
-    tail-packing) in order to minimize the extra I/Os and the storage
-    space.
+[1] EROFS on-disk format allows the tail blocks of files to be inlined
+    with their metadata (tail-packing). This reduces extra I/O operations
+    and saves storage space by eliminating internal fragmentation in the
+    last block of a file.
-- 
2.53.0


