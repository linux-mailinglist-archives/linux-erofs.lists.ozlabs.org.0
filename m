Return-Path: <linux-erofs+bounces-206-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C9A96AA9
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Apr 2025 14:45:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zhhm500Nbz3bsT;
	Tue, 22 Apr 2025 22:45:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745325924;
	cv=none; b=kAT2tK0X2ndKuzWCeeEe0b+Ir0BJy9EB2ihQAZq+4nSJio7EshgBaOHoof+Mmi6vGRO56Yd+Rh6yBumv7NBw1h9f2PvL1/oMoXheYcQKZ9tWeIjJZOLAGpNUgdw3Ijk6XCmWTZQuGY9iepwEsSKkXLJZkU/xDfS6H3tLCBA6Vzvh6Jt6y2xsfE0N75gg8t6o20LnzMrrpuuLDxzVY2swXHEw72JbyplKw+7MBaGPmMA4kM1cUAzrkkI2Ogdq9oU7dThms7BAtJCxNVyCZwklWNyoLZarDpo1RGJxLo9xVw+0cv1nHAXGyzwQIhvPasrHuW034gkeUawkOuOAhtuBig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745325924; c=relaxed/relaxed;
	bh=9CzYmadcOk2sQWtijiRnwP6SuTv70c2Zdty2hYFhFFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjrJs5XONYEwEDMKjYaLZDg3HN+iPvGC7TvOZMMSpKclrn9URpqISbmg9avqAoUqLXAr62m1h0ICgau/e8G2aJd+1tu3baYdJ7F8X0EvpyY457N/6PXplvflaySer0HfDTvSyBmu3iwBtUWrWNHH28cx6EAzvjpMt1X9HlkU2Wf/AprLDoyG/hjWUHnPezZh6BMnnGvq5zZPEX5jlC6a19RfzAbX7+c/v3OK6Bft7m/tjuHVdK1DiA9VNj97qfKIUnFeDG/VLctWD71MgXNe0EqnIdgK8ZfbVYEAMqx1mlZulytskgmU2tHTazerc5tqq53AXjNDHkV6Pg8wtHFbvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zhhm35c67z3bZs
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 22:45:22 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZhhgB046hzvWrn;
	Tue, 22 Apr 2025 20:41:10 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C2017180080;
	Tue, 22 Apr 2025 20:45:18 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Apr
 2025 20:45:18 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC 1/4] erofs-utils: lib: introduce --meta_fix format option
Date: Tue, 22 Apr 2025 12:36:09 +0000
Message-ID: <20250422123612.261764-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250422123612.261764-1-lihongbo22@huawei.com>
References: <20250422123612.261764-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-3.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The option --meta_fix format option allow the mkfs.erofs
can fix the metadata area at the front of the image file.
It makes the disk format easier.

Now we only allow to fix the metadata area at the front
in EROFS_INODE_FLAG_PLAIN layout.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 include/erofs/config.h |  1 +
 mkfs/main.c            | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 92c1467..ac6dd9b 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -66,6 +66,7 @@ struct erofs_configure {
 	bool c_xattr_name_filter;
 	bool c_ovlfs_strip;
 	bool c_hard_dereference;
+	bool c_meta_fix;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/mkfs/main.c b/mkfs/main.c
index 6d1a2de..42635c6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -87,6 +87,7 @@ static struct option long_options[] = {
 	{"sort", required_argument, NULL, 527},
 	{"hard-dereference", no_argument, NULL, 528},
 	{"dsunit", required_argument, NULL, 529},
+	{"meta_fix", no_argument, NULL, 530},
 	{0, 0, 0, 0},
 };
 
@@ -191,6 +192,7 @@ static void usage(int argc, char **argv)
 		"                                            headerball=file data is omited in the source stream)\n"
 		" --ovlfs-strip=<0,1>   strip overlayfs metadata in the target image (e.g. whiteouts)\n"
 		" --quiet               quiet execution (do not write anything to standard output.)\n"
+		" --meta_fix            make metadata area fixed at the front of the image file\n"
 #ifndef NDEBUG
 		" --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 		" --random-algorithms   randomize per-file algorithms (debugging only)\n"
@@ -886,6 +888,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 530:
+			cfg.c_meta_fix = true;
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -903,6 +908,23 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	if (cfg.c_meta_fix) {
+		if (cfg.c_compr_opts[0].alg) {
+			erofs_err("--meta_fix cannot be used with compress case");
+			return -EINVAL;
+		}
+
+		if (cfg.c_chunkbits) {
+			erofs_err("--meta_fix cannot be used with --chunksize");
+			return -EINVAL;
+		}
+
+		if (cfg.c_inline_data) {
+			erofs_info("--meta_fix force to turn off the inline_data");
+			cfg.c_inline_data = false;
+		}
+	}
+
 	/* TODO: can be implemented with (deviceslot) mapped_blkaddr */
 	if (cfg.c_blobdev_path &&
 	    cfg.c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
-- 
2.22.0


