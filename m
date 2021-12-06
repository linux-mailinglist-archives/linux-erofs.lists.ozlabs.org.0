Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01070469741
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Dec 2021 14:36:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J74G01m4hz2yZv
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Dec 2021 00:36:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J74Fv5v5xz2xF9
 for <linux-erofs@lists.ozlabs.org>; Tue,  7 Dec 2021 00:36:17 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0UzdPBaU_1638797756; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UzdPBaU_1638797756) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 06 Dec 2021 21:36:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: add an option to dump an inode by path
Date: Mon,  6 Dec 2021 21:35:55 +0800
Message-Id: <20211206133555.42292-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211201214802.1545918-1-zhangkelvin@google.com>
References: <20211201214802.1545918-1-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Kelvin Zhang <zhangkelvin@google.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Kelvin Zhang <zhangkelvin@google.com>

This is useful when playing around with EROFS images locally.
For example, it allows us to inspect block mappings of a filepath.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Kelvin,

I plan to apply the following path, since it's somewhat weird to just
fsck a specific path. Also I completed the manpage and fix some minor
issues.

Thanks,
Gao Xiang

 dump/main.c      | 14 +++++++++++++-
 man/dump.erofs.1 |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/dump/main.c b/dump/main.c
index f85903b059d2..b8ee88761ff0 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -23,6 +23,7 @@ struct erofsdump_cfg {
 	bool show_superblock;
 	bool show_statistics;
 	erofs_nid_t nid;
+	const char *inode_path;
 };
 static struct erofsdump_cfg dumpcfg;
 
@@ -71,6 +72,7 @@ static struct option long_options[] = {
 	{"help", no_argument, NULL, 1},
 	{"nid", required_argument, NULL, 2},
 	{"device", required_argument, NULL, 3},
+	{"path", required_argument, NULL, 4},
 	{0, 0, 0, 0},
 };
 
@@ -103,6 +105,7 @@ static void usage(void)
 	      " -s              show information about superblock\n"
 	      " --device=X      specify an extra device to be used together\n"
 	      " --nid=#         show the target inode info of nid #\n"
+	      " --path=X        show the target inode info of path X\n"
 	      " --help          display this help and exit.\n",
 	      stderr);
 }
@@ -148,6 +151,11 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 				return err;
 			++sbi.extra_devices;
 			break;
+		case 4:
+			dumpcfg.inode_path = optarg;
+			dumpcfg.show_inode = true;
+			++dumpcfg.totalshow;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -450,7 +458,11 @@ static void erofsdump_show_fileinfo(bool show_extent)
 		.m_la = 0,
 	};
 
-	err = erofs_read_inode_from_disk(&inode);
+	if (dumpcfg.inode_path)
+		err = erofs_ilookup(dumpcfg.inode_path, &inode);
+	else
+		err = erofs_read_inode_from_disk(&inode);
+
 	if (err) {
 		erofs_err("read inode failed @ nid %llu", inode.nid | 0ULL);
 		return;
diff --git a/man/dump.erofs.1 b/man/dump.erofs.1
index 8efb161b65f1..fd437cfcc250 100644
--- a/man/dump.erofs.1
+++ b/man/dump.erofs.1
@@ -22,6 +22,9 @@ You may give multiple `--device' options in the correct order.
 .BI "\-\-nid=" NID
 Specify an inode NID in order to print its file information.
 .TP
+.BI "\-\-path=" path
+Specify an inode path in order to print its file information.
+.TP
 .BI \-e
 Show the file extent information. The option depends on option --nid to specify NID.
 .TP
-- 
2.24.4

