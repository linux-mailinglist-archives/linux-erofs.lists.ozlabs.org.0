Return-Path: <linux-erofs+bounces-2326-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN5lLgZGlWnPNwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2326-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 05:54:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE8D153135
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 05:54:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fG41D58Wfz2yr6;
	Wed, 18 Feb 2026 15:54:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771390464;
	cv=none; b=AhjZhlJvorXcQyjy+Jtw7PYkpKyI3zT6boLbn8r0P0MUegMlk9R/lq1GOf4r8LyZkvD250FI1owJw1K6XGC2+0+iFGbJIR67AUVe5RvmCN3NdZm/+gVIhg9EsUSzC+wFtOwqxeZb2nKaV0R6WF6sMPgzsm4L8SjYdGzuAQ6jPiaogCqV0W/Uea7xumfunNxET4PdVoN5ykLME8Is4HMe4LacmbOpxgScvR0H8JpAynZ9q3aUvUcz1JSkfD4yu9AgEjkaSVFvYWIoltHUxpB6tEKWBeZNu7Wa8U/WBXHZLwBlaBd0OI88xHzzOnLYbSV2O8DfcNOnpRARS5Sfz3Or5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771390464; c=relaxed/relaxed;
	bh=x/RLCqZGNr1CrYlE9r/PxFgsFaRi6SQuTZXNkPWtX7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPEwellPPT7l6kUkDeEOZ9moOlTYC6tXegjUZc/81OxAgAL4Fj4/hJ8sexnps+CbH/IvR1RsmB8GzV4Ul63u6yTZw0O3jhheqoWnzKsQfVrBTwqRnJJ6j56cEoXxpO33E+QJHz1W0NCl62gPaaLEZlZYC16S6jmLM7dWXcGHqrUNY2ZCbtcDwriElBgTwcdU58VWffxIHYhRWdiTxB2OxrwgG/pILoA4i2KMuBzx5gfKnOhbpIDpqvxXoQ1lcBcPwOT62YQdDIy02Rx/TFfiv9Sprc2fex2o43xIjlV/RKzE9ZIsvYbO7bbw09HdhICkJ5qrynKuMDqyiF8b7F2OWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mWho948J; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mWho948J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fG41901Gqz2yFc
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Feb 2026 15:54:18 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771390454; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=x/RLCqZGNr1CrYlE9r/PxFgsFaRi6SQuTZXNkPWtX7I=;
	b=mWho948Jo3pvrSi1sUpcm1CzTgy4veciDwrxRV82P6AY3vmHLO9sqyFyIgINaWggSPDb2ZIqEJdYwQzIUoMuyIlDFLneIBDTCcmB/aj4Ox2AQiSf5ZzZTVsTAJbaw3rHlxRHXTdAMFUeh+DaXP2FMOUdP7CFXfW2keZ6cQRmmyY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzRkwOQ_1771390452 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Feb 2026 12:54:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: mkfs: allow multiplier suffixes ('K', 'M', 'G')
Date: Wed, 18 Feb 2026 12:54:07 +0800
Message-ID: <20260218045407.3783915-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260218045407.3783915-1-hsiangkao@linux.alibaba.com>
References: <20260218045407.3783915-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2326-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Queue-Id: CDE8D153135
X-Rspamd-Action: no action

Apply to common arguments such as `-b`, `-C` and `-m`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 111 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 96 insertions(+), 15 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index fb51cf87ef48..d909ef1a5834 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -748,6 +748,82 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
 }
 #endif
 
+static int erofs_mkfs_strtoll(const char *nptr, char **endptr,
+			      long long *res, int base)
+{
+	char *end;
+	long long number;
+
+	errno = 0;
+	number = strtoll(nptr, &end, base);
+	if (errno)
+		return -errno;
+
+	if (*end == 'k' || *end == 'K')
+		number *= 1024, ++end;
+	else if (*end == 'm' || *end == 'M')
+		number *= 1048576, ++end;
+	else if (*end == 'g' || *end == 'G')
+		number *= 1073741824, ++end;
+	*res = number;
+	if (endptr)
+		*endptr = end;
+	return 0;
+}
+
+static int erofs_mkfs_strtol(const char *nptr, char **endptr,
+			     long *res, int base)
+{
+	long long res_ll;
+	int ret;
+
+	ret = erofs_mkfs_strtoll(nptr, endptr, &res_ll, base);
+	if (ret)
+		return ret;
+	if (res_ll > LONG_MAX || res_ll < LONG_MIN)
+		return -ERANGE;
+	*res = res_ll;
+	return 0;
+}
+
+static int erofs_mkfs_strtoull(const char *nptr, char **endptr,
+			       unsigned long long *res, int base)
+{
+	char *end;
+	unsigned long long number;
+
+	errno = 0;
+	number = strtoull(nptr, &end, base);
+	if (errno)
+		return -errno;
+
+	if (*end == 'k' || *end == 'K')
+		number <<= 10, ++end;
+	else if (*end == 'm' || *end == 'M')
+		number <<= 20, ++end;
+	else if (*end == 'g' || *end == 'G')
+		number <<= 30, ++end;
+	*res = number;
+	if (endptr)
+		*endptr = end;
+	return 0;
+}
+
+static int erofs_mkfs_strtou32(const char *nptr, char **endptr,
+			       u32 *res, int base)
+{
+	unsigned long long res_ull;
+	int ret;
+
+	ret = erofs_mkfs_strtoull(nptr, endptr, &res_ull, base);
+	if (ret)
+		return ret;
+	if (res_ull > UINT32_MAX)
+		return -ERANGE;
+	*res = res_ull;
+	return 0;
+}
+
 #ifdef OCIEROFS_ENABLED
 /*
  * mkfs_parse_oci_options - Parse comma-separated OCI options string
@@ -765,6 +841,7 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
 {
 	char *opt, *q, *p;
 	long idx;
+	int ret;
 
 	if (!options_str)
 		return 0;
@@ -815,8 +892,8 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
 				erofs_err("invalid --oci: layer and blob cannot be set together");
 				return -EINVAL;
 			}
-			idx = strtol(p, NULL, 10);
-			if (idx < 0)
+			ret = erofs_mkfs_strtol(p, NULL, &idx, 10);
+			if (ret || idx < 0)
 				return -EINVAL;
 			oci_cfg->layer_index = (int)idx;
 		} else if ((p = strstr(opt, "username="))) {
@@ -890,12 +967,8 @@ static int mkfs_parse_one_compress_alg(char *alg)
 					}
 				} else if ((p = strstr(opt, "dictsize="))) {
 					p += strlen("dictsize=");
-					zset->dict_size = strtoul(p, &endptr, 10);
-					if (*endptr == 'k' || *endptr == 'K')
-						zset->dict_size <<= 10;
-					else if (*endptr == 'm' || *endptr == 'M')
-						zset->dict_size <<= 20;
-					else if ((endptr == p) || (*endptr && *endptr != ',')) {
+					j = erofs_mkfs_strtou32(p, &endptr, &zset->dict_size, 0);
+					if (j < 0 || (*endptr != '\0' && endptr != q)) {
 						erofs_err("invalid compression dictsize %s", p);
 						return -EINVAL;
 					}
@@ -1069,8 +1142,9 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 
 		case 'b':
-			i = atoi(optarg);
-			if (i < 512 || i > EROFS_MAX_BLOCK_SIZE) {
+			err = erofs_mkfs_strtol(optarg, &endptr, &i, 0);
+			if (err || *endptr != '\0' || i < 512 ||
+			    i > EROFS_MAX_BLOCK_SIZE) {
 				erofs_err("invalid block size %s", optarg);
 				return -EINVAL;
 			}
@@ -1179,8 +1253,9 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 #endif
 		case 9:
-			i = strtol(optarg, &endptr, 0);
-			if (*endptr != '\0' || i > INT32_MAX || i < INT32_MIN) {
+			err = erofs_mkfs_strtol(optarg, &endptr, &i, 0);
+			if (err || *endptr != '\0' ||
+			    i > INT32_MAX || i < INT32_MIN) {
 				erofs_err("invalid maximum compressed extent size %s",
 					  optarg);
 				return -EINVAL;
@@ -1206,8 +1281,8 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 #endif
 		case 'C':
-			i = strtoull(optarg, &endptr, 0);
-			if (*endptr != '\0') {
+			err = erofs_mkfs_strtol(optarg, &endptr, &i, 0);
+			if (err < 0 || *endptr != '\0' || i <= 0) {
 				erofs_err("invalid physical clustersize %s",
 					  optarg);
 				return -EINVAL;
@@ -1228,7 +1303,13 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 					metabox_algorithmid = err;
 				}
 			}
-			pclustersize_metabox = atoi(optarg);
+			err = erofs_mkfs_strtol(optarg, &endptr, &i, 0);
+			if (err < 0 || (*endptr != '\0' && algid != endptr) ||
+			    i <= 0) {
+				erofs_err("invalid metabox option %s", optarg);
+				return -EINVAL;
+			}
+			pclustersize_metabox = i;
 			break;
 		}
 
-- 
2.43.5


