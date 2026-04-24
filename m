Return-Path: <linux-erofs+bounces-3357-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAnFMyUh62k9IwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3357-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Apr 2026 09:52:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93E45AF17
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Apr 2026 09:52:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g24tB4pfFz2ynf;
	Fri, 24 Apr 2026 17:52:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777017122;
	cv=none; b=IXPmdVb0sNZKJhLgkvOq1YaPybrpAHEhQyoP5ZL8zUOzuc5nMo6P0gtyrxE8jQGAJ5/fHSASvVWjMsQd3Hz2dMHRJ2GOH9VFKVBqbgoBLPTj9XbjDiu62riw8lA7heUbEwsfV823i/5r+Kit9WhJ7yIEkqGBgX77nywBNXara1CaQtTYmsPynwim1kFiJo+MjuwRjrEdu/rQfWbfR9NDcxhozNK6XzL4fH/DY7a83gtxjF6HV2tHDwF3K15UDB4Rt5nfq5Tu+yajrGHclSnfNzFGLBeWsCmeeDj3BplbFQkZA86o9FonK9bVs+6IJKN1uxNwmsCSbG2Plr0B7GoMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777017122; c=relaxed/relaxed;
	bh=x1qDrXArWEcg4aodITjMPXtCHnEfYP2gIlvxDnDfU/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+KzsmhYhMWXcR6dX+X4o4pPDT8mNe1fm7Mr8tjDTLh/ZeDcJOlJAMJUt5qZ1RRvF+GaZg/LA/28zx9xskjU7IDCT5+qLo1XYLz4MV3XJk/nRKFXgukapU1kI6uCJmLxHXNJ7Vozh96zHRWANlKsp/083IuZawGNMu8joIwGSYgxT6FaeBLkeUNEWHdfcwyM+iR6OOuQ5tH2XeFMVqIAkejYXz+sg7TVAnr1rBaL3FjIjz/Xg8zF6WWSw5pLbgwNViRrhkSJ7bmKe1g6VAO6l1y709CApkcGsTdwTp5CtH2t0PMkVET8crPivhMXjHn/wgAoefyWTibdaRsn4PYiDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dkhLQs4C; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dkhLQs4C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g24t93Hknz2xly
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Apr 2026 17:52:01 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ab46931cf1so59594045ad.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 24 Apr 2026 00:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777017118; x=1777621918; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x1qDrXArWEcg4aodITjMPXtCHnEfYP2gIlvxDnDfU/Q=;
        b=dkhLQs4CkShOPWnmGbEinJdDDwlpjlu5JhW9tV2cvRaCKGpmkvoH+pXjiwh5FYdy8s
         natV7aUpjEyA8Im/4WQOeYR5TIWtTQOX5jfR+ozfg2vO/smRHY38dwD09IaDxBkjGafU
         9b2dUmOLtWJBQoci+PPZm3Q+J1s4O7vLjvKK3TdZuQ1c4zdWGH/ORk6CKZHsKSNfCPVP
         kkwv2eWgMZkzRbgj7AygPLI6YpaA/K+hr/Tj7zlOJOWDuJKeYLhZ97znQwiRh6QX9hrh
         4Jnll1LSOHlkMg1l+Sk2pcBYHrxCrJB4a4wZKJ3mFXVUiH57I5jwNbUTwyesgCVkgpGk
         0eWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777017118; x=1777621918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1qDrXArWEcg4aodITjMPXtCHnEfYP2gIlvxDnDfU/Q=;
        b=hAfH5nTGUNqcQ193y9e7I9dYi3GyrZlq2OV7aqJwaL37psKWJJlQrXCSPmNNuDHQvN
         jjX7nOi/bk/p/uPEFDzyfVIwHEj+Imm3B1/OgF+llBg1uIsd3L/hks8Ll/f1TwHUyL8R
         6rJ5bqZ/lRj/8IFvAtnPNzGZtYZFw7Ibw3BCOXCPPE2YahbBp39g1X4PjWbqtAZ5l796
         2iumPji5kOxZ41uHkvb20/SqELMWYu3U8brP8c20yH1xvK+4fHq1JBVAFACgvsW5claq
         LmfbfMjosdN/iTQhuO/ZHy1nKXthE2u+8KFlx3YL34tzvEkMjY6vVTxL1PKdEnuReAxL
         wPTA==
X-Gm-Message-State: AOJu0YwzNvtKNsHynysj4mAAuQdW91H1RotCLmQOMc8D+SpVfVDkmzhb
	BmFPo78mjp5+07XeTxb0VhR/TaJt+xuYy8UTa7jP1VenHqMYqzymarql0TNqrQ==
X-Gm-Gg: AeBDietISgeZtjz2NKzjs5/VjBz3y8Azqy5F8S5PV1hc9o47nv+h/xbtyS78MPlQHBZ
	7JPAPCI1arSi8M45EvkyvyorVI53hOjYYONCII2Xo4G3YtrOG/TbogKVSNWMJ9qvoy+m6rUPk48
	1BJQMofyoVAzr1z5yudGiv8w+yLsO5aA/aeWNberv8DKKwhFQBvweEcjqnUpHEu7kDACPCdy1cF
	8ljxbEQj9V9wPT8skorYN8MXr0yZhz436en4F2gWroV/RLNznIUrwTlnQHJW0HUYUWYck8pEjrN
	xOeG/cgDvSW9O88bxCoOuX8yK2CG4lXR3HkDgpZAA+18bCN38qF3TUwYfVzjL7Xs/vnQkKZytXS
	l3U5W++pk40feUZ6etT9iLtU7FurR4HNsBYNupWBz5PMVMzd5PX7x1ZWImonxVRyP2PwYkrO+kg
	p+CYfX75twku3wmBkHcoHg++6FFhibzFtLtegO7d/ArIQD
X-Received: by 2002:a17:902:7615:b0:2ae:47b0:dc80 with SMTP id d9443c01a7336-2b5f9df6fc9mr195191465ad.11.1777017117886;
        Fri, 24 Apr 2026 00:51:57 -0700 (PDT)
Received: from kali ([103.212.138.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm214178265ad.40.2026.04.24.00.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 00:51:57 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Saksham <aghi.saksham5@gmail.com>
Subject: [PATCH] erofs-utils: fix unchecked strdup() and harden erofs_fspath()
Date: Fri, 24 Apr 2026 13:21:50 +0530
Message-ID: <20260424075150.273557-1-aghi.saksham5@gmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: CB93E45AF17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3357-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[aghisaksham5@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]

In several places across the erofs-utils codebase, the return value of
strdup() was not checked for failure. This can lead to NULL pointer
dereferences or unexpected behavior when these strings are processed
downstream, especially in utility functions like erofs_fspath().

Specifically, erofs_make_empty_root_inode() in lib/inode.c assigned
the result of strdup("/") to root->i_srcpath without validation. If
this allocation failed, subsequent calls to erofs_fspath(inode->i_srcpath)
would attempt to dereference a NULL pointer (or an offset from NULL),
potentially causing a crash or memory safety issues.

This patch addresses these issues by:
1. Adding proper NULL checks for strdup() in erofs_make_empty_root_inode()
   (lib/inode.c) and erofs_rebuild_load_tree() (lib/rebuild.c). If
   allocation fails, the functions now correctly return -ENOMEM.
2. Hardening erofs_fspath() in lib/config.c to gracefully handle NULL
   inputs. It now returns an empty string instead of attempting to
   dereference the pointer, providing a robust fallback for memory
   exhaustion scenarios.
3. Fixing unchecked strdup() and strndup() calls in the S3 remote
   backend (lib/remotes/s3.c) and mkfs (mkfs/main.c).

These changes improve the overall robustness and reliability of the
erofs-utils suite, particularly when operating under memory pressure.

Detailed changes:
- lib/inode.c: Check strdup("/") in erofs_make_empty_root_inode;
  call erofs_iput() and return ERR_PTR(-ENOMEM) on failure.
- lib/rebuild.c: Check strdup("/") in erofs_rebuild_load_tree;
  return -ENOMEM on failure.
- lib/config.c: Add NULL check to erofs_fspath().
- mkfs/main.c: Check strdup(extraopts) in mkfs_parse_one_compress_alg.
- lib/remotes/s3.c: Check strdup() in s3erofs_parse_list_objects_one()
  and s3erofs_create_object_iterator(). Properly clean up and return
  errors.

Signed-off-by: Saksham <aghi.saksham5@gmail.com>
---
 lib/config.c     |  7 +++++--
 lib/inode.c      |  5 +++++
 lib/rebuild.c    |  2 ++
 lib/remotes/s3.c | 24 ++++++++++++++++++++----
 mkfs/main.c      |  5 ++++-
 5 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/lib/config.c b/lib/config.c
index ab7eb01..b26dd57 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -69,13 +69,16 @@ void erofs_set_fs_root(const char *rootdir)
 
 const char *erofs_fspath(const char *fullpath)
 {
-	const char *s = fullpath + fullpath_prefix;
+	const char *s;
 
+	if (!fullpath)
+		return "";
+
+	s = fullpath + fullpath_prefix;
 	while (*s == '/')
 		s++;
 	return s;
 }
-
 #ifdef HAVE_LIBSELINUX
 int erofs_selabel_open(const char *file_contexts)
 {
diff --git a/lib/inode.c b/lib/inode.c
index 2cfc6c5..74420b2 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -2449,7 +2449,12 @@ struct erofs_inode *erofs_make_empty_root_inode(struct erofs_importer *im,
 	root = erofs_new_inode(sbi);
 	if (IS_ERR(root))
 		return root;
+
 	root->i_srcpath = strdup("/");
+	if (!root->i_srcpath) {
+		erofs_iput(root);
+		return ERR_PTR(-ENOMEM);
+	}
 	root->i_mode = S_IFDIR | 0777;
 	root->i_uid = (!params || params->fixed_uid == -1) ? getuid() :
 							     params->fixed_uid;
diff --git a/lib/rebuild.c b/lib/rebuild.c
index f89a17c..f40bf23 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -446,6 +446,8 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 		return ret;
 	}
 	inode.i_srcpath = strdup("/");
+	if (!inode.i_srcpath)
+		return -ENOMEM;
 
 	ctx = (struct erofs_rebuild_dir_context) {
 		.ctx.dir = &inode,
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 768232a..0dbe5aa 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -714,9 +714,13 @@ static int s3erofs_parse_list_objects_one(xmlNodePtr node,
 				tm.tm_isdst = -1;
 				info->mtime = mktime(&tm);
 			}
-			if (xmlStrEqual(child->name, (const xmlChar *)"Key"))
+			if (xmlStrEqual(child->name, (const xmlChar *)"Key")) {
 				info->key = strdup((char *)str);
-			else if (xmlStrEqual(child->name, (const xmlChar *)"Size"))
+				if (!info->key) {
+					xmlFree(str);
+					return -ENOMEM;
+				}
+			} else if (xmlStrEqual(child->name, (const xmlChar *)"Size"))
 				info->size = atoll((char *)str);
 			xmlFree(str);
 		}
@@ -898,6 +902,7 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
 {
 	struct s3erofs_object_iterator *iter;
 	const char *prefix;
+	int ret;
 
 	iter = calloc(1, sizeof(struct s3erofs_object_iterator));
 	if (!iter)
@@ -911,14 +916,25 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
 		iter->bucket = NULL;
 		iter->prefix = strdup(path + 1);
 	} else {
-		if (++prefix - path > S3EROFS_PATH_MAX)
-			return ERR_PTR(-EINVAL);
+		if (++prefix - path > S3EROFS_PATH_MAX) {
+			ret = -EINVAL;
+			goto err;
+		}
 		iter->bucket = strndup(path, prefix - path);
 		iter->prefix = strdup(prefix);
 	}
+
+	if ((!iter->bucket && prefix != path) ||
+	    (!iter->prefix && prefix)) {
+		ret = -ENOMEM;
+		goto err;
+	}
 	iter->delimiter = delimiter;
 	iter->is_truncated = true;
 	return iter;
+err:
+	s3erofs_destroy_object_iterator(iter);
+	return ERR_PTR(ret);
 }
 
 static void s3erofs_destroy_object_iterator(struct s3erofs_object_iterator *it)
diff --git a/mkfs/main.c b/mkfs/main.c
index 58c18f9..d759144 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -987,8 +987,11 @@ static int mkfs_parse_one_compress_alg(char *alg)
 			}
 		}
 	}
-	if (i)
+	if (i) {
 		zset->extraopts = strdup(extraopts);
+		if (!zset->extraopts)
+			return -ENOMEM;
+	}
 	return mkfscfg.total_zcfgs++;
 }
 
-- 
2.53.0


