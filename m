Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EA1452E61
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 10:50:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HthBL0xdTz2yJF
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 20:50:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HthBB0c9cz2y8P
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Nov 2021 20:50:09 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UwqPg0-_1637056181; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UwqPg0-_1637056181) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 16 Nov 2021 17:49:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 5/6] erofs-utils: fsck: support multiple devices
Date: Tue, 16 Nov 2021 17:49:38 +0800
Message-Id: <20211116094939.32246-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211116094939.32246-1-hsiangkao@linux.alibaba.com>
References: <20211116094939.32246-1-hsiangkao@linux.alibaba.com>
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
Cc: Yan Song <imeoer@linux.alibaba.com>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add preliminary multiple device support for fsck feature.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index b742e3579c59..7bee5605b9df 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -24,6 +24,7 @@ static struct erofsfsck_cfg fsckcfg;
 static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
 	{"extract", no_argument, 0, 2},
+	{"device", required_argument, 0, 3},
 	{0, 0, 0, 0},
 };
 
@@ -34,6 +35,7 @@ static void usage(void)
 	      " -V              print the version number of fsck.erofs and exit.\n"
 	      " -d#             set output message level to # (maximum 9)\n"
 	      " -p              print total compression ratio of all files\n"
+	      " --device=X      specify an extra device to be used together\n"
 	      " --extract       check if all files are well encoded\n"
 	      " --help          display this help and exit.\n",
 	      stderr);
@@ -46,7 +48,7 @@ static void erofsfsck_print_version(void)
 
 static int erofsfsck_parse_options_cfg(int argc, char **argv)
 {
-	int opt, i;
+	int opt, ret;
 
 	while ((opt = getopt_long(argc, argv, "Vd:p",
 				  long_options, NULL)) != -1) {
@@ -55,12 +57,12 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			erofsfsck_print_version();
 			exit(0);
 		case 'd':
-			i = atoi(optarg);
-			if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
-				erofs_err("invalid debug level %d", i);
+			ret = atoi(optarg);
+			if (ret < EROFS_MSG_MIN || ret > EROFS_MSG_MAX) {
+				erofs_err("invalid debug level %d", ret);
 				return -EINVAL;
 			}
-			cfg.c_dbg_lvl = i;
+			cfg.c_dbg_lvl = ret;
 			break;
 		case 'p':
 			fsckcfg.print_comp_ratio = true;
@@ -71,6 +73,12 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		case 2:
 			fsckcfg.check_decomp = true;
 			break;
+		case 3:
+			ret = blob_open_ro(optarg);
+			if (ret)
+				return ret;
+			++sbi.extra_devices;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -275,6 +283,7 @@ static int verify_compressed_inode(struct erofs_inode *inode)
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
+	struct erofs_map_dev mdev;
 	int ret = 0;
 	u64 pchunk_len = 0;
 	erofs_off_t end = inode->i_size;
@@ -317,10 +326,21 @@ static int verify_compressed_inode(struct erofs_inode *inode)
 			BUG_ON(!buffer);
 		}
 
-		ret = dev_read(0, raw, map.m_pa, map.m_plen);
+		mdev = (struct erofs_map_dev) {
+			.m_deviceid = map.m_deviceid,
+			.m_pa = map.m_pa,
+		};
+		ret = erofs_map_dev(&sbi, &mdev);
+		if (ret) {
+			erofs_err("failed to map device of m_pa %" PRIu64 ", m_deviceid %u @ nid %llu: %d",
+				  map.m_pa, map.m_deviceid, inode->nid | 0ULL, ret);
+			goto out;
+		}
+
+		ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
 		if (ret < 0) {
 			erofs_err("failed to read compressed data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
-				  map.m_pa, map.m_plen, inode->nid | 0ULL, ret);
+				  mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
 			goto out;
 		}
 
@@ -336,7 +356,7 @@ static int verify_compressed_inode(struct erofs_inode *inode)
 
 		if (ret < 0) {
 			erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
-				  map.m_pa, map.m_plen, inode->nid | 0ULL, ret);
+				  mdev.m_pa, map.m_plen, inode->nid | 0ULL, ret);
 			goto out;
 		}
 	}
@@ -558,12 +578,12 @@ int main(int argc, char **argv)
 	err = erofs_read_superblock();
 	if (err) {
 		erofs_err("failed to read superblock");
-		goto exit;
+		goto exit_dev_close;
 	}
 
 	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
 		erofs_err("failed to verify superblock checksum");
-		goto exit;
+		goto exit_dev_close;
 	}
 
 	erofs_check_inode(sbi.root_nid, sbi.root_nid);
@@ -582,7 +602,10 @@ int main(int argc, char **argv)
 		}
 	}
 
+exit_dev_close:
+	dev_close();
 exit:
+	blob_closeall();
 	erofs_exit_configure();
 	return err ? 1 : 0;
 }
-- 
2.24.4

