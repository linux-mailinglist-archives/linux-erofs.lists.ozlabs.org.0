Return-Path: <linux-erofs+bounces-1084-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF53B95CA3
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 14:11:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWJk84534z2yGM;
	Tue, 23 Sep 2025 22:11:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758629504;
	cv=none; b=KkJT2BOGHXvo45nbsESj5rBLBM7cTuCgLTNG1E6GUIBMGIBYknN8iahL+tYgCVmXAUDoqYycfWyxrnpDgjkpERKRKcY5EWFRFjoaW4wYXl9E+LlF4+heeYp5ha1zlovf4rSSrHDqi/wrONRKVmhS8T2qDdVcAg5cDgRgugDtWl46WC+4D1u6ynndiPDXJw++kWdLVXD3P8d8HTGfwxXgibmQ3KH1vPHtboxl1lPmfy5RS76wnviBFAfZBUZmCOxTNRcgsBYyq5+j9K2SGD0urAN/CzZ8U1yuahsn7YMilCcBEfFBQp3emjUK6KfHd3HlSaxewZvi13UfstspluUH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758629504; c=relaxed/relaxed;
	bh=hvs02B+Wxw/xWZMtW5xQ3HXTkLch/tiG0eYOXSQgldk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOgRMg5GCt9jjOzC9qlJPic9dTEeCLgfZe+lqo783ORpHAkV0V/v2l/UllLBt44Ap/L9Dhi9oJMeFFm2kNL0Eh3i2bUrvjYVPn0jlgNF7rD1s1MPzw7teI4jp41JHYHprn1Szw+UVwf/edl75C52k0Ngzni+6t1Kh32xr1aENsfWlHhCjCPGUYEpzong9XZt1GdYyVJn8WdSPc5HK+J1b7OOWzO9xDhG4IDI2KrnK+ZwSRjr12Rg/Vn0nmDUBsvUjnyTXixDvxgixyXIWRgpnOiM7l+pDXFAirDco83Zm37wrlCnNJTyvXU0KLrvhUq3pICLMzMW9FL5RMCfwK8H6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C4l8n2qk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C4l8n2qk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWJk61BDhz2xck
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 22:11:40 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758629497; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hvs02B+Wxw/xWZMtW5xQ3HXTkLch/tiG0eYOXSQgldk=;
	b=C4l8n2qk0pOUjMfwgTOn6zx5FSj69rs2ij+5jg7GWtMQq91HpjzicrDxdqQXrxYiMeLgc00mJWi5frOgxye/rg9/xa5ZeQJLlwNmrHTtvKCcpf+qCNLIp6BtHhAVDoHP3+6RdDO/ewcf9epEd4HQRBGwGpWvN4kzsrXt3YWoaic=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WofQGdJ_1758629175 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 20:06:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 1/2] erofs-utils: tar: support gzip index generation
Date: Tue, 23 Sep 2025 20:06:12 +0800
Message-ID: <20250923120613.2230166-1-hsiangkao@linux.alibaba.com>
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

Let's support AWS SOCI-compatible zinfo version v2 generation.

Since an OCI image layer cannot be randomly accessed, the new gzip
index can be used for OCI gzip random access.

Example:
 $ mkfs.erofs --tar=i --gzinfo=foo.zinfo foo.tarmeta.erofs foo.tgz

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - add support for (e)stargz gzip streams.

 include/erofs/tar.h  |   7 +-
 lib/Makefile.am      |   2 +
 lib/gzran.c          | 223 +++++++++++++++++++++++++++++++++++++++++++
 lib/liberofs_gzran.h |  21 ++++
 lib/tar.c            |  20 ++++
 mkfs/main.c          |  25 ++++-
 6 files changed, 296 insertions(+), 2 deletions(-)
 create mode 100644 lib/gzran.c
 create mode 100644 lib/liberofs_gzran.h

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index 3bd4b15..cdaef31 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -24,12 +24,17 @@ struct erofs_pax_header {
 #define EROFS_IOS_DECODER_NONE		0
 #define EROFS_IOS_DECODER_GZIP		1
 #define EROFS_IOS_DECODER_LIBLZMA	2
+#define EROFS_IOS_DECODER_GZRAN		3
 
 struct erofs_iostream_liblzma;
+struct erofs_gzran_builder;
 
 struct erofs_iostream {
 	union {
-		struct erofs_vfile vf;
+		struct {
+			struct erofs_vfile vf;
+			struct erofs_gzran_builder *gb;
+		};
 		void *handler;
 #ifdef HAVE_LIBLZMA
 		struct erofs_iostream_liblzma *lzma;
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 24fddda..7487433 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -31,6 +31,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/lib/liberofs_compress.h \
       $(top_srcdir)/lib/liberofs_private.h \
       $(top_srcdir)/lib/liberofs_xxhash.h \
+      $(top_srcdir)/lib/liberofs_gzran.h \
       $(top_srcdir)/lib/liberofs_metabox.h \
       $(top_srcdir)/lib/liberofs_nbd.h \
       $(top_srcdir)/lib/liberofs_s3.h
@@ -86,3 +87,4 @@ endif
 liberofs_la_SOURCES += remotes/oci.c
 liberofs_la_CFLAGS += ${libcurl_CFLAGS} ${json_c_CFLAGS}
 liberofs_la_LDFLAGS += ${libcurl_LIBS} ${json_c_LIBS}
+liberofs_la_SOURCES += gzran.c
diff --git a/lib/gzran.c b/lib/gzran.c
new file mode 100644
index 0000000..e3b4e89
--- /dev/null
+++ b/lib/gzran.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C) 2025 Alibaba Cloud
+ */
+#include "erofs/list.h"
+#include "erofs/err.h"
+#include "liberofs_gzran.h"
+#include <stdlib.h>
+#include <zlib.h>
+
+#ifdef HAVE_ZLIB
+struct erofs_gzran_cutpoint {
+	u8	window[EROFS_GZRAN_WINSIZE];	/* preceding 32K of uncompressed data */
+	u64	outpos;			/* corresponding offset in uncompressed data */
+	u64	in_bitpos;		/* bit offset in input file of first full byte */
+};
+
+struct erofs_gzran_cutpoint_item {
+	struct erofs_gzran_cutpoint	cp;
+	struct list_head		list;
+};
+
+struct erofs_gzran_builder {
+	struct list_head items;
+	struct erofs_vfile *vf;
+	z_stream strm;
+	u64 totout, totin;
+	u32 entries;
+	u32 span_size;
+	u8 window[EROFS_GZRAN_WINSIZE];
+	u8 src[1 << 14];
+	bool initial;
+};
+
+struct erofs_gzran_builder *erofs_gzran_builder_init(struct erofs_vfile *vf,
+						     u32 span_size)
+{
+	struct erofs_gzran_builder *gb;
+	z_stream *strm;
+	int ret;
+
+	gb = malloc(sizeof(*gb));
+	if (!gb)
+		return ERR_PTR(-ENOMEM);
+	strm = &gb->strm;
+	/* initialize inflate */
+	strm->zalloc = Z_NULL;
+	strm->zfree = Z_NULL;
+	strm->opaque = Z_NULL;
+	strm->avail_in = 0;
+	strm->next_in = Z_NULL;
+	ret = inflateInit2(strm, 47);	/* automatic zlib or gzip decoding */
+	if (ret != Z_OK)
+		return ERR_PTR(-EFAULT);
+	gb->vf = vf;
+	gb->span_size = span_size;
+	gb->totout = gb->totin = 0;
+	gb->entries = 0;
+	gb->initial = true;
+	init_list_head(&gb->items);
+	return gb;
+}
+
+/* return up to 32K of data at once */
+int erofs_gzran_builder_read(struct erofs_gzran_builder *gb, char *window)
+{
+	struct erofs_gzran_cutpoint_item *ci;
+	struct erofs_gzran_cutpoint *cp;
+	z_stream *strm = &gb->strm;
+	struct erofs_vfile *vf = gb->vf;
+	int read, ret;
+	u64 last;
+
+	strm->avail_out = sizeof(gb->window);
+	strm->next_out = gb->window;
+	do {
+		if (!strm->avail_in) {
+			read = erofs_io_read(vf, gb->src, sizeof(gb->src));
+			if (read <= 0)
+				return read;
+			strm->avail_in = read;
+			strm->next_in = gb->src;
+		}
+		gb->totin += strm->avail_in;
+		gb->totout += strm->avail_out;
+
+		ret = inflate(strm, Z_BLOCK);	/* return at end of block */
+		gb->totin -= strm->avail_in;
+		gb->totout -= strm->avail_out;
+
+		if (ret == Z_NEED_DICT)
+			ret = Z_DATA_ERROR;
+		if (ret == Z_MEM_ERROR || ret == Z_DATA_ERROR)
+			return -EIO;
+		if (ret == Z_STREAM_END) {
+			inflateReset(strm);
+			gb->initial = true;
+			/* address concatenated gzip streams: e.g. (e)stargz */
+			if (strm->avail_out < sizeof(gb->window))
+				break;
+			continue;
+		}
+		ci = list_empty(&gb->items) ? NULL :
+			list_last_entry(&gb->items,
+					struct erofs_gzran_cutpoint_item,
+					list);
+		last = ci ? ci->cp.outpos : 0;
+		if ((strm->data_type & 128) && !(strm->data_type & 64) &&
+		    (gb->initial || gb->totout - last > gb->span_size)) {
+			ci = malloc(sizeof(*ci));
+			if (!ci)
+				return -ENOMEM;
+			init_list_head(&ci->list);
+			cp = &ci->cp;
+
+			cp->in_bitpos = (gb->totin << 3) | (strm->data_type & 7);
+			cp->outpos = gb->totout;
+			read = sizeof(gb->window) - strm->avail_out;
+			if (strm->avail_out)
+				memcpy(cp->window, gb->window + read, strm->avail_out);
+			if (read)
+				memcpy(cp->window + strm->avail_out, gb->window, read);
+			list_add_tail(&ci->list, &gb->items);
+			gb->entries++;
+			gb->initial = false;
+		}
+	} while (strm->avail_out);
+
+	read = sizeof(gb->window) - strm->avail_out;
+	memcpy(window, gb->window, read);
+	return read;
+}
+
+struct aws_soci_zinfo_header {
+	__le32 have;
+	__le64 span_size;
+} __packed;
+
+struct aws_soci_zinfo_ckpt {
+	__le64 in;
+	__le64 out;
+	__u8 bits;
+	u8 window[EROFS_GZRAN_WINSIZE];
+} __packed;
+
+/* Generate AWS SOCI-compatible on-disk zinfo version 2 */
+int erofs_gzran_builder_export_zinfo(struct erofs_gzran_builder *gb,
+				     struct erofs_vfile *zinfo_vf)
+{
+	union {
+		struct aws_soci_zinfo_header h;
+		struct aws_soci_zinfo_ckpt c;
+	} u;
+	struct erofs_gzran_cutpoint_item *ci;
+	u64 pos;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(u.h) != 12);
+	u.h = (struct aws_soci_zinfo_header) {
+		.have = cpu_to_le32(gb->entries),
+		.span_size = cpu_to_le64(gb->span_size),
+	};
+	ret = erofs_io_pwrite(zinfo_vf, &u.h, 0, sizeof(u.h));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(u.h))
+		return -EIO;
+
+	pos = sizeof(u.h);
+	list_for_each_entry(ci, &gb->items, list) {
+		BUILD_BUG_ON(sizeof(u.c) != 17 + EROFS_GZRAN_WINSIZE);
+		u.c.in = cpu_to_le64(ci->cp.in_bitpos >> 3);
+		u.c.out = cpu_to_le64(ci->cp.outpos);
+		u.c.bits = ci->cp.in_bitpos & 7;
+		memcpy(u.c.window, ci->cp.window, EROFS_GZRAN_WINSIZE);
+
+		ret = erofs_io_pwrite(zinfo_vf, &u.c, pos, sizeof(u.c));
+		if (ret < 0)
+			return ret;
+		if (ret != sizeof(u.c))
+			return -EIO;
+		pos += sizeof(u.c);
+	}
+	return 0;
+}
+
+int erofs_gzran_builder_final(struct erofs_gzran_builder *gb)
+{
+	struct erofs_gzran_cutpoint_item *ci, *n;
+	int ret;
+
+	ret = inflateEnd(&gb->strm);
+	if (ret != Z_OK)
+		return -EFAULT;
+	list_for_each_entry_safe(ci, n, &gb->items, list) {
+		list_del(&ci->list);
+		free(ci);
+		--gb->entries;
+	}
+	DBG_BUGON(gb->entries);
+	free(gb);
+	return 0;
+}
+#else
+struct erofs_gzran_builder *erofs_gzran_builder_init(struct erofs_vfile *vf,
+						     u32 span_size)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+int erofs_gzran_builder_read(struct erofs_gzran_builder *gb, char *window)
+{
+	return 0;
+}
+int erofs_gzran_builder_export_zinfo(struct erofs_gzran_builder *gb,
+				     struct erofs_vfile *zinfo_vf)
+{
+	return -EOPNOTSUPP;
+}
+int erofs_gzran_builder_final(struct erofs_gzran_builder *gb)
+{
+	return 0;
+}
+#endif
diff --git a/lib/liberofs_gzran.h b/lib/liberofs_gzran.h
new file mode 100644
index 0000000..4764506
--- /dev/null
+++ b/lib/liberofs_gzran.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2025 Alibaba Cloud
+ */
+#ifndef __EROFS_LIB_LIBEROFS_GZRAN_H
+#define __EROFS_LIB_LIBEROFS_GZRAN_H
+
+#include "erofs/io.h"
+
+#define EROFS_GZRAN_WINSIZE	32768
+
+struct erofs_gzran_builder;
+
+struct erofs_gzran_builder *erofs_gzran_builder_init(struct erofs_vfile *vf,
+						     u32 span_size);
+int erofs_gzran_builder_read(struct erofs_gzran_builder *gb, char *window);
+int erofs_gzran_builder_export_zinfo(struct erofs_gzran_builder *gb,
+				     struct erofs_vfile *zinfo_vf);
+int erofs_gzran_builder_final(struct erofs_gzran_builder *gb);
+
+#endif
diff --git a/lib/tar.c b/lib/tar.c
index 6438fae..b778081 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -17,6 +17,7 @@
 #endif
 #include "liberofs_base64.h"
 #include "liberofs_cache.h"
+#include "liberofs_gzran.h"
 
 /* This file is a tape/volume header.  Ignore it on extraction.  */
 #define GNUTYPE_VOLHDR 'V'
@@ -65,6 +66,9 @@ void erofs_iostream_close(struct erofs_iostream *ios)
 		free(ios->lzma);
 #endif
 		return;
+	} else if (ios->decoder == EROFS_IOS_DECODER_GZRAN) {
+		erofs_gzran_builder_final(ios->gb);
+		return;
 	}
 	erofs_io_close(&ios->vf);
 }
@@ -105,6 +109,14 @@ int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 #else
 		return -EOPNOTSUPP;
 #endif
+	} else if (decoder == EROFS_IOS_DECODER_GZRAN) {
+		ios->vf.fd = fd;
+		ios->feof = false;
+		ios->sz = 0;
+		ios->bufsize = EROFS_GZRAN_WINSIZE * 2;
+		ios->gb = erofs_gzran_builder_init(&ios->vf, 4194304);
+		if (IS_ERR(ios->gb))
+			return PTR_ERR(ios->gb);
 	} else {
 		ios->vf.fd = fd;
 		fsz = lseek(fd, 0, SEEK_END);
@@ -204,6 +216,14 @@ int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
 #else
 			return -EOPNOTSUPP;
 #endif
+		} else if (ios->decoder == EROFS_IOS_DECODER_GZRAN) {
+			ret = erofs_gzran_builder_read(ios->gb, ios->buffer + rabytes);
+			if (ret < 0)
+				return ret;
+			ios->tail += ret;
+			DBG_BUGON(ios->tail > ios->bufsize);
+			if (!ret)
+				ios->feof = true;
 		} else {
 			ret = erofs_io_read(&ios->vf, ios->buffer + rabytes,
 					    ios->bufsize - rabytes);
diff --git a/mkfs/main.c b/mkfs/main.c
index 73385cd..fb69a5f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -28,6 +28,7 @@
 #include "erofs/fragments.h"
 #include "erofs/rebuild.h"
 #include "../lib/compressor.h"
+#include "../lib/liberofs_gzran.h"
 #include "../lib/liberofs_metabox.h"
 #include "../lib/liberofs_oci.h"
 #include "../lib/liberofs_private.h"
@@ -71,6 +72,7 @@ static struct option long_options[] = {
 #ifdef HAVE_ZLIB
 	{"gzip", no_argument, NULL, 518},
 	{"ungzip", optional_argument, NULL, 518},
+	{"gzinfo", optional_argument, NULL, 535},
 #endif
 #ifdef HAVE_LIBLZMA
 	{"unlzma", optional_argument, NULL, 519},
@@ -233,6 +235,9 @@ static void usage(int argc, char **argv)
 #ifdef HAVE_LIBLZMA
 		" --unxz[=X]            try to filter the tarball stream through xz/lzma/lzip\n"
 		"                       (and optionally dump the raw stream to X together)\n"
+#endif
+#ifdef HAVE_ZLIB
+		" --gzinfo[=X]          generate AWS SOCI-compatible zinfo in order to support random gzip access\n"
 #endif
 		" --vmdk-desc=X         generate a VMDK descriptor file to merge sub-filesystems\n"
 #ifdef EROFS_MT_ENABLED
@@ -298,6 +303,7 @@ static bool valid_fixeduuid;
 static unsigned int dsunit;
 static int tarerofs_decoder;
 static FILE *vmdk_dcf;
+static char *mkfs_aws_zinfo_file;
 
 static int erofs_mkfs_feat_set_legacy_compress(struct erofs_importer_params *params,
 					       bool en, const char *val,
@@ -1368,6 +1374,11 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			source_mode = EROFS_MKFS_SOURCE_OCI;
 			break;
 #endif
+		case 535:
+			if (optarg)
+				mkfs_aws_zinfo_file = strdup(optarg);
+			tarerofs_decoder = EROFS_IOS_DECODER_GZRAN;
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1943,7 +1954,19 @@ exit:
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
 	erofs_diskbuf_exit();
-	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
+	if (!err && source_mode == EROFS_MKFS_SOURCE_TAR) {
+		if (mkfs_aws_zinfo_file) {
+			struct erofs_vfile vf;
+			int fd;
+
+			fd = open(mkfs_aws_zinfo_file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+			if (fd < 0) {
+				err = -errno;
+			} else {
+				vf = (struct erofs_vfile){ .fd = fd };
+				err = erofs_gzran_builder_export_zinfo(erofstar.ios.gb, &vf);
+			}
+		}
 		erofs_iostream_close(&erofstar.ios);
 		if (erofstar.ios.dumpfd >= 0)
 			close(erofstar.ios.dumpfd);
-- 
2.43.5


