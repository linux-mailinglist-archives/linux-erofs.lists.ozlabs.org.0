Return-Path: <linux-erofs+bounces-3321-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIdtBAsJ4mna0QAAu9opvQ
	(envelope-from <linux-erofs+bounces-3321-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Apr 2026 12:18:51 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6873341A066
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Apr 2026 12:18:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxrSk2Wpwz2yfs;
	Fri, 17 Apr 2026 20:18:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776421126;
	cv=none; b=LHWpNYV9RJLwjrsi9KMTE1BJVp2ZmlogMre0jHIvWloxIrrNlEWkpqZQQElFsmi5ftUpCP2F6JZaoD25sNi4O3ZxL6yAiKz2IyKc6wSZpPe7yh8q0+zMWTEVKZ63bJYYuP+kfG7rAlx9EVK+WV+kBN0vUYdEb6rWL+5sPXyR3bREAILX9HiYCJsyIlT4V8C7wi8a6FC9myP1NJ1yVeUJS/B+3mVFdUgOrDk+hrBj1baH8rjgz0ejsDQ95aSJiJX1HPBBDAlJ7Aq7UyTrUkvX9HvPnTdHp4lY9iMNeB/wT2tjlDuKqme4ZUhwZ0MMlHVirzNaAPYEvZ+6yuB6mL36nA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776421126; c=relaxed/relaxed;
	bh=Fb2/Bst3XaTypaJHPd1btFfr2+omBP/GryqGAzuKH6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hd+qvCnw+htJEEEcu94Sg9388zYJM/o4HgQb60dxleC6bMYstwqOAkvKE/2ocl7kqgV8LieQwPTrYbhOxJ73nnp0pM3rKoXVheQCwr3VjeOjZt3G3BvbdVogYDt9e5RLeY9fbRYmSllBcFvD5WEZHB86NYJ43X1uFHo5fHi1pUwnHPb89Er/ngHIFgACz1Bhf+kT1THsAG88I15ivoUKx68RgwJTQY9VbVl3EIluF4iBizgxnUnD5NjQyWsgjT1DuhgAfzE+6wyuPE1v5LmZmLC8MKafHJX+22nKzLBmRufewtrKwb1TG+ntlEEJMuIzCHH/lBqdoUg+CmxFyu/LoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CwkYla1u; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CwkYla1u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxrSg2v4Zz2xc8
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Apr 2026 20:18:41 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776421118; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Fb2/Bst3XaTypaJHPd1btFfr2+omBP/GryqGAzuKH6c=;
	b=CwkYla1ug/vsZYzgkeN8AWCNF4R/8ushKVzBBhUzzN6oUOZolpI2VXK0UySkYQE3Hz4zIzrZgl2Ss9w+JqFA/uJMTgqH8o4vDBmQQjt7jfZ10zTNGDX8MJIvJ4NjTMwwpmLbxm9ygJI9w3ZA9L8HgJMq5FITvqOLI6akLUTcdAQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X1B1iBx_1776421115;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1B1iBx_1776421115 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Apr 2026 18:18:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yuxuan Liu <cdjddzy@foxmail.com>
Subject: [PATCH 2/2] erofs-utils: mount: add recovery support for S3 object mounts
Date: Fri, 17 Apr 2026 18:18:29 +0800
Message-ID: <20260417101829.1214550-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260417101829.1214550-1-hsiangkao@linux.alibaba.com>
References: <20260417101829.1214550-1-hsiangkao@linux.alibaba.com>
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
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3321-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,foxmail.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 6873341A066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Assisted-by: qoder:(unknown)
Cc: Yuxuan Liu <cdjddzy@foxmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/liberofs_s3.h |   7 ++-
 lib/remotes/s3.c  |  72 ++++++++++++++++++++++++++++++
 mount/main.c      | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
index 3d2b2727b3b6..0c1f6c6d6a10 100644
--- a/lib/liberofs_s3.h
+++ b/lib/liberofs_s3.h
@@ -26,8 +26,8 @@ enum s3erofs_signature_version {
 
 struct erofs_s3 {
 	void *easy_curl;
-	const char *endpoint;
-	const char *region;
+	char *endpoint;
+	char *region;
 	char access_key[S3_ACCESS_KEY_LEN + 1];
 	char secret_key[S3_SECRET_KEY_LEN + 1];
 
@@ -43,6 +43,9 @@ struct erofs_vfile *s3erofs_io_open(struct erofs_s3 *s3, const char *bucket,
 				    const char *key);
 int s3erofs_parse_s3fs_passwd(const char *filepath, char *ak, char *sk);
 
+char *s3erofs_encode_cred(const char *access_key, const char *secret_key);
+int s3erofs_decode_cred(const char *b64, char **out_access_key, char **out_secret_key);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 35df935f8328..9cbf7ffd1035 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -1449,6 +1449,78 @@ err:
 	return ret;
 }
 
+char *s3erofs_encode_cred(const char *access_key, const char *secret_key)
+{
+	char *cred, *out;
+	size_t outlen;
+	int ret;
+
+	ret = asprintf(&cred, "%s:%s", access_key ?: "", secret_key ?: "");
+	if (ret < 0)
+		return ERR_PTR(-ENOMEM);
+
+	outlen = 4 * DIV_ROUND_UP(ret, 3);
+	out = malloc(outlen + 1);
+	if (!out) {
+		free(cred);
+		return ERR_PTR(-ENOMEM);
+	}
+	ret = erofs_base64_encode((u8 *)cred, ret, out);
+	if (ret < 0) {
+		free(out);
+		free(cred);
+		return ERR_PTR(ret);
+	}
+	out[ret] = '\0';
+	free(cred);
+	return out;
+}
+
+int s3erofs_decode_cred(const char *b64, char **out_access_key,
+			char **out_secret_key)
+{
+	size_t len;
+	unsigned char *out;
+	int ret;
+	char *colon;
+
+	if (!b64 || !out_access_key || !out_secret_key)
+		return -EINVAL;
+
+	*out_access_key = NULL;
+	*out_secret_key = NULL;
+
+	len = strlen(b64);
+	out = malloc(len * 3 / 4 + 1);
+	if (!out)
+		return -ENOMEM;
+
+	ret = erofs_base64_decode(b64, len, out);
+	if (ret < 0) {
+		free(out);
+		return ret;
+	}
+	out[ret] = '\0';
+
+	colon = strchr((char *)out, ':');
+	if (!colon) {
+		free(out);
+		return -EINVAL;
+	}
+
+	*colon = '\0';
+	*out_access_key = strdup((char *)out);
+	*out_secret_key = strdup(colon + 1);
+	free(out);
+
+	if (!*out_access_key || !*out_secret_key) {
+		free(*out_access_key);
+		free(*out_secret_key);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 #ifdef TEST
 struct s3erofs_prepare_url_testcase {
 	const char *name;
diff --git a/mount/main.c b/mount/main.c
index bd7beb1fbb13..25f94f4a29b5 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -956,6 +956,37 @@ static int erofsmount_write_recovery_local(FILE *f, struct erofsmount_source *so
 	return err ? -ENOMEM : 0;
 }
 
+#ifdef S3EROFS_ENABLED
+static int erofsmount_write_recovery_s3(FILE *f, struct erofsmount_source *source)
+{
+	char *b64cred = NULL;
+	int ret;
+
+	if (source->s3cfg.access_key[0] || source->s3cfg.secret_key[0]) {
+		b64cred = s3erofs_encode_cred(source->s3cfg.access_key,
+					      source->s3cfg.secret_key);
+		if (IS_ERR(b64cred))
+			return PTR_ERR(b64cred);
+	}
+
+	/* S3_OBJECT <bucket/key> <endpoint> <urlstyle> <sig> <region> [b64cred] */
+	ret = fprintf(f, "S3_OBJECT %s %s %d %d %s %s\n",
+		      source->device_path,
+		      source->s3cfg.endpoint,
+		      source->s3cfg.url_style,
+		      source->s3cfg.sig,
+		      source->s3cfg.region ?: "(nil)",
+		      b64cred ?: "");
+	free(b64cred);
+	return ret < 0 ? -ENOMEM : 0;
+}
+#else
+static int erofsmount_write_recovery_s3(FILE *f, struct erofsmount_source *source)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 static char *erofsmount_write_recovery_info(struct erofsmount_source *source)
 {
 	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
@@ -980,6 +1011,8 @@ static char *erofsmount_write_recovery_info(struct erofsmount_source *source)
 
 	if (source->type == EROFSMOUNT_SOURCE_OCI)
 		err = erofsmount_write_recovery_oci(f, source);
+	else if (source->type == EROFSMOUNT_SOURCE_S3_OBJECT)
+		err = erofsmount_write_recovery_s3(f, source);
 	else if (source->type == EROFSMOUNT_SOURCE_LOCAL)
 		err = erofsmount_write_recovery_local(f, source);
 
@@ -1106,6 +1139,76 @@ static int erofsmount_reattach_oci(struct erofs_vfile *vf,
 }
 #endif
 
+#ifdef S3EROFS_ENABLED
+static int erofsmount_reattach_s3(struct erofsmount_nbd_ctx *ctx, char *source)
+{
+	char *tokens[5] = {0}, *p = source;
+	char *bucket = NULL, *key = NULL;
+	struct erofs_s3 *s3cfg = &mountsrc.s3cfg;
+	int token_count = 0, err;
+	struct erofs_vfile *vf;
+
+	while (token_count < 5 && (p = strchr(p, ' ')) != NULL) {
+		*p++ = '\0';
+		while (*p == ' ')
+			p++;
+		if (*p == '\0')
+			break;
+		tokens[token_count++] = p;
+	}
+
+	if (token_count < 4)
+		return -EINVAL;
+
+	s3cfg->endpoint = strdup(tokens[0]);
+	s3cfg->url_style = atoi(tokens[1]);
+	s3cfg->sig = atoi(tokens[2]);
+	s3cfg->region = strdup(tokens[3]);
+	if (!s3cfg->endpoint || !s3cfg->region)
+		return -ENOMEM;
+
+	err = erofsmount_parse_s3_source(s3cfg, source, &bucket, &key);
+	if (err)
+		return err;
+
+	if (token_count > 4 && tokens[4][0]) {
+		char *tmp_access = NULL, *tmp_secret = NULL;
+
+		err = s3erofs_decode_cred(tokens[4], &tmp_access, &tmp_secret);
+		if (err)
+			goto err_out;
+		if (tmp_access) {
+			strncpy(s3cfg->access_key, tmp_access, S3_ACCESS_KEY_LEN);
+			s3cfg->access_key[S3_ACCESS_KEY_LEN] = '\0';
+			free(tmp_access);
+		}
+		if (tmp_secret) {
+			strncpy(s3cfg->secret_key, tmp_secret, S3_SECRET_KEY_LEN);
+			s3cfg->secret_key[S3_SECRET_KEY_LEN] = '\0';
+			free(tmp_secret);
+		}
+	}
+	vf = s3erofs_io_open(s3cfg, bucket, key);
+	free(bucket);
+	free(key);
+	if (IS_ERR(vf))
+		return PTR_ERR(vf);
+	ctx->vd = vf;
+	return 0;
+err_out:
+	free(bucket);
+	free(key);
+	free(s3cfg->region);
+	free(s3cfg->endpoint);
+	return err;
+}
+#else
+static int erofsmount_reattach_s3(struct erofsmount_nbd_ctx *ctx, char *source)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
 					 char *source)
 {
@@ -1352,6 +1455,12 @@ static int erofsmount_reattach(const char *target)
 		err = erofsmount_reattach_oci(ctx.vd, line, source);
 		if (err)
 			goto err_line;
+#ifdef S3EROFS_ENABLED
+	} else if (!strcmp(line, "S3_OBJECT")) {
+		err = erofsmount_reattach_s3(&ctx, source);
+		if (err)
+			goto err_line;
+#endif
 	} else {
 		err = -EOPNOTSUPP;
 		erofs_err("unsupported source type %s recorded in recovery file", line);
-- 
2.43.5


