Return-Path: <linux-erofs+bounces-2328-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IwF7IZ9HlWkLOAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2328-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 06:01:19 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8156D153154
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 06:01:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fG4971DPMz2yr6;
	Wed, 18 Feb 2026 16:01:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771390875;
	cv=none; b=ZE8aPo3+UXKmpV3apGQA3+mSPjNbG69TPUghsvb7AE72EOEfskl1dfoKcTjbLGOdPh9qT7WMuQ7qosGuVRxKNfv9t2PAxv/PUyz1imRFUqVE6z74X9pBah8rh+aRhmwC8rz5sF7zCyga42oeYA8eYO1k0Xprq9ZO3n6Lx10eUVIKdMfEyTMcctzEsAgl4o5TOq72T2EqNBlR/4EU0csJ7AUhLO58id7uS0PaGEjRuVE3nnzRnz4tiFxE8PhyGqSvbHj0AAsbwjj1hAHqMbkvdtTHtxgJbYnlDrqweFUW66oO4W0s2tRNddz6rjNGx64Ucy7HrwcKyXL1GJ0XQQuJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771390875; c=relaxed/relaxed;
	bh=MlqbCgBVsjXCrWfG0k7wDgBaLUQCc7YudU4Q0qzBc9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvLju6ewy6VYgm+sxiqFy0CUhqDR6br14H0N+WECgawEFyCbDJ14BH+J895VDgyca/+2G/sxI4VtNUd28D/OnAoVPjMbvyVNyQe8H5w45/n6Q39UyVNenVgxStWUyIqtlKDWsfO3HlhYAHBRmOXlEYJ633IoiloOPse7ja6rSnAcs+I5RzlGDMJTrETdRp1UpaFhcWZhCZtSZ9B8P5cdXtBWU6j+ryD7Kd9tmomZ6KuN6PaWpuCZW0ZBQafbVnqMeWXgimq+ij2//Ru/ALRYsb1XDUD5aDqE54B23d2HuixloB7ByXUYCC3WLO9aJ+Pa1tG5y7/sunLKwwkH4VeMFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cwlmKbT4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cwlmKbT4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fG4953X5wz2xSG
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Feb 2026 16:01:12 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771390867; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MlqbCgBVsjXCrWfG0k7wDgBaLUQCc7YudU4Q0qzBc9Q=;
	b=cwlmKbT4MukKa53/a86+RIruRpVRlfS3RQZ034W2dfci7O4Oqv5HPqb5O9FlQ27qjyeqe169W2m2ihcrPaRM0f/SBaeeoqKs23+XL1znNRz+Vc9DWfP/SGWPte1CktvuHxXMXLvhr7vxP6lSRbaodDuOIYMq4sqDPmD2XkNecrU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzRl-28_1771390865 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Feb 2026 13:01:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/2] erofs-utils: mkfs: allow multiplier suffixes ('K', 'M', 'G')
Date: Wed, 18 Feb 2026 13:01:04 +0800
Message-ID: <20260218050104.3796451-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260218045407.3783915-2-hsiangkao@linux.alibaba.com>
References: <20260218045407.3783915-2-hsiangkao@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2328-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 8156D153154
X-Rspamd-Action: no action

Apply to common arguments such as `-b`, `-C` and `-m`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - also convert erofs_mkfs_feat_set_fragments().

 mkfs/main.c | 117 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 100 insertions(+), 17 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index fb51cf87ef48..7333f1f03146 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -354,6 +354,29 @@ static int erofs_mkfs_feat_set_ztailpacking(struct erofs_importer_params *params
 	return 0;
 }
 
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
 static int erofs_mkfs_feat_set_fragments(struct erofs_importer_params *params,
 					 bool en, const char *val,
 					 unsigned int vallen)
@@ -366,10 +389,12 @@ static int erofs_mkfs_feat_set_fragments(struct erofs_importer_params *params,
 	}
 
 	if (vallen) {
+		unsigned long long i;
 		char *endptr;
-		u64 i = strtoull(val, &endptr, 0);
+		int err;
 
-		if (endptr - val != vallen) {
+		err = erofs_mkfs_strtoull(val, &endptr, &i, 0);
+		if (err || endptr - val != vallen) {
 			erofs_err("invalid pcluster size %s for the packed file", val);
 			return -EINVAL;
 		}
@@ -748,6 +773,59 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
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
@@ -765,6 +843,7 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
 {
 	char *opt, *q, *p;
 	long idx;
+	int ret;
 
 	if (!options_str)
 		return 0;
@@ -815,8 +894,8 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
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
@@ -890,12 +969,8 @@ static int mkfs_parse_one_compress_alg(char *alg)
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
@@ -1069,8 +1144,9 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
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
@@ -1179,8 +1255,9 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
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
@@ -1206,8 +1283,8 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
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
@@ -1228,7 +1305,13 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
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


