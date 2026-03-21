Return-Path: <linux-erofs+bounces-2914-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEhAKkq5vmksYgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2914-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7792E618B
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdNdK6Tx8z2ydq;
	Sun, 22 Mar 2026 02:29:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774106949;
	cv=none; b=NMoWUbaAVt20TwfT6GojOdsOI+ETS7CjnKw4xbSdYoFjEzudS/Agc5LWP2T/i2xSzGrv0uKO5BgJyBp0ecw9OPpO8Pg/DcerJfsl+r4B51CiSdEFaiDpKMui/G8bSFRFcVg/ilFBYHcPy7N4yrksvW1QCyyc8VLxcsPX2tnovbQ8v8NjDocAIr+8PwMsKE7sDSf3eZfnJTy+9KB/g0B4WnRqfM8cwn276m3AaOa/ZUcWxXMU4BFz3D1B5i/OEehTAc/G9rmhlGQzmqXjYUNVIVuEotMISWz97rHxHA2++L9nChvUf3Ew6pC4U2f1zaacUqNjwxqd/8JkitepC2ApcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774106949; c=relaxed/relaxed;
	bh=eAL+TSfdFSEA1fM8RdScpbBSoZeZ13xnErm/N5MfbbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILrTRUjQU0Dcso4+eHCndMGGyvKuoHVpQQTgbqDukrMduBulYhI9hb5JSbCvXEfsObhnX+1UHV6o1TDIIjDBJXLUswfWAakPEA1ygpXwOsaSdv2lnckwe68G9YHDdb0th1SGDPJP0MVqcwDRYJXkimHKzGO1qq8tqM7amcYhRufkxx5/bQTLBVXYVtQiktFQSjYMha9eqZ7ruV8E8fUno1jQ+NrxLOf7TC5kDO/QDyx/nIZf/FKoc7gFRD0Ye2Z1YvsDp+X77wS1wo+fSxPNVoUM7okevpE3yHp7VOIsY3IbwtPYrMBL2pVRhaKa5k5acWf8zyEHrVwpv3MYKhevVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R+pPkqYX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R+pPkqYX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdNdJ4Ss7z2yC9
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 02:29:08 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-35b905a05a8so1541710a91.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774106946; x=1774711746; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAL+TSfdFSEA1fM8RdScpbBSoZeZ13xnErm/N5MfbbY=;
        b=R+pPkqYXENBded1tvh80p+sQrM5TXH60K+RPvHCw9Gudc7xwfL/UFUE3lZNf4/4AUd
         +fLcNgJACFUs+RfUGp3WDz/fujUWNN9cSPRXIXGP6Vn592erZa2NB7YRUaXsPaaveOhK
         VmaLgg+zvayMhSciNNIzIbGgVods/lPmCifVjm4SRaqNl4CgGR1RgcRv6U8nnsrkr2/6
         fcD11EQNDKTMgFCHbEbeLVbPS0aULmXpenIlZtYZWAksQRnv/ERCm1jGCEd3GQezBLbN
         6+wD+Duk9X1pqltDrPGC0YKe6R1MX8xGhPFNpDNuFazBUZIHNgOpYJxm5bP6B42VfRFQ
         9sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774106946; x=1774711746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAL+TSfdFSEA1fM8RdScpbBSoZeZ13xnErm/N5MfbbY=;
        b=ft7sAsMIPLixN1PILuhvEfUXeZWhFOqcFXO/2faaZ1zDE5jzCd2gjRhF8SH0k5rLU+
         8HKHZCgL3x+kGM4tYe8TQdxQ9usl8rBTVDTxoKqXGx7lgZAQjjgABRvpx+DhY8prQTPj
         9noOYR1XB5AteEMJ6eRdf06zhshci74rV3aqy2ZssHtTN+egiJqSVyDJoqyw4BgT9gg4
         3NhueZYOB9GsWFvtaAQSe0RQBNrfrj+OY9UIwVHVN3H1UISrYQYqymThd0mfqZE1qMXB
         bJirchabYiVSF6uDjozpdq9CP9qyO78G4cZc5jLu83xI68k5tBMFi+6QiTkc6Lv4zu2H
         W6ig==
X-Gm-Message-State: AOJu0YzRQS8EwhJhcDdIvG4x2UJpJLNZubNWCPQ0vSuWFCmxTrk+8xPa
	Xtoe9uG0KsLZwXCRbeg4IYRsbtMeTIW9POj14Po+yalWW1Yaz8zKzrI/LH0JMW26KXU=
X-Gm-Gg: ATEYQzzl7vYLsSdlwvjMQsp2vsc3B26E4dWTN0fj6E/VoDOv/DNrbDT1f9/ykmWVKBn
	y9J/TYU7t3o0xR0YwVWFoDx0ZffC7yMnesuljWeitsbtdjjybTqPq2F6OVz3rv3GSX3IR/nMSW9
	ge3iODTvSu9S5ZcASf9GFZrWegddjCVxest/pF0XKi2Ee6DtBh5fmAIM+sKDt+epFIqyCoGuj/G
	VI99zqw7xZiocKGLmZLY+tlwe4bDn5D5BlHF0z4kPrGoY7ufnOGT8WPI/HQcJIyQpfARv6oYm9J
	g867E+Bvj7A/IWvjeLh2Fj9lAqOQ81QmTBxbRRkaVRd4AmhMqGxMY1NM3yCezpfk7l9sLbgE3ZV
	ED3E9RnNI0g9WwW0/DnRPUHu+SvpN90bBjZhPACklnS3TNpsMBKn64lQf72LQEHSL3NmHUqMcip
	lw6Ile1CkPbq2mYJfftoZYjdVMQ+MwdxoTA2LcsbCOpOplAJ5iUtGgLu1qG1WoUY79B0VBZ1JcG
	07K1x1f+UdFFMp5ptPSSrOqQsAIJipjyoM=
X-Received: by 2002:a17:90b:17c9:b0:359:fdc0:4621 with SMTP id 98e67ed59e1d1-35bd2bc01eemr6030686a91.11.1774106945766;
        Sat, 21 Mar 2026 08:29:05 -0700 (PDT)
Received: from localhost.localdomain ([104.28.157.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6017492sm8395364a91.5.2026.03.21.08.29.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 08:29:05 -0700 (PDT)
From: adigitX <adityakammati.workspace@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: adigitX <adityakammati.workspace@gmail.com>
Subject: [RFC PATCH 3/5] erofs-utils: lib: implement composefs manifest subset
Date: Sat, 21 Mar 2026 20:58:30 +0530
Message-ID: <20260321152832.29735-4-adityakammati.workspace@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321152832.29735-1-adityakammati.workspace@gmail.com>
References: <20260321152832.29735-1-adityakammati.workspace@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2914-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[adityakammatiworkspace@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0D7792E618B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

---
 lib/manifest.c | 715 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 712 insertions(+), 3 deletions(-)

diff --git a/lib/manifest.c b/lib/manifest.c
index d7bbd5d..ed37f94 100644
--- a/lib/manifest.c
+++ b/lib/manifest.c
@@ -1,16 +1,725 @@
 // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#define _GNU_SOURCE
 #include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include "erofs/diskbuf.h"
+#include "erofs/hashmap.h"
+#include "erofs/inode.h"
 #include "erofs/manifest.h"
 #include "erofs/print.h"
+#include "liberofs_rebuild.h"
+
+#define EROFS_MANIFEST_COMPOSEFS_NR_FIELDS	11
+
+struct erofs_manifest_path {
+	struct hashmap_entry ent;
+	char path[];
+};
+
+struct erofs_manifest_ctx {
+	struct erofs_importer *im;
+	struct erofs_inode *root;
+	struct hashmap explicit_paths;
+};
+
+static int erofs_manifest_path_cmp(const void *a, const void *b,
+				   const void *keydata)
+{
+	const struct erofs_manifest_path *ea = a;
+	const struct erofs_manifest_path *eb = b;
+	const char *path = keydata ? keydata : eb->path;
+
+	return strcmp(ea->path, path);
+}
+
+static void erofs_manifest_ctx_init(struct erofs_manifest_ctx *ctx,
+				    struct erofs_importer *im)
+{
+	*ctx = (struct erofs_manifest_ctx) {
+		.im = im,
+		.root = im->root,
+	};
+	hashmap_init(&ctx->explicit_paths, erofs_manifest_path_cmp, 0);
+}
+
+static void erofs_manifest_ctx_exit(struct erofs_manifest_ctx *ctx)
+{
+	struct hashmap_iter iter;
+	struct erofs_manifest_path *path;
+
+	while ((path = hashmap_iter_first(&ctx->explicit_paths, &iter)) != NULL) {
+		hashmap_remove(&ctx->explicit_paths, &path->ent);
+		free(path);
+	}
+	(void)hashmap_free(&ctx->explicit_paths);
+}
+
+static bool erofs_manifest_has_explicit_path(struct erofs_manifest_ctx *ctx,
+					     const char *path)
+{
+	return hashmap_get_from_hash(&ctx->explicit_paths, strhash(path), path);
+}
+
+static int erofs_manifest_add_explicit_path(struct erofs_manifest_ctx *ctx,
+					    const char *path)
+{
+	struct erofs_manifest_path *entry;
+
+	entry = malloc(sizeof(*entry) + strlen(path) + 1);
+	if (!entry)
+		return -ENOMEM;
+
+	hashmap_entry_init(&entry->ent, strhash(path));
+	strcpy(entry->path, path);
+	hashmap_add(&ctx->explicit_paths, &entry->ent);
+	return 0;
+}
+
+static int erofs_manifest_open_source(const char *source, FILE **fp)
+{
+	if (!strcmp(source, "-")) {
+		*fp = stdin;
+		return 0;
+	}
+
+	*fp = fopen(source, "r");
+	if (!*fp)
+		return -errno;
+	return 0;
+}
+
+static void erofs_manifest_close_source(const char *source, FILE *fp)
+{
+	if (fp && strcmp(source, "-"))
+		fclose(fp);
+}
+
+static void erofs_manifest_trim_newline(char *line)
+{
+	size_t len = strlen(line);
+
+	while (len && (line[len - 1] == '\n' || line[len - 1] == '\r'))
+		line[--len] = '\0';
+}
+
+static int erofs_manifest_parse_uint(const char *value, int base, u64 *out)
+{
+	char *end;
+	unsigned long long n;
+
+	if (!value || !*value)
+		return -EINVAL;
+
+	errno = 0;
+	n = strtoull(value, &end, base);
+	if (errno || *end != '\0')
+		return -EINVAL;
+	*out = n;
+	return 0;
+}
+
+static int erofs_manifest_parse_mtime(const char *value, u64 *sec, u32 *nsec)
+{
+	char *end;
+	unsigned long long seconds, nanoseconds;
+
+	if (!value || !*value || !strcmp(value, "-"))
+		return -EINVAL;
+
+	errno = 0;
+	seconds = strtoull(value, &end, 10);
+	if (errno || *end != '.')
+		return -EINVAL;
+
+	errno = 0;
+	nanoseconds = strtoull(end + 1, &end, 10);
+	if (errno || *end != '\0' || nanoseconds >= 1000000000ULL)
+		return -EINVAL;
+
+	*sec = seconds;
+	*nsec = nanoseconds;
+	return 0;
+}
+
+static int erofs_manifest_hex2nibble(int c)
+{
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	if (c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	return -EINVAL;
+}
+
+static int erofs_manifest_unescape(const char *value, bool optional, char **out)
+{
+	size_t len, i, j;
+	char *decoded;
+
+	if (optional && !strcmp(value, "-")) {
+		*out = NULL;
+		return 0;
+	}
+
+	len = strlen(value);
+	decoded = malloc(len + 1);
+	if (!decoded)
+		return -ENOMEM;
+
+	for (i = 0, j = 0; i < len; ++i) {
+		int c = value[i];
+
+		if (c != '\\') {
+			decoded[j++] = c;
+			continue;
+		}
+
+		if (++i >= len) {
+			free(decoded);
+			return -EINVAL;
+		}
+
+		switch (value[i]) {
+		case '\\':
+			decoded[j++] = '\\';
+			break;
+		case 'n':
+			decoded[j++] = '\n';
+			break;
+		case 'r':
+			decoded[j++] = '\r';
+			break;
+		case 't':
+			decoded[j++] = '\t';
+			break;
+		case 'x': {
+			int hi, lo;
+
+			if (i + 2 >= len) {
+				free(decoded);
+				return -EINVAL;
+			}
+			hi = erofs_manifest_hex2nibble(value[i + 1]);
+			lo = erofs_manifest_hex2nibble(value[i + 2]);
+			if (hi < 0 || lo < 0) {
+				free(decoded);
+				return -EINVAL;
+			}
+			c = (hi << 4) | lo;
+			if (!c) {
+				free(decoded);
+				return -EINVAL;
+			}
+			decoded[j++] = c;
+			i += 2;
+			break;
+		}
+		default:
+			free(decoded);
+			return -EINVAL;
+		}
+	}
+	decoded[j] = '\0';
+	*out = decoded;
+	return 0;
+}
+
+static int erofs_manifest_next_field(char **cursor, char **field)
+{
+	char *start, *end;
+
+	start = *cursor;
+	if (!start || !*start)
+		return -EINVAL;
+
+	end = strchr(start, ' ');
+	if (end) {
+		*end = '\0';
+		*cursor = end + 1;
+		if (!**cursor)
+			*cursor = NULL;
+	} else {
+		*cursor = NULL;
+	}
+
+	if (!*start)
+		return -EINVAL;
+	*field = start;
+	return 0;
+}
+
+static int erofs_manifest_apply_inode(struct erofs_manifest_ctx *ctx,
+				      struct erofs_inode *inode,
+				      const char *path,
+				      umode_t mode, u32 uid, u32 gid,
+				      u64 mtime, u32 mtime_nsec,
+				      dev_t rdev, erofs_off_t size)
+{
+	struct stat st = { 0 };
+	int err;
+
+	st.st_mode = mode;
+	st.st_uid = uid;
+	st.st_gid = gid;
+	st.st_mtime = mtime;
+	ST_MTIM_NSEC_SET(&st, mtime_nsec);
+	st.st_rdev = rdev;
+	st.st_size = size;
+
+	err = __erofs_fill_inode(ctx->im, inode, &st, path);
+	if (err)
+		return err;
+
+	inode->i_mode = mode;
+	inode->i_size = S_ISDIR(mode) || S_ISCHR(mode) || S_ISBLK(mode) ||
+			S_ISFIFO(mode) ? 0 : size;
+	inode->u.i_rdev = (S_ISCHR(mode) || S_ISBLK(mode)) ?
+		erofs_new_encode_dev(rdev) : 0;
+	if (!inode->i_srcpath) {
+		inode->i_srcpath = strdup(path);
+		if (!inode->i_srcpath)
+			return -ENOMEM;
+	}
+	if (!S_ISDIR(mode))
+		inode->i_nlink = 1;
+	return 0;
+}
+
+static int erofs_manifest_stage_file(struct erofs_inode *inode,
+				     const char *payload)
+{
+	char buf[32768];
+	struct stat st;
+	int srcfd = -1, dstfd, err;
+	u64 off, left;
+
+	srcfd = open(payload, O_RDONLY);
+	if (srcfd < 0)
+		return -errno;
+	if (fstat(srcfd, &st)) {
+		err = -errno;
+		goto out;
+	}
+	if (!S_ISREG(st.st_mode) || st.st_size != inode->i_size) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (!inode->i_diskbuf) {
+		inode->i_diskbuf = calloc(1, sizeof(*inode->i_diskbuf));
+		if (!inode->i_diskbuf) {
+			err = -ENOMEM;
+			goto out;
+		}
+	} else {
+		erofs_diskbuf_close(inode->i_diskbuf);
+	}
+
+	dstfd = erofs_diskbuf_reserve(inode->i_diskbuf, 0, &off);
+	if (dstfd < 0) {
+		err = dstfd;
+		goto out;
+	}
+
+	left = inode->i_size;
+	while (left) {
+		ssize_t nread;
+
+		nread = read(srcfd, buf, min_t(u64, sizeof(buf), left));
+		if (nread < 0) {
+			err = -errno;
+			goto out;
+		}
+		if (!nread) {
+			err = -EIO;
+			goto out;
+		}
+		if (pwrite(dstfd, buf, nread, off) != nread) {
+			err = -errno ? -errno : -EIO;
+			goto out;
+		}
+		left -= nread;
+		off += nread;
+	}
+
+	erofs_diskbuf_commit(inode->i_diskbuf, inode->i_size);
+	inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
+	err = 0;
+out:
+	if (srcfd >= 0)
+		close(srcfd);
+	return err;
+}
+
+static int erofs_manifest_lookup_dentry(struct erofs_manifest_ctx *ctx,
+					const char *path,
+					struct erofs_dentry **out)
+{
+	struct erofs_dentry *d;
+	char *scratch;
+	bool ignored;
+
+	scratch = strdup(path);
+	if (!scratch)
+		return -ENOMEM;
+
+	d = erofs_rebuild_get_dentry(ctx->root, scratch, false,
+				     &ignored, &ignored, false);
+	free(scratch);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	*out = d;
+	return 0;
+}
+
+static int erofs_manifest_prepare_dentry(struct erofs_manifest_ctx *ctx,
+					 const char *path, umode_t mode,
+					 struct erofs_dentry **out_dentry,
+					 struct erofs_inode **out_inode,
+					 bool *out_root)
+{
+	struct erofs_dentry *d;
+	struct erofs_inode *inode;
+	char *scratch;
+	bool ignored;
+	int err;
+
+	*out_root = false;
+	if (erofs_manifest_has_explicit_path(ctx, path))
+		return -EEXIST;
+
+	if (!strcmp(path, "/")) {
+		if (!S_ISDIR(mode))
+			return -EINVAL;
+		*out_inode = ctx->root;
+		*out_dentry = NULL;
+		*out_root = true;
+		return 0;
+	}
+
+	scratch = strdup(path);
+	if (!scratch)
+		return -ENOMEM;
+
+	d = erofs_rebuild_get_dentry(ctx->root, scratch, false,
+				     &ignored, &ignored, false);
+	free(scratch);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	if (!d)
+		return -EINVAL;
+
+	if (d->type == EROFS_FT_UNKNOWN) {
+		inode = erofs_new_inode(ctx->root->sbi);
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
+
+		inode->i_parent = d->inode;
+		d->inode = inode;
+		d->type = erofs_mode_to_ftype(mode);
+	} else {
+		inode = d->inode;
+		if (!S_ISDIR(inode->i_mode) || !S_ISDIR(mode))
+			return -EEXIST;
+	}
+
+	err = erofs_manifest_add_explicit_path(ctx, path);
+	if (err)
+		return err;
+
+	*out_inode = inode;
+	*out_dentry = d;
+	return 0;
+}
+
+static int erofs_manifest_apply_composefs_line(struct erofs_manifest_ctx *ctx,
+					       char *line, unsigned int lineno)
+{
+	char *cursor = line, *field[EROFS_MANIFEST_COMPOSEFS_NR_FIELDS];
+	char *path = NULL, *payload = NULL, *content = NULL, *digest = NULL;
+	struct erofs_dentry *dentry = NULL, *target = NULL;
+	struct erofs_inode *inode, *target_inode;
+	umode_t mode;
+	u64 size, mode_raw, uid, gid, rdev_raw;
+	u64 mtime;
+	u32 mtime_nsec;
+	bool hardlink, is_root;
+	int err, i;
+
+	for (i = 0; i < EROFS_MANIFEST_COMPOSEFS_NR_FIELDS; ++i) {
+		err = erofs_manifest_next_field(&cursor, &field[i]);
+		if (err) {
+			erofs_err("manifest:%u: expected %u composefs fields",
+				  lineno, EROFS_MANIFEST_COMPOSEFS_NR_FIELDS);
+			return err;
+		}
+	}
+	if (cursor && *cursor) {
+		erofs_err("manifest:%u: xattrs are not supported yet", lineno);
+		return -EOPNOTSUPP;
+	}
+
+	err = erofs_manifest_unescape(field[0], false, &path);
+	if (err) {
+		erofs_err("manifest:%u: invalid composefs path", lineno);
+		goto out;
+	}
+	if (path[0] != '/') {
+		err = -EINVAL;
+		erofs_err("manifest:%u: composefs path must be absolute: %s",
+			  lineno, path);
+		goto out;
+	}
+
+	err = erofs_manifest_parse_uint(field[1], 10, &size);
+	if (err) {
+		erofs_err("manifest:%u: invalid composefs size", lineno);
+		goto out;
+	}
+
+	hardlink = field[2][0] == '@';
+	err = erofs_manifest_parse_uint(field[2] + hardlink, 8, &mode_raw);
+	if (err) {
+		erofs_err("manifest:%u: invalid composefs mode", lineno);
+		goto out;
+	}
+	mode = mode_raw;
+
+	err = erofs_manifest_parse_uint(field[4], 10, &uid);
+	if (err) {
+		erofs_err("manifest:%u: invalid composefs uid", lineno);
+		goto out;
+	}
+
+	err = erofs_manifest_parse_uint(field[5], 10, &gid);
+	if (err) {
+		erofs_err("manifest:%u: invalid composefs gid", lineno);
+		goto out;
+	}
+
+	if (!strcmp(field[6], "-")) {
+		rdev_raw = 0;
+	} else {
+		err = erofs_manifest_parse_uint(field[6], 10, &rdev_raw);
+		if (err) {
+			erofs_err("manifest:%u: invalid composefs rdev", lineno);
+			goto out;
+		}
+	}
+
+	err = erofs_manifest_parse_mtime(field[7], &mtime, &mtime_nsec);
+	if (err) {
+		erofs_err("manifest:%u: invalid composefs mtime", lineno);
+		goto out;
+	}
+
+	err = erofs_manifest_unescape(field[8], true, &payload);
+	if (err) {
+		erofs_err("manifest:%u: invalid composefs payload", lineno);
+		goto out;
+	}
+	err = erofs_manifest_unescape(field[9], true, &content);
+	if (err) {
+		erofs_err("manifest:%u: invalid composefs content", lineno);
+		goto out;
+	}
+	err = erofs_manifest_unescape(field[10], true, &digest);
+	if (err) {
+		erofs_err("manifest:%u: invalid composefs digest", lineno);
+		goto out;
+	}
+
+	if (hardlink) {
+		if (content || digest) {
+			err = -EOPNOTSUPP;
+			erofs_err("manifest:%u: hardlinks only support PATH and PAYLOAD in v1",
+				  lineno);
+			goto out;
+		}
+		if (!payload || payload[0] != '/') {
+			err = -EINVAL;
+			erofs_err("manifest:%u: hardlink target must be absolute",
+				  lineno);
+			goto out;
+		}
+		err = erofs_manifest_prepare_dentry(ctx, path, S_IFREG | 0644,
+						    &dentry, &inode, &is_root);
+		if (err)
+			goto out;
+		if (is_root) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = erofs_manifest_lookup_dentry(ctx, payload, &target);
+		if (err)
+			goto out;
+		if (!target || target->type == EROFS_FT_UNKNOWN) {
+			err = -ENOENT;
+			goto out;
+		}
+
+		target_inode = target->inode;
+		if (S_ISDIR(target_inode->i_mode)) {
+			err = -EISDIR;
+			goto out;
+		}
+
+		erofs_iput(inode);
+		dentry->inode = erofs_igrab(target_inode);
+		dentry->type = erofs_mode_to_ftype(target_inode->i_mode);
+		++target_inode->i_nlink;
+		err = 0;
+		goto out;
+	}
+
+	err = erofs_manifest_prepare_dentry(ctx, path, mode, &dentry, &inode,
+					    &is_root);
+	if (err)
+		goto out;
+
+	if (content) {
+		err = -EOPNOTSUPP;
+		erofs_err("manifest:%u: inline composefs content is not supported yet",
+			  lineno);
+		goto out;
+	}
+	if (digest) {
+		err = -EOPNOTSUPP;
+		erofs_err("manifest:%u: composefs digests are not supported yet",
+			  lineno);
+		goto out;
+	}
+
+	switch (mode & S_IFMT) {
+	case S_IFDIR:
+		if (payload) {
+			err = -EINVAL;
+			goto out;
+		}
+		err = erofs_manifest_apply_inode(ctx, inode, path, mode,
+						 uid, gid, mtime, mtime_nsec,
+						 0, 0);
+		break;
+	case S_IFREG:
+		err = erofs_manifest_apply_inode(ctx, inode, path, mode,
+						 uid, gid, mtime, mtime_nsec,
+						 0, size);
+		if (err)
+			break;
+		if (payload) {
+			err = erofs_manifest_stage_file(inode, payload);
+		} else if (size) {
+			err = -EINVAL;
+		}
+		break;
+	case S_IFLNK:
+		if (!payload || size != strlen(payload)) {
+			err = -EINVAL;
+			goto out;
+		}
+		err = erofs_manifest_apply_inode(ctx, inode, path, mode,
+						 uid, gid, mtime, mtime_nsec,
+						 0, strlen(payload));
+		if (err)
+			break;
+		inode->i_link = strdup(payload);
+		if (!inode->i_link)
+			err = -ENOMEM;
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+		if (payload) {
+			err = -EINVAL;
+			goto out;
+		}
+		err = erofs_manifest_apply_inode(ctx, inode, path, mode,
+						 uid, gid, mtime, mtime_nsec,
+						 (dev_t)rdev_raw, 0);
+		break;
+	case S_IFIFO:
+		if (payload) {
+			err = -EINVAL;
+			goto out;
+		}
+		err = erofs_manifest_apply_inode(ctx, inode, path, mode,
+						 uid, gid, mtime, mtime_nsec,
+						 0, 0);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+out:
+	free(path);
+	free(payload);
+	free(content);
+	free(digest);
+	return err;
+}
+
+static int erofs_manifest_load_composefs(struct erofs_manifest_ctx *ctx,
+					 const char *source)
+{
+	FILE *fp;
+	char *line = NULL;
+	size_t cap = 0;
+	unsigned int lineno = 0;
+	int err;
+
+	err = erofs_manifest_open_source(source, &fp);
+	if (err)
+		return err;
+
+	while (getline(&line, &cap, fp) >= 0) {
+		++lineno;
+		erofs_manifest_trim_newline(line);
+		if (!line[0])
+			continue;
+
+		err = erofs_manifest_apply_composefs_line(ctx, line, lineno);
+		if (err)
+			goto out;
+	}
+
+	err = ferror(fp) ? -EIO : 0;
+out:
+	free(line);
+	erofs_manifest_close_source(source, fp);
+	return err;
+}
 
 int erofs_manifest_load(struct erofs_importer *im,
 			enum erofs_manifest_format format,
 			const char *source)
 {
+	struct erofs_manifest_ctx ctx;
+	int err;
+
 	if (!im || !im->root || !source)
 		return -EINVAL;
 
-	(void)format;
-	erofs_err("manifest input support is not implemented yet");
-	return -EOPNOTSUPP;
+	erofs_manifest_ctx_init(&ctx, im);
+	switch (format) {
+	case EROFS_MANIFEST_FORMAT_AUTO:
+	case EROFS_MANIFEST_FORMAT_COMPOSEFS:
+		err = erofs_manifest_load_composefs(&ctx, source);
+		break;
+	case EROFS_MANIFEST_FORMAT_PROTO:
+		erofs_err("proto manifest input support is not implemented yet");
+		err = -EOPNOTSUPP;
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+	erofs_manifest_ctx_exit(&ctx);
+	return err;
 }
-- 
2.51.0


