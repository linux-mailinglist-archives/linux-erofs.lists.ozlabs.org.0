Return-Path: <linux-erofs+bounces-2915-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KDvCE25vmksYgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2915-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:17 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838282E6199
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdNdM672mz2yfs;
	Sun, 22 Mar 2026 02:29:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774106951;
	cv=none; b=oBQTcIg2KCnDnKhuKCQ8eL2TR/21wiu+HKKRjEBLarA3oTkh4TVfN0GdZAOjiru6MKilrSPSEunSX7pKPswkJm0AjAwGfEsOdfngLK7iRgh5DDcLHAOc0Q4xWDTFqdgiNrrreXFK/uf62Dx5M72b8QMtzerfpgjRkyujhqmXnCJdIl08rGY9e+vJzuyECaiXdPU5ERNEEeMTDj/V+rxa8yuajUI36vn4Xfgbm0ndGUC2X6Ze1ykbFelEyto2FL5WBn1A3pKyEwO3ruJmbn14OLqfZhNevQXEIdBwWwKUVu7s5KN9P5ekkNDA1l8mW+AholfeI+wZrYFxAuvGP+gEog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774106951; c=relaxed/relaxed;
	bh=w1GDHxk5meIEJnynjl9DC+/8CPwrh3Tmk8pCduRchwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBBaxGOJlbCeR7FFqdv4wxIUGRIsZr5KQ0ODO4rkGC7Rs3w57wYsHxXEuFqeu0ngxQ0U7/LpPjw0SvsJm07MQ6S2x7RHcLBWkq3+TdvU5Dunva28t6C8fKu7d/2eS8Yq8ZWS2gt9o3F6cUxmN0lM8B+MwHg+gJioFEUSV2+NpuVcfEiY/u+67Q43x1B1WWBXII4hSkU3Kg/YlR2fKvE867c0RaIqw4o5vJ6d/5fyrLqnZ+jbn4nMczW8UjZLzZLwk4sJECh3MwSQeKVW3I2Uz3EwfDnc2LmUNBMOdCeYH8EyWHgKTz7Pq+sDUROeZXz1c6mBy/qXdi62ANJuoZseGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gCTzVtMa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gCTzVtMa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdNdL5qkmz2yC9
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 02:29:10 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35b9d29480aso1248349a91.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774106948; x=1774711748; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1GDHxk5meIEJnynjl9DC+/8CPwrh3Tmk8pCduRchwo=;
        b=gCTzVtMarMxJhhsVvdbbU/I994ENAyk9iEbF15epmR6yahlpgeXOwWIGX6swBYTkqo
         NBeNDAtJT+D+/LWtxUEznBZYU9YcIgWqhoda6GY8BETd5Gb0NnQJD3poecAfzt1m08E7
         dLhykLk3TmM06TkxABSemY0ypJb5QwExWdwG0CzFuLPpWwKwgLZxIaEOemVOLAm8+elm
         mtOeUCRQkFfFC209A+kzyX5Cxy2mjTi9VLZ183KtlN93LXr+bWRJ/tSaGZIWUX+vnI9p
         H2jJUv1p3jQRGwKQE/yJnY1nDTopQBZHjPCJtFOWhcgvxcgQg5E33Iyjwzh+d+1O6leW
         I2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774106948; x=1774711748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w1GDHxk5meIEJnynjl9DC+/8CPwrh3Tmk8pCduRchwo=;
        b=a5XSsE9M3tAlJZeW8ifpSmp0NVWgM7KN1Yjv8pZ0jQh8ejEjs9Lf7uWfqaJKua5zU2
         lQw6cQVJqrhyrmEYBpVqExx2hELiMnlBA0y4pI6wL9EUhbFigc+ze6QnfICv6VqiLe9d
         sO6Accv8Mj4GWgTfmKSLIwnduRaZ7QiHNmrwVfmQrzhaxKF7erk1ubDE5CSUtaPDTqzY
         K3VlzJEa1tERxfa4EvFWj8lNnJxZ37d8iu+pM03LGyL8DCLDlULkjeYNTMjKUA8TAVRU
         Oh7ky5UyhpMq9zYVpLligbdYqlBW8pTlBnuCyIf4zDEU1t8QA2I1fRhpFMKsIN5OmcQ0
         YTMA==
X-Gm-Message-State: AOJu0YxeTvGhinaHpc4961mOHmBHUuY+XAunafToI6vh2gyOu5+m9mzO
	ovbRIkUMJA6TmZko3G60jbk+DOyMVtP53Sni2XzhI6EX/uyyTcaGzIK7jN09q7KIOzs=
X-Gm-Gg: ATEYQzw+Ueoia6heRn3FlYkbvzEoElLdvjgyJTSPVgecH2hYL60o68rPqathFGgJxCo
	kaBtARshqnPgGLW72untK1SCMl4cSSCIK1VBPxxgj1NNK+BRUgNwb7n/cyxaboifBtstIXmg62l
	V9LXkG+Q6PIqXG/0tQW5m0mBNmxkko1638fkZmxn5vcPWfUS4xeJ2kz5PB+/XlyiO1sfc/7TGg9
	LXHvBBiw6AR6VZKxTUzAl+Mr9ljbkdCNtsFh+puIsbe5wn+KeosQBmGnJQi5ooMTF7jaWVrUbsp
	8U6aWJslbGOmKq8DdUpmCmZqSgumF2C25l8dUtRTlZsUYGrLwYK3BBaiQV6SQmiRVLZ4t8Jnccq
	0zVzw8yRsyornTi5i4/jY90Bk6jPWKntyBrYlCac+NOBdYJD6lUH0tWjvKYwiEIGbB+valZB+36
	RKv72EIsjnGA7FVqkUCg2EHBhOir/nFUfEvOjVtm5CwO/cYUbJFFzBLGms/+MpD0YCZouE+rXBc
	9308sY1VyhZUNMPrdfUD4fm
X-Received: by 2002:a17:90b:3b81:b0:35b:a53a:7d0b with SMTP id 98e67ed59e1d1-35bd2d1fe84mr5578457a91.20.1774106948058;
        Sat, 21 Mar 2026 08:29:08 -0700 (PDT)
Received: from localhost.localdomain ([104.28.157.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6017492sm8395364a91.5.2026.03.21.08.29.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 08:29:07 -0700 (PDT)
From: adigitX <adityakammati.workspace@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: adigitX <adityakammati.workspace@gmail.com>
Subject: [RFC PATCH 4/5] erofs-utils: lib: implement proto manifest subset
Date: Sat, 21 Mar 2026 20:58:31 +0530
Message-ID: <20260321152832.29735-5-adityakammati.workspace@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2915-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 838282E6199
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

---
 lib/manifest.c | 388 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 362 insertions(+), 26 deletions(-)

diff --git a/lib/manifest.c b/lib/manifest.c
index ed37f94..a376a98 100644
--- a/lib/manifest.c
+++ b/lib/manifest.c
@@ -8,6 +8,10 @@
 #include <string.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <config.h>
+#if defined(HAVE_SYS_SYSMACROS_H)
+#include <sys/sysmacros.h>
+#endif
 #include "erofs/diskbuf.h"
 #include "erofs/hashmap.h"
 #include "erofs/inode.h"
@@ -16,6 +20,7 @@
 #include "liberofs_rebuild.h"
 
 #define EROFS_MANIFEST_COMPOSEFS_NR_FIELDS	11
+#define EROFS_MANIFEST_PROTO_HEADER		"%erofs.proto.v1"
 
 struct erofs_manifest_path {
 	struct hashmap_entry ent;
@@ -236,7 +241,12 @@ static int erofs_manifest_next_field(char **cursor, char **field)
 	char *start, *end;
 
 	start = *cursor;
-	if (!start || !*start)
+	if (!start)
+		return -EINVAL;
+
+	while (*start == ' ')
+		++start;
+	if (!*start)
 		return -EINVAL;
 
 	end = strchr(start, ' ');
@@ -255,6 +265,18 @@ static int erofs_manifest_next_field(char **cursor, char **field)
 	return 0;
 }
 
+static int erofs_manifest_stat_regular(const char *path, erofs_off_t *size)
+{
+	struct stat st;
+
+	if (stat(path, &st))
+		return -errno;
+	if (!S_ISREG(st.st_mode))
+		return -EINVAL;
+	*size = st.st_size;
+	return 0;
+}
+
 static int erofs_manifest_apply_inode(struct erofs_manifest_ctx *ctx,
 				      struct erofs_inode *inode,
 				      const char *path,
@@ -399,7 +421,8 @@ static int erofs_manifest_prepare_dentry(struct erofs_manifest_ctx *ctx,
 		if (!S_ISDIR(mode))
 			return -EINVAL;
 		*out_inode = ctx->root;
-		*out_dentry = NULL;
+		if (out_dentry)
+			*out_dentry = NULL;
 		*out_root = true;
 		return 0;
 	}
@@ -435,7 +458,8 @@ static int erofs_manifest_prepare_dentry(struct erofs_manifest_ctx *ctx,
 		return err;
 
 	*out_inode = inode;
-	*out_dentry = d;
+	if (out_dentry)
+		*out_dentry = d;
 	return 0;
 }
 
@@ -666,33 +690,357 @@ out:
 }
 
 static int erofs_manifest_load_composefs(struct erofs_manifest_ctx *ctx,
-					 const char *source)
+					 FILE *fp, char **line, size_t *cap,
+					 unsigned int lineno, bool has_line)
+{
+	int err;
+
+	if (has_line && (*line)[0]) {
+		err = erofs_manifest_apply_composefs_line(ctx, *line, lineno);
+		if (err)
+			return err;
+	}
+
+	while (getline(line, cap, fp) >= 0) {
+		++lineno;
+		erofs_manifest_trim_newline(*line);
+		if (!(*line)[0])
+			continue;
+
+		err = erofs_manifest_apply_composefs_line(ctx, *line, lineno);
+		if (err)
+			return err;
+	}
+	return ferror(fp) ? -EIO : 0;
+}
+
+static int erofs_manifest_apply_proto_hardlink(struct erofs_manifest_ctx *ctx,
+					       const char *path,
+					       const char *target_path,
+					       umode_t mode)
+{
+	struct erofs_dentry *dentry = NULL, *target = NULL;
+	struct erofs_inode *inode, *target_inode;
+	bool is_root;
+	int err;
+
+	err = erofs_manifest_prepare_dentry(ctx, path, mode, &dentry, &inode,
+					    &is_root);
+	if (err)
+		return err;
+	if (is_root)
+		return -EINVAL;
+
+	err = erofs_manifest_lookup_dentry(ctx, target_path, &target);
+	if (err)
+		return err;
+	if (!target || target->type == EROFS_FT_UNKNOWN)
+		return -ENOENT;
+
+	target_inode = target->inode;
+	if (S_ISDIR(target_inode->i_mode))
+		return -EISDIR;
+
+	erofs_iput(inode);
+	dentry->inode = erofs_igrab(target_inode);
+	dentry->type = erofs_mode_to_ftype(target_inode->i_mode);
+	++target_inode->i_nlink;
+	return 0;
+}
+
+static int erofs_manifest_apply_proto_line(struct erofs_manifest_ctx *ctx,
+					   char *line, unsigned int lineno)
+{
+	char *cursor = line, *field, *path = NULL, *payload = NULL;
+	struct erofs_inode *inode;
+	umode_t mode;
+	erofs_off_t size = 0;
+	u64 mode_raw, uid, gid, major_id, minor_id;
+	u64 mtime = ctx->root->i_mtime;
+	u32 mtime_nsec = ctx->root->i_mtime_nsec;
+	dev_t rdev = 0;
+	char kind;
+	bool is_root;
+	int err;
+
+	err = erofs_manifest_next_field(&cursor, &field);
+	if (err) {
+		erofs_err("manifest:%u: missing proto path", lineno);
+		return err;
+	}
+	err = erofs_manifest_unescape(field, false, &path);
+	if (err) {
+		erofs_err("manifest:%u: invalid proto path", lineno);
+		goto out;
+	}
+	if (path[0] != '/') {
+		err = -EINVAL;
+		erofs_err("manifest:%u: proto path must be absolute: %s",
+			  lineno, path);
+		goto out;
+	}
+
+	err = erofs_manifest_next_field(&cursor, &field);
+	if (err || strlen(field) != 1) {
+		err = -EINVAL;
+		erofs_err("manifest:%u: invalid proto type", lineno);
+		goto out;
+	}
+	kind = field[0];
+
+	err = erofs_manifest_next_field(&cursor, &field);
+	if (err || erofs_manifest_parse_uint(field, 8, &mode_raw)) {
+		err = -EINVAL;
+		erofs_err("manifest:%u: invalid proto mode", lineno);
+		goto out;
+	}
+
+	err = erofs_manifest_next_field(&cursor, &field);
+	if (err || erofs_manifest_parse_uint(field, 10, &uid)) {
+		err = -EINVAL;
+		erofs_err("manifest:%u: invalid proto uid", lineno);
+		goto out;
+	}
+
+	err = erofs_manifest_next_field(&cursor, &field);
+	if (err || erofs_manifest_parse_uint(field, 10, &gid)) {
+		err = -EINVAL;
+		erofs_err("manifest:%u: invalid proto gid", lineno);
+		goto out;
+	}
+
+	switch (kind) {
+	case 'd':
+		mode = S_IFDIR | (mode_raw & 07777);
+		break;
+	case 'f':
+		mode = S_IFREG | (mode_raw & 07777);
+		err = erofs_manifest_next_field(&cursor, &field);
+		if (err || erofs_manifest_unescape(field, false, &payload)) {
+			err = -EINVAL;
+			erofs_err("manifest:%u: invalid proto file payload", lineno);
+			goto out;
+		}
+		err = erofs_manifest_stat_regular(payload, &size);
+		if (err)
+			goto out;
+		break;
+	case 'l':
+		mode = S_IFLNK | (mode_raw & 07777);
+		err = erofs_manifest_next_field(&cursor, &field);
+		if (err || erofs_manifest_unescape(field, false, &payload)) {
+			err = -EINVAL;
+			erofs_err("manifest:%u: invalid proto symlink target",
+				  lineno);
+			goto out;
+		}
+		size = strlen(payload);
+		break;
+	case 'L':
+		mode = S_IFREG | (mode_raw & 07777);
+		err = erofs_manifest_next_field(&cursor, &field);
+		if (err || erofs_manifest_unescape(field, false, &payload)) {
+			err = -EINVAL;
+			erofs_err("manifest:%u: invalid proto hardlink target",
+				  lineno);
+			goto out;
+		}
+		if (payload[0] != '/') {
+			err = -EINVAL;
+			erofs_err("manifest:%u: hardlink target must be absolute",
+				  lineno);
+			goto out;
+		}
+		break;
+	case 'p':
+		mode = S_IFIFO | (mode_raw & 07777);
+		break;
+	case 'c':
+	case 'b':
+		mode = (kind == 'c' ? S_IFCHR : S_IFBLK) | (mode_raw & 07777);
+		err = erofs_manifest_next_field(&cursor, &field);
+		if (err || erofs_manifest_parse_uint(field, 10, &major_id)) {
+			err = -EINVAL;
+			erofs_err("manifest:%u: invalid proto device major", lineno);
+			goto out;
+		}
+		err = erofs_manifest_next_field(&cursor, &field);
+		if (err || erofs_manifest_parse_uint(field, 10, &minor_id)) {
+			err = -EINVAL;
+			erofs_err("manifest:%u: invalid proto device minor", lineno);
+			goto out;
+		}
+		rdev = makedev(major_id, minor_id);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		erofs_err("manifest:%u: unsupported proto type %c", lineno, kind);
+		goto out;
+	}
+
+	while (cursor && *cursor) {
+		err = erofs_manifest_next_field(&cursor, &field);
+		if (err)
+			goto out;
+		if (!strncmp(field, "mtime:", 6)) {
+			err = erofs_manifest_parse_mtime(field + 6, &mtime,
+							 &mtime_nsec);
+			if (err) {
+				erofs_err("manifest:%u: invalid proto mtime",
+					  lineno);
+				goto out;
+			}
+			continue;
+		}
+
+		err = -EINVAL;
+		erofs_err("manifest:%u: unsupported proto attribute %s",
+			  lineno, field);
+		goto out;
+	}
+
+	if (kind == 'L') {
+		err = erofs_manifest_apply_proto_hardlink(ctx, path, payload,
+							  mode);
+		goto out;
+	}
+
+	err = erofs_manifest_prepare_dentry(ctx, path, mode, NULL, &inode,
+					    &is_root);
+	if (err)
+		goto out;
+
+	switch (mode & S_IFMT) {
+	case S_IFDIR:
+	case S_IFREG:
+	case S_IFLNK:
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	err = erofs_manifest_apply_inode(ctx, inode, path, mode, uid, gid,
+					 mtime, mtime_nsec, rdev, size);
+	if (err)
+		goto out;
+
+	if (S_ISREG(mode) && payload) {
+		err = erofs_manifest_stage_file(inode, payload);
+	} else if (S_ISLNK(mode)) {
+		inode->i_link = strdup(payload);
+		if (!inode->i_link)
+			err = -ENOMEM;
+	}
+out:
+	free(path);
+	free(payload);
+	return err;
+}
+
+static int erofs_manifest_load_proto(struct erofs_manifest_ctx *ctx, FILE *fp,
+				     char **line, size_t *cap,
+				     unsigned int lineno, bool has_line)
+{
+	bool seen_header = false;
+	int err;
+
+	if (has_line && (*line)[0]) {
+		if (strcmp(*line, EROFS_MANIFEST_PROTO_HEADER)) {
+			erofs_err("manifest:%u: expected %s", lineno,
+				  EROFS_MANIFEST_PROTO_HEADER);
+			return -EINVAL;
+		}
+		seen_header = true;
+	}
+
+	while (getline(line, cap, fp) >= 0) {
+		++lineno;
+		erofs_manifest_trim_newline(*line);
+		if (!(*line)[0])
+			continue;
+		if (!seen_header) {
+			if (strcmp(*line, EROFS_MANIFEST_PROTO_HEADER)) {
+				erofs_err("manifest:%u: expected %s", lineno,
+					  EROFS_MANIFEST_PROTO_HEADER);
+				return -EINVAL;
+			}
+			seen_header = true;
+			continue;
+		}
+
+		if ((err = erofs_manifest_apply_proto_line(ctx, *line, lineno)))
+			return err;
+	}
+
+	if (!seen_header) {
+		erofs_err("manifest: missing %s header",
+			  EROFS_MANIFEST_PROTO_HEADER);
+		return -EINVAL;
+	}
+
+	return ferror(fp) ? -EIO : 0;
+}
+
+static int erofs_manifest_load_source(struct erofs_manifest_ctx *ctx,
+				      enum erofs_manifest_format format,
+				      const char *source)
 {
 	FILE *fp;
 	char *line = NULL;
 	size_t cap = 0;
 	unsigned int lineno = 0;
+	bool has_line = false;
 	int err;
 
 	err = erofs_manifest_open_source(source, &fp);
 	if (err)
 		return err;
 
-	while (getline(&line, &cap, fp) >= 0) {
-		++lineno;
-		erofs_manifest_trim_newline(line);
-		if (!line[0])
-			continue;
+	if (format == EROFS_MANIFEST_FORMAT_AUTO) {
+		while (getline(&line, &cap, fp) >= 0) {
+			++lineno;
+			erofs_manifest_trim_newline(line);
+			if (!line[0])
+				continue;
+
+			format = !strcmp(line, EROFS_MANIFEST_PROTO_HEADER) ?
+				EROFS_MANIFEST_FORMAT_PROTO :
+				EROFS_MANIFEST_FORMAT_COMPOSEFS;
+			has_line = true;
+			break;
+		}
 
-		err = erofs_manifest_apply_composefs_line(ctx, line, lineno);
-		if (err)
+		if (ferror(fp)) {
+			err = -EIO;
+			goto out;
+		}
+		if (format == EROFS_MANIFEST_FORMAT_AUTO) {
+			err = 0;
 			goto out;
+		}
+	}
+
+	switch (format) {
+	case EROFS_MANIFEST_FORMAT_COMPOSEFS:
+		err = erofs_manifest_load_composefs(ctx, fp, &line, &cap,
+						    lineno, has_line);
+		break;
+	case EROFS_MANIFEST_FORMAT_PROTO:
+		err = erofs_manifest_load_proto(ctx, fp, &line, &cap,
+						lineno, has_line);
+		break;
+	default:
+		err = -EINVAL;
+		break;
 	}
 
-	err = ferror(fp) ? -EIO : 0;
 out:
-	free(line);
 	erofs_manifest_close_source(source, fp);
+	free(line);
 	return err;
 }
 
@@ -707,19 +1055,7 @@ int erofs_manifest_load(struct erofs_importer *im,
 		return -EINVAL;
 
 	erofs_manifest_ctx_init(&ctx, im);
-	switch (format) {
-	case EROFS_MANIFEST_FORMAT_AUTO:
-	case EROFS_MANIFEST_FORMAT_COMPOSEFS:
-		err = erofs_manifest_load_composefs(&ctx, source);
-		break;
-	case EROFS_MANIFEST_FORMAT_PROTO:
-		erofs_err("proto manifest input support is not implemented yet");
-		err = -EOPNOTSUPP;
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
+	err = erofs_manifest_load_source(&ctx, format, source);
 	erofs_manifest_ctx_exit(&ctx);
 	return err;
 }
-- 
2.51.0


