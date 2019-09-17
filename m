Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BC251B4710
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2019 07:50:10 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46XXJJ1Mt7zF453
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2019 15:50:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1568699408;
	bh=42C5Ks7VVmdn1ADQ79bSnHMMhhZ72Cvu7A6NzvLSO5M=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=W8GKHT27zJ2fDDDEWiA9Zrby3T+X+YMmgB5pwP4NHAsV3ueX7J6puIVmNAMiRm/G9
	 jkGpE+hAJpbSBEQWoVOHYWFmszw31K150zPJLfX1miBrOiVGFscLjQX5zQY8aQDSq6
	 NrxOr8g7IMgCSS6uticOsx93J3Xm+BEUaML6V0remVBav5cWK8BCkqkhiqE/Ga/Z6j
	 mWH12eTJWZc7pVWCaYoT6qy/d/R+E3Qo5FIbxAcPsrKH82mtRmlr59wqOt2TX9xUv8
	 lMK3jhl60wpKHFJ+t0xMIP3ChV9ZdwLgaPTBTjWgpBhs1EWR9rwyRWNTextFIfHFFY
	 PqHGT37pcQldw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.66.148; helo=sonic317-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="Qy+4WEck"; 
 dkim-atps=neutral
Received: from sonic317-22.consmr.mail.gq1.yahoo.com
 (sonic317-22.consmr.mail.gq1.yahoo.com [98.137.66.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46XXHv1fclzF4Fq
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2019 15:49:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1568699382; bh=m6yRXfZllEjz0YkYMdLQugkc0X59Q7ix9hD19XKr42I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=Qy+4WEckCfTTcsRVsAZA/tNOK5xm25dDXPuSo3S1bIDjOCMoWWx8LpEIs2a4a9L5wyI2NcQyLb4+4VzQ7KFkDV1utmtsPNABeOh1pwkr59/49SFw1uhNz6L2mIbgIg3sVwKM15EgbTvP7dIyjd2fDGyNOibM8HHJSfRpDvpL+TG9jt8Vd1HvWWdx6dQZ6Xy2LFLLpzAJbuVz3eethl7lCiN9zW4e18Yw8BMU1jjDE6LUbdGEpDOWPcPcnu5t7JUVULbpqAI95bk7w+Vn+TDFidOZeIwJeA6/eBu6BmSnoAVvcLKjKO7VozvMUaUckK3fujSKMrMohO42Urk8VNW8jA==
X-YMail-OSG: fEP.HhIVM1mZkIG5nfWSHH0gb4pKUnqx1p0T44iIZNz3_xMN3pFxCA9IvRIX.yJ
 DM3ZX7bexgaU4WIDfJzJDtmMNSgjbzWeRxRskddRZkHJxaIodpUm9i6bVwnrt10ppeIf0m8vgdfN
 BWVvZ3ZeVygtatuQsCzM9fdA_cNmaqmtbnMBXf8l9WR_oSOOJcE14D8vtA5BZOIwGBd78LSk16wi
 oMTF.VTHluw_ioaBjs07Z1CdxcOfsSyfpJEyImvlCzri9gR.fTDtaHrNDCdbG1V07pils7wi6LDf
 kD2tt99_7hBiCapSfWcs7NwRKtMBeMZNpWtfoB3oRr1Dow7XQxPbQG46EaSiaLr93zTlfjndK9EH
 xl6OK8HGAwK9INOYa8mt5xIxdS0fCbO6TmOZ8ZMjOMy7YaubbRnNFISjhQKURhuwSOCHVfaKLeR9
 Vp9H1FK0tuRPpGYZl9GTnZ6a9y1uBBT4GwRR2ctLIw6egDXEdhtCZaTnBz6mUx1UnFW8IdcEBFJq
 VjNIJha7Zzk8NB0O3HzMjnhkZODyM8AdER897vMX4Ftt0zcuYGlZlMxingrXjRl9dhwIObaiuKOQ
 RUA9pDR96FAzgKe7IhAn._XIvliwbU8ppWU92uyQ_YaLcKVlv0GJwTxdLTvNF24FSpP0PjsBH7OR
 BB9eGEYugBQLNOwR_kVUNriL_tM8qJUIkxq5TQVjMih2uIuRdfYFJEJwuYnt9sb8k05aVl.op5hj
 eteXQ7Ga7eoPgWZOlLLUrjVILjbUvI8OH8SHAE1W0IhaFhbUoB_.D0VDudeoPtOV7djvsmmF.daV
 fW1xU50B4.QZUvB6liHGzVgHS3ikStLDQ8NGqP9TBEtFiV0Lla0KYbYX2C7yIvUQD.afssd6RhFm
 qdHv5ID4RFuNNfOUHbo8XT2kibyT2SOCNcZ9FsHKftFBRMYuKCRxZq9ttev4ZGp607wX8j5_hjCh
 T0cul3Wjbe5hxS5knLMWu3LKl6cvnP5jQVWErXmFDg_7H3msUaIdSCFdJJ3uwGl3Q6etVTvSHxVw
 GEpwB7fKZs9I2l9lFmg4pPMvtk6joB.G3pzebhJrd8ow8oAX1.uolciFfDrdIo6qfEo9xdNK6mjU
 ua6U3VQtJEoyCD7pElVSWR2_NGDOrQEZ9OW5ybeZatQWvzLNow.NNAj9NV_FFdVERlaa8ChRb4oY
 sPxfwnxOIFrb7aZouobtr6eCKZ9OkDCNELRhHUeOsY3ckrCfB7BMJpQj6zLtooIjBbEgvHcSdPmF
 HT_w9qhxWLonQp39hBJtYrUQynITEQAhXrtYJk7kyQC59Lpah_Sxt6Lm2W2FrFD_vdHnrfks5.xY
 eAZk0HM2y169jw9sTl_wD6HZB_gw1vJOjXvdRPHM-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Tue, 17 Sep 2019 05:49:42 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 0ca914cfda0cd9061c391ed841b64b5d; 
 Tue, 17 Sep 2019 05:49:36 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH 2/3] erofs-utils: resize image to the correct size
Date: Tue, 17 Sep 2019 13:49:12 +0800
Message-Id: <20190917054913.24187-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190917054913.24187-1-hsiangkao@aol.com>
References: <20190917054913.24187-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

In the end, it's necessary to resize image to
the proper size since buffers could be dropped.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/io.h |  1 +
 lib/io.c           | 32 +++++++++++++++++++++++++++++++-
 mkfs/main.c        | 11 ++++++++---
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index 4b574bd..9775047 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -21,6 +21,7 @@ void dev_close(void);
 int dev_write(const void *buf, u64 offset, size_t len);
 int dev_fillzero(u64 offset, size_t len, bool padding);
 int dev_fsync(void);
+int dev_resize(erofs_blk_t nblocks);
 u64 dev_length(void);
 
 static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
diff --git a/lib/io.c b/lib/io.c
index 15c5a35..7f5f94d 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -79,6 +79,7 @@ int dev_open(const char *dev)
 			close(fd);
 			return ret;
 		}
+		erofs_devsz = round_down(erofs_devsz, EROFS_BLKSIZ);
 		break;
 	case S_IFREG:
 		ret = ftruncate(fd, 0);
@@ -98,7 +99,6 @@ int dev_open(const char *dev)
 
 	erofs_devname = dev;
 	erofs_devfd = fd;
-	erofs_devsz = round_down(erofs_devsz, EROFS_BLKSIZ);
 
 	erofs_info("successfully to open %s", dev);
 	return 0;
@@ -177,3 +177,33 @@ int dev_fsync(void)
 	}
 	return 0;
 }
+
+int dev_resize(unsigned int blocks)
+{
+	int ret;
+	struct stat st;
+	u64 length;
+
+	if (cfg.c_dry_run || erofs_devsz != INT64_MAX)
+		return 0;
+
+	ret = fstat(erofs_devfd, &st);
+	if (ret) {
+		erofs_err("failed to fstat.");
+		return -errno;
+	}
+
+	length = (u64)blocks * EROFS_BLKSIZ;
+	if (st.st_size == length)
+		return 0;
+	if (st.st_size > length)
+		return ftruncate(erofs_devfd, length);
+
+	length = length - st.st_size;
+#if defined(HAVE_FALLOCATE)
+	if (fallocate(erofs_devfd, 0, st.st_size, length) >= 0)
+		return 0;
+#endif
+	return dev_fillzero(st.st_size, length, true);
+}
+
diff --git a/mkfs/main.c b/mkfs/main.c
index 5efbf30..2dfd68e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -145,7 +145,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 }
 
 int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
-				  erofs_nid_t root_nid)
+				  erofs_nid_t root_nid,
+				  erofs_blk_t *blocks)
 {
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
@@ -166,7 +167,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		sb.build_time_nsec = cpu_to_le32(t.tv_usec);
 	}
 
-	sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
+	*blocks         = erofs_mapbh(NULL, true);
+	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
 
 	buf = calloc(sb_blksize, 1);
@@ -189,6 +191,7 @@ int main(int argc, char **argv)
 	struct erofs_inode *root_inode;
 	erofs_nid_t root_nid;
 	struct stat64 st;
+	erofs_blk_t nblocks;
 
 	erofs_init_configure();
 	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
@@ -250,13 +253,15 @@ int main(int argc, char **argv)
 	root_nid = erofs_lookupnid(root_inode);
 	erofs_iput(root_inode);
 
-	err = erofs_mkfs_update_super_block(sb_bh, root_nid);
+	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks);
 	if (err)
 		goto exit;
 
 	/* flush all remaining buffers */
 	if (!erofs_bflush(NULL))
 		err = -EIO;
+	else
+		err = dev_resize(nblocks);
 exit:
 	z_erofs_compress_exit();
 	dev_close();
-- 
2.17.1

