Return-Path: <linux-erofs+bounces-1561-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C56DDCD8AD7
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 11:01:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db9WK72qzz2xlP;
	Tue, 23 Dec 2025 21:01:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766484061;
	cv=none; b=AynMmNftqvdVaxMJsK5pNCqgD7XcuGnbHmZkYcfRXq/txa26jtB3KUR0XkQFVOxT0FiEQcPrPBUiHIBRHpUT7CnuUzLuoOy1Ku/LjLgDR0nVhnicp/o2qfR55/6ac3eMzndB/g/ZZ9uCvyowFo0LRZnxP5BkIcvGwZs4ECI5umx0uUhfiEx8u4sKi7quTmy9dJpNFAQpETYqhE4WJWPtMHspRQFFXzrBopKMfgn1zQST3PgEnXetoKFlybO4NWLhV97ewGJEJqxERSQ0X//juniy7gKumzdk21luLSQxJQBivpi67bAxdzrlK9iVkaGnHJ8lGtb+K6so0V/SW9jOow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766484061; c=relaxed/relaxed;
	bh=1/k0tCziJvwTD+qmK4z+2SWARBZ8wqLDK/qYuteVF+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PUNPIXb2UWrMpF5mDpJ0MOhD/GAAcqcTr9/HaDTvNMRHZvpwIOdP40ZE3DBT7g8B78zwUiAgU0oCeObY2fqP8TrPomeyqXWSxnvCUB6A0QatRs227y3IB4KHYKMowVLh6JuIqYQE5tXvWXVikJxu7vMzKHzgQ+7dNEOwGSwHvvH7p/6st9XB86zbK8EP1rr5wi2yz1Wp9xbEN6UxsjgNY7MS6RIzMckIlAsE/1Ok2wFbZsSz2KhpTnuZz7VDAytExIeexmW3ZLLYZ/B3/Jz/DXkRPjMGXLMp7liX/Otq3Rwn8398sbGN+sBere8FYV+8pE41Y1VPRt+zj8hwfMFRgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hBfBzzMm; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hBfBzzMm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db9WH4KFBz2x99
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 21:00:57 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1/k0tCziJvwTD+qmK4z+2SWARBZ8wqLDK/qYuteVF+g=;
	b=hBfBzzMmkwrS/T4KLqBZfoOz7ADNWcRVsNm558X7Y52JGzzNPhCATg6IiuPlVd8PxZiKiL+xs
	tno5jiAoQKOlprfS+T0TmzRdsN97NWAwyvjrikUvBR9ym/RXG1rcXNPcRuyL3f1uHKlKPl0rCGN
	3LYAWUJZuzFRGHuNDa1APTo=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4db9RQ1vwfz12LKX
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 17:57:38 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 37A26201E8
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 18:00:51 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 18:00:50 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 1/5] erofs-utils: mount: add "-d <0-9>" option to set debug level
Date: Tue, 23 Dec 2025 17:59:52 +0800
Message-ID: <20251223095952.229246-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add support for setting the debug level, a feature currently missing in
mount.erofs.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/backends/nbd.c |  2 +-
 mount/main.c       | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index 77c4f60..da27334 100644
--- a/lib/backends/nbd.c
+++ b/lib/backends/nbd.c
@@ -321,7 +321,7 @@ static int erofs_nbd_nl_cfg_cb(struct nl_msg *msg, void *arg)
 		ctx->errcode = -EBADMSG;
 	}
 	*ctx->index = nla_get_u32(msg_attr[NBD_ATTR_INDEX]);
-	erofs_dbg("Connected /dev/nbd%d\n", *ctx->index);
+	erofs_dbg("Connected /dev/nbd%d", *ctx->index);
 	ctx->errcode = 0;
 	return NL_OK;
 }
diff --git a/mount/main.c b/mount/main.c
index 29d1884..02a7962 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -91,6 +91,7 @@ static void usage(int argc, char **argv)
 		"General options:\n"
 		" -V, --version         print the version number of mount.erofs and exit\n"
 		" -h, --help            display this help and exit\n"
+		" -d <0-9>              set output verbosity; 0=quiet, 9=verbose (default=%i)\n"
 		" -o options            comma-separated list of mount options\n"
 		" -t type[.subtype]     filesystem type (and optional subtype)\n"
 		"                       subtypes: fuse, local, nbd\n"
@@ -109,7 +110,7 @@ static void usage(int argc, char **argv)
 		"   oci.zinfo=<path>    path to gzip zinfo file (optional)\n"
 		"   oci.insecure        use HTTP instead of HTTPS (optional)\n"
 #endif
-		, argv[0]);
+		, argv[0], EROFS_WARN);
 }
 
 static void version(void)
@@ -279,10 +280,11 @@ static int erofsmount_parse_options(int argc, char **argv)
 	};
 	char *dot;
 	int opt;
+	int i;
 
 	nbdsrc.ocicfg.layer_index = -1;
 
-	while ((opt = getopt_long(argc, argv, "VNfhno:st:uv",
+	while ((opt = getopt_long(argc, argv, "VNfhd:no:st:uv",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'h':
@@ -291,6 +293,14 @@ static int erofsmount_parse_options(int argc, char **argv)
 		case 'V':
 			version();
 			exit(0);
+		case 'd':
+			i = atoi(optarg);
+			if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
+				erofs_err("invalid debug level %d", i);
+				return -EINVAL;
+			}
+			cfg.c_dbg_lvl = i;
+			break;
 		case 'o':
 			mountcfg.full_options = optarg;
 			mountcfg.flags =
-- 
2.43.0


