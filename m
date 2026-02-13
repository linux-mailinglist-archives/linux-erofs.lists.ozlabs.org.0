Return-Path: <linux-erofs+bounces-2314-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD95Ep7TjmnJFAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2314-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Feb 2026 08:32:46 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2036C13397A
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Feb 2026 08:32:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fC3m90XtWz2xdY;
	Fri, 13 Feb 2026 18:32:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770967961;
	cv=none; b=JHgriTyGVgK91X6zYpc35A8fLTluZTgPpxmgmVedyCN8DXHrwOpspWqqEqGlUi8RffdKibwMP5dZ4K9Heb93RXrLImnSRZ3WgUCdMakaTz6FIpZB2dkHOwPNFi3sBu1vH1yKAWb60KZl0W64ejkTgTwRTdrCh5t6DZqsUED5OGze+JmUake3ivRD/uODUjyDPv8xIaw6lYrla9z2xIz4WYTA+Nqr8m63PXYRkxRFgqmrB6a45zCkMdaadW3FKdSw2JL2AzIx0brtbxkbjAonwT7XFqW4tsgz3Po9qLfBGU3FYCj8+5WT38Yqm4QBzczh/h6ILfzzxRzZhZwYwg1iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770967961; c=relaxed/relaxed;
	bh=POjL6akkNPrMf0acuyX/AvKl8IDrRqR2qVDZoi9mqGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFkNcPfxkROfFSqHTMr5Y2+v7iKN46HAoinIluMifMjP0x8++V4MUaN/wozukHKwgRqgzyxegyyT2MYA0twobqZqrO0YogptUX3sJyYWmV2gnME4G5vk8NURBGoqRTaVBuioNOW4xWDGSseKrnjqdnjZkCEOPOzCJ6mglAQtRz+taGfMNOqjmY4oLtw2Jqu5UGDENu+x+u7QzbwjBhf7o+japbYbSNKGpiHxxVdiR0bHh/i7+7BjVVkpFeJy0aA9HQBIzeGEac7N/bq/vaDOXnAUkHJIK48R4kkGtjwZdq0lPX4V+XjN8ePLtV9DqLmpLGLfMzoGRRPeFNh3vvx4Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AXiFN049; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AXiFN049;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fC3m60mRQz2yL8
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Feb 2026 18:32:36 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=POjL6akkNPrMf0acuyX/AvKl8IDrRqR2qVDZoi9mqGA=;
	b=AXiFN049sHL4E+vMyenaeqENMfHz09L7qU7+7RWebXK3MxkMaclv7+5LgdzfsaCIm8RPsKarr
	P82D/ofTAmw02AUKUvsaJ5zqWN9XqYqCcA7pa6ebwIuKgN5OIXtvcYayhhlRJcNn0HP1WpXhNCf
	L4eJmqgQF8vOlrbCRy5zzHs=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fC3fX3wxHz1prRG;
	Fri, 13 Feb 2026 15:27:48 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 86D684036C;
	Fri, 13 Feb 2026 15:32:30 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 13 Feb
 2026 15:32:30 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 2/2] erofs-utils: mkfs: validate source and dataimport mode combinations
Date: Fri, 13 Feb 2026 15:32:41 +0800
Message-ID: <20260213073241.525158-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213073241.525158-1-zhaoyifan28@huawei.com>
References: <20260213073241.525158-1-zhaoyifan28@huawei.com>
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
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
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
	TAGGED_FROM(0.00)[bounces-2314-lists,linux-erofs=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 2036C13397A
X-Rspamd-Action: no action

This patch adds validation for all combinations of source mode and
dataimport mode, and prints corresponding error/warning messages.
It should have no impact on external behavior.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 mkfs/main.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 131 insertions(+), 13 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index a948b2e..e369347 100644
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
@@ -300,6 +300,10 @@ static struct ocierofs_config ocicfg;
 static bool mkfs_oci_tarindex_mode;
 
 enum {
+	/* XXX: the "DEFAULT" mode is actually source-dependent,
+	 * meaning BLOB_INDEX for rebuild mode and FULLDATA for others.
+	 * Consider refactoring this...
+	 */
 	EROFS_MKFS_DATA_IMPORT_DEFAULT,
 	EROFS_MKFS_DATA_IMPORT_FULLDATA,
 	EROFS_MKFS_DATA_IMPORT_RVSP,
@@ -314,6 +318,118 @@ static enum {
 	EROFS_MKFS_SOURCE_REBUILD,
 } source_mode;
 
+static int erofs_mkfs_validate_source_datamode(void)
+{
+	int status;
+	enum {
+		EROFS_MKFS_CLEAN_MODE = 0,
+		EROFS_MKFS_INCREMENTAL_MODE = 1
+	};
+	const char *SOURCE_NAME[] = {
+		[EROFS_MKFS_SOURCE_LOCALDIR] = "localdir source",
+		[EROFS_MKFS_SOURCE_TAR] = "tarball source",
+		[EROFS_MKFS_SOURCE_S3] = "S3-compatible object store source",
+		[EROFS_MKFS_SOURCE_OCI] = "OCI remote source",
+		[EROFS_MKFS_SOURCE_REBUILD] = "rebuilding from existing EROFS image(s)",
+	};
+	const char *DATAIMPORT_NAME[] = {
+		[EROFS_MKFS_DATA_IMPORT_DEFAULT] = "default", // placeholder
+		[EROFS_MKFS_DATA_IMPORT_FULLDATA] = "data",
+		[EROFS_MKFS_DATA_IMPORT_RVSP] = "rvsp",
+		[EROFS_MKFS_DATA_IMPORT_ZEROFILL] = "0",
+	};
+	enum {
+		INVALID = 0, // INVALID must be 0 for static initialization
+		NOP = 1,
+		SUPPORTED = 2,
+	};
+	static const int support[EROFS_MKFS_SOURCE_REBUILD + 1][EROFS_MKFS_INCREMENTAL_MODE + 1][EROFS_MKFS_DATA_IMPORT_ZEROFILL + 1] = {
+		[EROFS_MKFS_SOURCE_LOCALDIR] = {
+			[EROFS_MKFS_CLEAN_MODE] = {
+				[EROFS_MKFS_DATA_IMPORT_FULLDATA] = SUPPORTED,
+				[EROFS_MKFS_DATA_IMPORT_RVSP] = NOP,
+				[EROFS_MKFS_DATA_IMPORT_ZEROFILL] = NOP
+			},
+			[EROFS_MKFS_INCREMENTAL_MODE] = {
+				[EROFS_MKFS_DATA_IMPORT_FULLDATA] = SUPPORTED,
+				[EROFS_MKFS_DATA_IMPORT_RVSP] = NOP,
+				[EROFS_MKFS_DATA_IMPORT_ZEROFILL] = NOP
+			},
+		},
+		[EROFS_MKFS_SOURCE_TAR] = {
+			[EROFS_MKFS_CLEAN_MODE] = {
+				[EROFS_MKFS_DATA_IMPORT_FULLDATA] = SUPPORTED,
+				[EROFS_MKFS_DATA_IMPORT_RVSP] = SUPPORTED,
+				[EROFS_MKFS_DATA_IMPORT_ZEROFILL] = NOP
+			},
+			[EROFS_MKFS_INCREMENTAL_MODE] = {
+				[EROFS_MKFS_DATA_IMPORT_FULLDATA] = SUPPORTED,
+				[EROFS_MKFS_DATA_IMPORT_RVSP] = SUPPORTED,
+				[EROFS_MKFS_DATA_IMPORT_ZEROFILL] = NOP
+			},
+		},
+		[EROFS_MKFS_SOURCE_S3] = {
+			[EROFS_MKFS_CLEAN_MODE] = {
+				[EROFS_MKFS_DATA_IMPORT_FULLDATA] = SUPPORTED,
+				[EROFS_MKFS_DATA_IMPORT_ZEROFILL] = SUPPORTED,
+			},
+		},
+		[EROFS_MKFS_SOURCE_OCI] = {
+			[EROFS_MKFS_CLEAN_MODE] = {
+				[EROFS_MKFS_DATA_IMPORT_FULLDATA] = SUPPORTED
+			},
+		},
+		[EROFS_MKFS_SOURCE_REBUILD] = {
+			[EROFS_MKFS_CLEAN_MODE] = {
+				[EROFS_MKFS_DATA_IMPORT_DEFAULT] = SUPPORTED,
+				/* XXX: FULLDATA rebuild mode doesn't work actually, let's keep
+				 * its behavior until v1.9 is released to avoid breaking anyone who
+				 * might rely on it...
+				 */
+				[EROFS_MKFS_DATA_IMPORT_FULLDATA] = SUPPORTED,
+				[EROFS_MKFS_DATA_IMPORT_RVSP] = SUPPORTED,
+			},
+			[EROFS_MKFS_INCREMENTAL_MODE] = {
+				[EROFS_MKFS_DATA_IMPORT_DEFAULT] = SUPPORTED,
+				/* XXX: FULLDATA rebuild mode doesn't work actually, let's keep
+				 * its behavior until v1.9 is released to avoid breaking anyone who
+				 * might rely on it...
+				 */
+				[EROFS_MKFS_DATA_IMPORT_FULLDATA] = SUPPORTED,
+				[EROFS_MKFS_DATA_IMPORT_RVSP] = SUPPORTED,
+			},
+		},
+	};
+	int real_dataimport_mode = dataimport_mode;
+	if (real_dataimport_mode == EROFS_MKFS_DATA_IMPORT_DEFAULT)
+		real_dataimport_mode = (source_mode == EROFS_MKFS_SOURCE_REBUILD) ?
+			EROFS_MKFS_DATA_IMPORT_DEFAULT : EROFS_MKFS_DATA_IMPORT_FULLDATA;
+
+	if (source_mode < 0 || source_mode > EROFS_MKFS_SOURCE_REBUILD)
+		return -EINVAL;
+
+	if (real_dataimport_mode < EROFS_MKFS_DATA_IMPORT_DEFAULT ||
+	    real_dataimport_mode > EROFS_MKFS_DATA_IMPORT_ZEROFILL)
+		return -EINVAL;
+
+	status = support[source_mode][incremental_mode ? EROFS_MKFS_INCREMENTAL_MODE : EROFS_MKFS_CLEAN_MODE][real_dataimport_mode];
+	if (status == SUPPORTED) {
+		return 0;
+	} else if (status == NOP) {
+		erofs_warn("datamode '%s' under %s mode is a no-op for %s.",
+			   DATAIMPORT_NAME[real_dataimport_mode],
+			   incremental_mode ? "incremental" : "clean",
+			   SOURCE_NAME[source_mode]);
+		return 0;
+	} else {
+		erofs_err("datamode '%s' under %s mode is not supported for %s.",
+			  DATAIMPORT_NAME[real_dataimport_mode],
+			  incremental_mode ? "incremental" : "clean",
+			  SOURCE_NAME[source_mode]);
+		return -EOPNOTSUPP;
+	}
+}
+
 static unsigned int rebuild_src_count, total_ccfgs;
 static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
@@ -1570,6 +1686,10 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 
 	if (has_timestamp && cfg.c_timeinherit == TIMESTAMP_UNSPECIFIED)
 		cfg.c_timeinherit = TIMESTAMP_FIXED;
+
+	err = erofs_mkfs_validate_source_datamode();
+	if (err)
+		return err;
 	return 0;
 }
 
@@ -1631,11 +1751,16 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 		datamode = EROFS_REBUILD_DATA_BLOB_INDEX;
 		break;
 	case EROFS_MKFS_DATA_IMPORT_FULLDATA:
+		/* XXX: fulldata rebuild is unsupported, but let's keep this behavior
+		 * in case anyone relies on it until v1.9 is released...
+		 */
 		datamode = EROFS_REBUILD_DATA_FULL;
 		break;
 	case EROFS_MKFS_DATA_IMPORT_RVSP:
 		datamode = EROFS_REBUILD_DATA_RESVSP;
 		break;
+	case EROFS_MKFS_DATA_IMPORT_ZEROFILL:
+		return -EOPNOTSUPP;
 	default:
 		return -EINVAL;
 	}
@@ -1786,6 +1911,8 @@ int main(int argc, char **argv)
 	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		if (dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
 			erofstar.rvsp_mode = true;
+		if (erofstar.index_mode && erofstar.rvsp_mode)
+			erofs_warn("rvsp mode takes precedence and tar index mode is ignored");
 		erofstar.dev = rebuild_src_count + 1;
 
 		if (erofstar.mapfile) {
@@ -1950,12 +2077,8 @@ int main(int argc, char **argv)
 			s3cfg.secret_key[S3_SECRET_KEY_LEN] = '\0';
 		}
 
-		if (incremental_mode ||
-		    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
-			err = -EOPNOTSUPP;
-		else
-			err = s3erofs_build_trees(&importer, &s3cfg,
-						  cfg.c_src_path,
+		err = s3erofs_build_trees(&importer, &s3cfg,
+					  cfg.c_src_path,
 				dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
 #endif
 #ifdef OCIEROFS_ENABLED
@@ -1966,12 +2089,7 @@ int main(int argc, char **argv)
 			if (!ocicfg.zinfo_path)
 				ocicfg.zinfo_path = mkfs_aws_zinfo_file;
 
-			if (incremental_mode ||
-			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP ||
-			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL)
-				err = -EOPNOTSUPP;
-			else
-				err = ocierofs_build_trees(&importer, &ocicfg);
+			err = ocierofs_build_trees(&importer, &ocicfg);
 			if (err)
 				goto exit;
 #endif
-- 
2.47.3


