Return-Path: <linux-erofs+bounces-2307-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKwRH6BFjWlj0gAAu9opvQ
	(envelope-from <linux-erofs+bounces-2307-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 04:14:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B3C129EEE
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 04:14:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBL4r1V3yz2xcB;
	Thu, 12 Feb 2026 14:14:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770866076;
	cv=none; b=dt9oqu6zbOL9dMLrc7G5Mq8Y9fg+4y3sw4D+j5i7/XQ/RFlpdKPKyAdCUUvdiFdxuYAG6e2Bn1htZMC99cYPN6ZS9C6OC+P7/Q/2ZA/oEgcVAOuYJ9xAkYdlQuHegOHYka/mHXP/ORZKslW6xvAQv15dJr75fH19GPzem6mHIg+RmA7AgCLMBpz33tTqWipfkyvdcjgT8rPc18duojxcO0her11Bp39ZNvC2le7dPqcUq6cMMiJcoEVb8y2Bpu7zMm4CABZh6A9Dp4CMCWOiTd+tr74nZjuRgI0YSCnOcX25eVpYKphqMZybh3Ihy5TQTRiy2vN3okRHPaXg11YAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770866076; c=relaxed/relaxed;
	bh=vGdp4Bsffo+p1U/bBHOZu9G1+GZPTyDYfUi98jQpLhU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jeea5C5m2HBP8RiM/PC0eu61p1WdXVqgMZP66bhg3r85qsGEznG18WNloYy5O8op9o7+sH7X9329c5NZQ2+UJlyILesmP89od+0u0TJTDdBbdodsG+mr6VaguNAgHkxLwN9/r/Y8NyXa0IPGsJPFrclthBJC1qCGvRg4H7MT1VZ97Ij62mrynWGUC2wD4Gp68CqK3rqs5jeXqUk+v/AbW0zJXlEi0+BXEhMXiT3vsTz43uCcysHpxRkxGrhc3DGZrYhN45B5nWqpZNcgW99bnXJ0WMKGhHnRGqD8eEmEJDpLw27RB2hnhlWcBxceqC7r/qilsCAIiXs06VjS31eOxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aVcVBdtT; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aVcVBdtT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBL4n1FXYz2xHX
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Feb 2026 14:14:30 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vGdp4Bsffo+p1U/bBHOZu9G1+GZPTyDYfUi98jQpLhU=;
	b=aVcVBdtTHqcn+Uos5UVQjbwE0rNr+rJJRy4mZ+C472g7z7GyRkPhBb35osH9wp4W+f7RoO+fQ
	1U7irYxw9lP6Poq/3emE3VfKx6s0T1oRpSfyPqIe7ypBNigau1DvZtkPTk3iv3Ge/zvbyRBgqMA
	ZbCRZlfrZgW56Py9NhsrfGw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fBKzG2m5GzRhRT;
	Thu, 12 Feb 2026 11:09:46 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A9524056A;
	Thu, 12 Feb 2026 11:14:24 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 12 Feb
 2026 11:14:24 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [RFC PATCH] erofs-utils: manpage: document missing options for mkfs.erofs
Date: Thu, 12 Feb 2026 11:14:36 +0800
Message-ID: <20260212031437.481441-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_FILL_THIS_FORM_SHORT autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2307-lists,linux-erofs=lfdr.de];
	TO_DN_NONE(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A1B3C129EEE
X-Rspamd-Action: no action

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
The mkfs.erofs documentation has long been overdue for an update.
This patch attempts to refresh the documentation, but I'm still not
entirely clear about a significant portion of the options, particularly
the interactions among the --clean, --incremental, and their interaction
with rebuild mode. I hope others can help review this patch.

 man/mkfs.erofs.1 | 220 +++++++++++++++++++++++++++++++++++++++++++----
 mkfs/main.c      |   2 +-
 2 files changed, 206 insertions(+), 16 deletions(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 4316214..eee068d 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -17,7 +17,19 @@ achieve high performance for embedded devices with limited memory since it has
 unnoticable memory overhead and page cache thrashing.
 .PP
 mkfs.erofs is used to create such EROFS filesystem \fIDESTINATION\fR image file
-from \fISOURCE\fR directory or tarball.
+from various \fISOURCE\fR, where \fISOURCE\fR can be:
+.RS
+.IP \(bu 2
+a local directory
+.IP \(bu 2
+a (zipped) tarball
+.IP \(bu 2
+an S3 bucket or a prefix within it
+.IP \(bu 2
+an OCI image reference
+.IP \(bu 2
+other EROFS image(s), see \fIREBUILD MODE\fR below
+.RE
 .SH OPTIONS
 .TP
 .BI "\-z " compression-algorithm \fR[\fP, # \fR][\fP: ... \fR]\fP
@@ -52,6 +64,9 @@ feature, usually prefix the extended option name with a caret ('^') character.
 The following extended options are supported:
 .RS 1.2i
 .TP
+.BI 48bit
+Enable 48-bit block addressing to support larger block addresses. (Linux v6.15+)
+.TP
 .BI all-fragments
 Forcely record the whole files into a special inode for better compression and
 it may take an argument as the pcluster size of the packed inode in bytes.
@@ -63,6 +78,10 @@ the filesystem. May further reduce image size when used with
 .BR -E\ fragments .
 (Linux v6.1+)
 .TP
+.BI dot-omitted
+Omit the "." (dot) directory entry in all directories to reduce metadata
+overhead.
+.TP
 .BI force-inode-compact
 Force generation of compact (32-byte) inodes.
 .TP
@@ -102,6 +121,15 @@ for those images, however, there could be other use cases too.
 Disable "inplace decompression" and "compacted indexes",
 for compatibility with Linux pre-v5.4.
 .TP
+.BI nosbcrc
+Disable CRC32 checksum for the filesystem superblock.
+.TP
+.BI plain-xattr-prefixes
+Store long extended attribute name prefixes directly on disk rather than in
+special inodes. By default, long xattr name prefixes are placed in metabox_inode
+(if metabox is enabled) or packed_inode (if fragments is enabled). This option
+forces them to be stored as plain on-disk structures.
+.TP
 .B xattr-name-filter
 Enable a name filter for extended attributes to optimize negative lookups.
 (Linux v6.6+).
@@ -116,12 +144,29 @@ Set the volume label for the filesystem to
 .IR volume-label .
 The maximum length of the volume label is 15 bytes.
 .TP
+.BI "\-m " #\fR[\fP: algorithm \fR]\fP
+Enable metadata compression with #-byte clusters in a metabox inode;
+optionally specify an algorithm (defaults to data compression algorithm if omitted).
+.TP
+.BI "\-\-MZ\fR[\fP=<0|[id]>\fR]\fP"
+Put inode metadata ('i') and/or directory data ('d') into the separate metadata zone.
+This improves spatial locality of metadata layout within the image, which is beneficial
+for on-demand metadata access.
+.TP
 .BI "\-T " #
 Specify a UNIX timestamp for image creation time for reproducible builds.
 If \fI--mkfs-time\fR is not specified, it will behave as \fI--all-time\fR:
 setting all files to the specified UNIX timestamp instead of using the
 modification times of the source files.
 .TP
+.B \-\-all-time
+(used together with \fB-T\fR) set all files to the fixed timestamp. This is the
+default.
+.TP
+.B \-\-mkfs-time
+(used together with \fB-T\fR) the given timestamp is only applied to the build
+time.
+.TP
 .BI "\-U " UUID
 Set the universally unique identifier (UUID) of the filesystem to
 .IR UUID .
@@ -142,9 +187,11 @@ generate a new randomly-generated UUID
 .B \-\-all-root
 Make all files owned by root.
 .TP
-.B \-\-all-time
-(used together with \fB-T\fR) set all files to the fixed timestamp. This is the
-default.
+.BI "\-\-async-queue-limit=" #
+Specify the maximum number of entries in the multi-threaded job queue.
+.TP
+.BI "\-\-aufs"
+Replace aufs special files with overlayfs metadata.
 .TP
 .BI "\-\-blobdev " file
 Specify an extra blob device to store chunk-based data.
@@ -152,6 +199,27 @@ Specify an extra blob device to store chunk-based data.
 .BI "\-\-chunksize " #
 Generate chunk-based files with #-byte chunks.
 .TP
+.BI "\-\-clean=" MODE
+Run full clean build (default) with the given \fIMODE\fR:
+
+\fIMODE\fR may be one of \fBdata\fR, \fBrvsp\fR, or \fB0\fR.
+
+\fBdata\fR: Import complete file data from the source into the destination
+image, creating a fully self-contained EROFS image. This mode is useful when
+you need a standalone image that doesn't depend on external blob devices.
+
+\fBrvsp\fR: (Only works with \fI--tar\fR or \fIREBUILD MODE\fR) Reserve space for file data in the destination image without
+copying the actual content. The file data will need to be filled in later
+through other means. This is useful for creating sparse images or when the
+actual data will be populated separately.
+
+\fB0\fR: (Only works with \fI--s3\fR) Fill all inode data with zeros.
+.TP
+.BI "\-\-incremental=" MODE
+Run an incremental build where DESTINATION is an existing EROFS image,
+and the data specified by SOURCE will be incrementally appended to the image.
+\fIMODE\fR has the same meaning as in \fB\-\-clean\fR above.
+.TP
 .BI "\-\-compress-hints " file
 Apply a per-file compression strategy. Each line in
 .I file
@@ -159,9 +227,11 @@ is defined by
 tokens separated by spaces in the following form.  Optionally, instead of
 the given primary algorithm, alternative algorithms can be specified with
 \fIalgorithm-index\fR explicitly:
-.RS 1.2i
+.sp
+.in +4n
 <pcluster-size-in-bytes> [algorithm-index] <match-pattern>
-.RE
+.in
+.sp
 .IR match-pattern s
 are extended regular expressions, matched against absolute paths within
 the output filesystem, with no leading /.
@@ -216,11 +286,8 @@ When this option is used together with
 the final file gids are
 set to \fIGID\fR + \fIGID-OFFSET\fR.
 .TP
-\fB\-V\fR, \fB\-\-version\fR
-Print the version number and exit.
-.TP
-\fB\-h\fR, \fB\-\-help\fR
-Display help string and exit.
+.BI "\-\-hard-dereference"
+Dereference hardlinks and add links as separate inodes.
 .TP
 .B "\-\-ignore-mtime"
 Ignore the file modification time whenever it would cause \fBmkfs.erofs\fR to
@@ -231,18 +298,68 @@ can reduce total metadata size. Implied by
 .BI "\-\-max-extent-bytes " #
 Specify maximum decompressed extent size in bytes.
 .TP
-.B \-\-mkfs-time
-(used together with \fB-T\fR) the given timestamp is only applied to the build
-time.
+.BI "\-\-mount-point=" path
+Specify the prefix of target filesystem path (default: /).
+.TP
+.BI "\-\-oci\fR[\fP=<f|i>\fR]\fP"
+Generate a full (f) or index-only (i) image from OCI remote source.
+Additional options can be specified:
+.RS 1.2i
+.TP
+.BI platform= platform
+Specify the platform (default: linux/amd64).
+.TP
+.BI layer= #
+Specify the layer index to extract (0-based; omit to extract all layers).
+.TP
+.BI blob= digest
+Specify the blob digest to extract (omit to extract all layers).
+.TP
+.BI username= username
+Username for authentication (optional).
+.TP
+.BI password= password
+Password for authentication (optional).
+.TP
+.B insecure
+Use HTTP instead of HTTPS (optional).
+.RE
+.TP
+.BI "\-\-offset=" #
+Skip # bytes at the beginning of the image.
+.TP
+.BI "\-\-ovlfs-strip\fR[\fP=<0|1>\fR]\fP"
+Strip overlayfs metadata in the target image (e.g. whiteouts).
 .TP
 .B "\-\-preserve-mtime"
-Use extended inodes instead of compact inodes if the file modification time
+Use extended inodes instead of compact inodes if the file modifi1cation time
 would overflow compact inodes. This is the default. Overrides
 .BR --ignore-mtime .
 .TP
 .B "\-\-quiet"
 Quiet execution (do not write anything to standard output.)
 .TP
+.BI "\-\-root-xattr-isize=" #
+Ensure the inline xattr size of the root directory is # bytes at least.
+.TP
+.BI "\-\-s3=" endpoint
+Generate an image from S3-compatible object store.
+Additional options can be specified:
+.RS 1.2i
+.TP
+.BI passwd_file= file
+S3FS-compatible password file, with the format of "accessKey:secretKey" in the first line.
+.TP
+.BI urlstyle= style
+S3 API calling style (vhost or path) (default: vhost).
+.TP
+.BI sig= version
+S3 API signature version (2 or 4) (default: 2).
+.TP
+.BI region= code
+Region code in which endpoint belongs to (required for sig=4).
+.RE
+.TP
 .BI "\-\-sort=" MODE
 Inode data sorting order for tarballs as input.
 
@@ -271,6 +388,10 @@ filesystem with other data-only layers.
 to a tarball except that file data is not present after each file header.
 It can improve performance especially when \fISOURCE\fR is not seekable.
 .TP
+.BI "\-\-gzinfo\fR[\fP=" file \fR]\fP
+(used together with \fI--tar\fR) Generate AWS SOCI-compatible zinfo to support random gzip access.
+Source file must be a gzip-compressed tarball.
+.TP
 .BI "\-\-uid-offset=" UIDOFFSET
 Add \fIUIDOFFSET\fR to all file UIDs.
 When this option is used together with
@@ -290,11 +411,80 @@ be dumped together.
 Generate a VMDK descriptor file to merge sub-filesystems, which can be used
 for tar index or rebuild mode.
 .TP
+.BI "\-\-workers=" #
+Set the number of worker threads to # (default: 12).
+.TP
+.BI "\-\-xattr-inode-digest=" name
+Specify extended attribute name to record inode digests.
+.TP
 .BI "\-\-xattr-prefix=" PREFIX
 Specify a customized extended attribute namespace prefix for space saving,
 e.g. "trusted.overlay.".  You may give multiple
 .B --xattr-prefix
 options (Linux v6.4+).
+.TP
+.BI "\-\-zD\fR[\fP=<0|1>\fR]\fP"
+Specify directory compression: 0=disable [default], 1=enable.
+.TP
+.BI "\-\-zfeature-bits=" #
+Toggle filesystem compression features according to given bits #.
+Each bit in the value corresponds to a specific compression feature:
+.RS 1.2i
+.nf
+.ft CW
+  7 6 5 4 3 2 1 0  (bit position)
+  | | | | | | | |
+  | | | | | | | +-- Bit 0 (1)   : legacy-compress
+  | | | | | | +---- Bit 1 (2)   : ztailpacking
+  | | | | | +------ Bit 2 (4)   : fragments
+  | | | | +-------- Bit 3 (8)   : all-fragments
+  | | | +---------- Bit 4 (16)  : dedupe
+  | | +------------ Bit 5 (32)  : fragdedupe
+  | +-------------- Bit 6 (64)  : 48bit
+  +---------------- Bit 7 (128) : dot-omitted
+.ft
+.fi
+.RE
+.IP
+For example,
+.B --zfeature-bits=6
+(binary: 0000 0110) enables ztailpacking (bit 1) and fragments (bit 2).
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Print the version number and exit.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help string and exit.
+.TP
+.B REBUILD MODE
+.B Rebuild mode
+is an experimental feature that allows
+.B mkfs.erofs
+to generate a new EROFS image from one or more existing EROFS images passed as
+\fISOURCE\fR(s).
+This mode is particularly useful for merging multiple EROFS images or creating
+index-only metadata images that reference data in the source images.
+
+When SOURCE contains one or more EROFS image files,
+.B mkfs.erofs
+automatically enters rebuild mode. The behavior is controlled by the
+.B \-\-clean
+or
+.B \-\-incremental
+options, which determine how file data is handled:
+.RS 1.2i
+.TP
+.I Default mode (blob index)
+The generated image contains only metadata (inodes, dentries, and xattrs).
+File data is referenced through chunk-based indexes pointing to the original
+source images, which act as external blob devices. This creates a compact
+metadata layer suitable for layered filesystem scenarios, similar to container
+image layers.
+.TP
+.I rvsp mode
+\fB\-\-clean=rvsp\fR or \fB\-\-incremental=rvsp\fR: Reserve space for file
+data without copying actual content, useful for creating sparse images.
+.RE
 .SH AUTHOR
 This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
 Miao Xie <miaoxie@huawei.com> and Gao Xiang <xiang@kernel.org> with
diff --git a/mkfs/main.c b/mkfs/main.c
index a948b2e..2cb1c6d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -169,7 +169,7 @@ static void usage(int argc, char **argv)
 	}
 	printf(
 		" -C#                    specify the size of compress physical cluster in bytes\n"
-		" -EX[,...]              X=extended options\n"
+		" -EX[,...]              X=extended options, see mkfs.erofs(1) manual for details\n"
 		" -L volume-label        set the volume label (maximum 15 bytes)\n"
 		" -m#[:X]                enable metadata compression (# = physical cluster size in bytes;\n"
 		"                                                     X = another compression algorithm for metadata)\n"
-- 
2.47.3


