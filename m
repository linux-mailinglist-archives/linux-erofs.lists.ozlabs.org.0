Return-Path: <linux-erofs+bounces-2313-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA+BEp7TjmlFFQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2313-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Feb 2026 08:32:46 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880913397B
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Feb 2026 08:32:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fC3m86Qzjz2yY0;
	Fri, 13 Feb 2026 18:32:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770967960;
	cv=none; b=IsbjokBcKMwV1Diebeoimg0qSkf4wKjHLkvKOSHX5aclQgouNA3pz9C7ck3OCBvYv5mtJif3Jox/mKwc4wOahGCYb/bAAP5It1iqOawnxOujP0IPFnnS4QPdBHU7tpn8qdKjz9LFup04A8OvTkBJbwjlXPPIiaQUCYDeePqRLdNeXc/rYyqxZTs7t9l6NHdQeFqDa/coEXmKHgx71oOF1p+WWkuLtOhEx872P/oW6cCuKOOj8fJvjU4A6L+7c4Gy8BT35yoEkpINB/3o8PEmnoGZFW9YleheITzWt50iPjjowNbj1lzaV/XrgEH67erp6PZukUakcP56+PQ3AyjR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770967960; c=relaxed/relaxed;
	bh=AV+xw1+/PPCl7s8TDk3tdWtTZSGodxcjSqnkQpBYj3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NpBEJ27HhwlsyRNtAlvwY+UGkZUvtOxd/h7tiSj0Uo3aOu7TPTZcj3+Q8rV5ZMwMUZe7hcZoAfaWiQLuV+GMItGJvmKs51Vgw3OGGHv/kZa5nGzFx9/BRpAFTot6zZjy2DSLD8fGcWcmX1cAybmH7fxkRiBdmLcG9OehSLiSa1aeaIYnbHmsT77H9S6+HYEFDyr0pQOsNQdZiE04Rxj84h8ncUgqydqilwhREdKMIdEdPBSSF879bN514uW4ojUYaclGQz3NKQDxyBMTMmZy9NqzMoS8QNnxL863bA7JhONc+sEp4sv57UnxoLZNN7HuBC4p1bEi8VZdrLmI4sCPAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3bxBwC3e; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3bxBwC3e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fC3m6089jz2xdY
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Feb 2026 18:32:36 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AV+xw1+/PPCl7s8TDk3tdWtTZSGodxcjSqnkQpBYj3w=;
	b=3bxBwC3eGpz+WrlyWiRVwMLQ4SU7+f13zKRyIRb17QLWKXaOeovXv81O7x/P/uLIA1h40LhGv
	Kyw2v8uxJ7sL7ZlWrLkaleD90ASOrXYIu+Q38PDbyakU4HEUV1S/zVcUYlbehFm9HNuUJouSGbv
	7orW4zSlIl9FVIOTIltf1rI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fC3fZ1FJyzKm5n;
	Fri, 13 Feb 2026 15:27:50 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 4810140539;
	Fri, 13 Feb 2026 15:32:30 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 13 Feb
 2026 15:32:29 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 1/2] erofs-utils: manpage: document missing options for mkfs.erofs
Date: Fri, 13 Feb 2026 15:32:40 +0800
Message-ID: <20260213073241.525158-1-zhaoyifan28@huawei.com>
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2313-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4880913397B
X-Rspamd-Action: no action

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 man/mkfs.erofs.1 | 267 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 248 insertions(+), 19 deletions(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 4316214..695ae99 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -17,17 +17,21 @@ achieve high performance for embedded devices with limited memory since it has
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
-.BI "\-z " compression-algorithm \fR[\fP, # \fR][\fP: ... \fR]\fP
-Set a primary algorithm for data compression, which can be set with an
-optional compression level. Alternative algorithms could be specified
-and separated by colons.  See the output of
-.B mkfs.erofs \-\-help
-for a listing of the algorithms that \fBmkfs.erofs\fR is compiled with
-and what their respective level ranges are.
-.TP
 .BI "\-b " block-size
 Set the fundamental block size of the filesystem in bytes.  In other words,
 specify the smallest amount of data that can be accessed at a time.  The
@@ -40,9 +44,6 @@ This may cause the big pcluster feature to be enabled (Linux v5.13+).
 .BI "\-d " #
 Specify the level of debugging messages. The default is 2, which shows basic
 warning messages.
-.TP
-.BI "\-x " #
-Limit how many xattrs will be inlined. The default is 2.
 Disables storing xattrs if < 0.
 .TP
 .BI "\-E " [^]extended-option \fR[\fP, ... \fR]\fP
@@ -52,6 +53,9 @@ feature, usually prefix the extended option name with a caret ('^') character.
 The following extended options are supported:
 .RS 1.2i
 .TP
+.BI 48bit
+Enable 48-bit block addressing to support larger block addresses. (Linux v6.15+)
+.TP
 .BI all-fragments
 Forcely record the whole files into a special inode for better compression and
 it may take an argument as the pcluster size of the packed inode in bytes.
@@ -63,6 +67,10 @@ the filesystem. May further reduce image size when used with
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
@@ -102,6 +110,15 @@ for those images, however, there could be other use cases too.
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
@@ -111,11 +128,18 @@ Pack the tail part (pcluster) of compressed files into its metadata to save
 more space and the tail part I/O. (Linux v5.17+)
 .RE
 .TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help string and exit.
+.TP
 .BI "\-L " volume-label
 Set the volume label for the filesystem to
 .IR volume-label .
 The maximum length of the volume label is 15 bytes.
 .TP
+.BI "\-m " #\fR[\fP: algorithm \fR]\fP
+Enable metadata compression with #-byte clusters in a metabox inode (Linux v6.17+);
+optionally specify an algorithm (defaults to data compression algorithm if omitted).
+.TP
 .BI "\-T " #
 Specify a UNIX timestamp for image creation time for reproducible builds.
 If \fI--mkfs-time\fR is not specified, it will behave as \fI--all-time\fR:
@@ -139,6 +163,20 @@ clear the file system UUID
 generate a new randomly-generated UUID
 .RE
 .TP
+\fB\-V\fR, \fB\-\-version\fR
+Print the version number and exit.
+.TP
+.BI "\-x " #
+Limit how many xattrs will be inlined. The default is 2.
+.TP
+.BI "\-z " compression-algorithm \fR[\fP, # \fR][\fP: ... \fR]\fP
+Set a primary algorithm for data compression, which can be set with an
+optional compression level. Alternative algorithms could be specified
+and separated by colons.  See the output of
+.B mkfs.erofs \-\-help
+for a listing of the algorithms that \fBmkfs.erofs\fR is compiled with
+and what their respective level ranges are.
+.TP
 .B \-\-all-root
 Make all files owned by root.
 .TP
@@ -146,12 +184,55 @@ Make all files owned by root.
 (used together with \fB-T\fR) set all files to the fixed timestamp. This is the
 default.
 .TP
+.BI "\-\-async-queue-limit=" #
+Specify the maximum number of entries in the multi-threaded job queue.
+.TP
+.BI "\-\-aufs"
+Replace aufs special files with overlayfs metadata.
+.TP
 .BI "\-\-blobdev " file
 Specify an extra blob device to store chunk-based data.
 .TP
 .BI "\-\-chunksize " #
 Generate chunk-based files with #-byte chunks.
 .TP
+.BI "\-\-clean=" MODE
+Run full clean build with the given \fIMODE\fR, which could be one of \fBdata\fR, \fBrvsp\fR, or \fB0\fR.
+
+If \fB\-\-clean\fR is specified without an explicit value, it is treated as
+\fB\-\-clean=data\fR.
+
+\fBdata\fR: Import complete file data from the source into the destination
+image, creating a fully self-contained EROFS image. This mode is useful when
+you need a standalone image that doesn't depend on external blob devices.
+
+\fBrvsp\fR: Reserve space for file data in the destination image without
+copying the actual content. The file data will need to be filled in later
+through other means. This is useful for creating sparse images or when the
+actual data will be populated separately.
+
+\fB0\fR:Fill all inode data with zeros.
+
+Source-specific support for \fIMODE\fR:
+.RS 1.2i
+.TP
+.I Local directory source
+Only \fBdata\fR is supported. \fBrvsp\fR and \fB0\fR will be ignored.
+.TP
+.I Tar source (\fB\-\-tar\fR)
+\fBdata\fR and \fBrvsp\fR are supported. \fB0\fR will be ignored.
+Note that \fBrvsp\fR takes precedence over \fB--tar=i\fR or \fB--tar=headerball\fR.
+.TP
+.I Rebuild mode
+Only \fBrvsp\fR is supported.
+.TP
+.I S3 source (\fB\-\-s3\fR)
+\fBdata\fR and \fB0\fR are supported.
+.TP
+.I OCI source (\fB\-\-oci\fR)
+Only \fBdata\fR is supported.
+.RE
+.TP
 .BI "\-\-compress-hints " file
 Apply a per-file compression strategy. Each line in
 .I file
@@ -159,9 +240,11 @@ is defined by
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
@@ -216,11 +299,12 @@ When this option is used together with
 the final file gids are
 set to \fIGID\fR + \fIGID-OFFSET\fR.
 .TP
-\fB\-V\fR, \fB\-\-version\fR
-Print the version number and exit.
+.BI "\-\-gzinfo\fR[\fP=" file \fR]\fP
+(used together with \fI--tar\fR) Generate AWS SOCI-compatible zinfo to support random gzip access.
+Source file must be a gzip-compressed tarball.
 .TP
-\fB\-h\fR, \fB\-\-help\fR
-Display help string and exit.
+.BI "\-\-hard-dereference"
+Dereference hardlinks and add links as separate inodes.
 .TP
 .B "\-\-ignore-mtime"
 Ignore the file modification time whenever it would cause \fBmkfs.erofs\fR to
@@ -228,6 +312,29 @@ use extended inodes over compact inodes. When not using a fixed timestamp, this
 can reduce total metadata size. Implied by
 .BR "-E force-inode-compact" .
 .TP
+.BI "\-\-incremental=" MODE
+Run an incremental build where DESTINATION is an existing EROFS image,
+and the data specified by SOURCE will be incrementally appended to the image.
+\fIMODE\fR has the same meaning as in \fB\-\-clean\fR above.
+Incremental build is unsupported for \fB\-\-s3\fR and \fB\-\-oci\fR sources.
+
+If \fB\-\-incremental\fR is specified without an explicit value, it is treated
+as \fB\-\-incremental=data\fR.
+
+Source-specific support for \fIMODE\fR:
+.RS 1.2i
+.TP
+.I Local directory source
+Only \fBdata\fR is supported. \fBrvsp\fR and \fB0\fR will be ignored.
+.TP
+.I Tar source (\fB\-\-tar\fR)
+\fBdata\fR and \fBrvsp\fR are supported. \fB0\fR will be ignored.
+Note that \fBrvsp\fR takes precedence over \fB--tar=i\fR or \fB--tar=headerball\fR.
+.TP
+.I Rebuild mode
+Only \fBrvsp\fR is supported.
+.RE
+.TP
 .BI "\-\-max-extent-bytes " #
 Specify maximum decompressed extent size in bytes.
 .TP
@@ -235,14 +342,73 @@ Specify maximum decompressed extent size in bytes.
 (used together with \fB-T\fR) the given timestamp is only applied to the build
 time.
 .TP
+.BI "\-\-mount-point=" path
+Specify the prefix of target filesystem path (default: /).
+.TP
+.BI "\-\-MZ\fR[\fP=<0|[id]>\fR]\fP"
+Put inode metadata ('i') and/or directory data ('d') into the separate metadata zone.
+This improves spatial locality of metadata layout within the image, which is beneficial
+for on-demand metadata access.
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
+.TP
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
 
@@ -290,11 +456,74 @@ be dumped together.
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
-- 
2.47.3


