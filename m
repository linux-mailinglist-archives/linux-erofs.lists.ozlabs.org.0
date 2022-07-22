Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7DC57D9CF
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 07:36:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LpyqF2LKCz3c79
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 15:36:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=URg48H/G;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=URg48H/G;
	dkim-atps=neutral
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lpyq70yrwz2yWr
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jul 2022 15:36:34 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 72so3619350pge.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jul 2022 22:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=u6f9e60WcvgLR+en7mRdy/aA0ZVyOpP47eGUs8NR82E=;
        b=URg48H/G2SigMfNqqUCDvGbmvP8rlVLKdPKrTZ/SFlkc7cs76yJlyd5XCWKX9tKFzK
         Whq7s7tWGF3hfIyOU208RN+F52+x+6yAvRdVAZ+Pm5oBYRSfYet0/EvNBl6wT/uAxzAC
         QRbsWtdUjJaOJCGQKZMAMSULisQjS5InUToOPZgaRCnFjQ2KYZR1JKq9p64ZozUdCcPw
         aNtyCn5CAhEcl5OwyS4ByGPr4+N7zcgxm2jx6ZPzxu9EHPR9y+5/fAmmt7JVjVPhN187
         4MTo4hX1BzX/+ntmrmY0sftoG9KAm0n1kqhXiw5XG1HofSpfoiiJRltdpAX8/I8Z26B6
         QC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u6f9e60WcvgLR+en7mRdy/aA0ZVyOpP47eGUs8NR82E=;
        b=SCVqUXUilwenHFDT7BDcCCzxzIqPGxgylqX2PqfFjQvaUdeEa4y06HmVz45pQJhagI
         IXmq8DxzGR1Pexa1ii3t7hGNJLNkn8qjYIKSFygbwCboiarcDeAWTm01v396i24+U5bt
         WuZQdhm4r3G6hUay9xHLHbRyMY3iZlC/mXqoVbZ8ANBXCDjzJ9igHJXlGB0CjtJUkr43
         cbIErPdQS81Ke3TVVE+3NgTrqDF5Ju1f/QDpB2XOL2bJ2AIwmprtHBohqZTZl5TvC4vW
         +ulcA8ZUNvZj8mkfq/SUii6vYeD25vgkczSmz5uxfYCVJPLAUSiwrbNLFgmiBu0qkIcZ
         3vhw==
X-Gm-Message-State: AJIora9VvXE+OILATRinmsspzYzWSfPw5/d0AqISBuyrzwka9Q3AOwp2
	ao8hTrGD+Bcptd1j8pNnN7GcYJBMGUU=
X-Google-Smtp-Source: AGRyM1sj4H85mPOiXW/txSbyPPwKqXBXcagJcxZ+71CLQ+rgFbL/kOsYpVq6GN/UnrkfTGZEeQh+hA==
X-Received: by 2002:a63:c53:0:b0:412:6f28:7a87 with SMTP id 19-20020a630c53000000b004126f287a87mr1822618pgm.136.1658468190524;
        Thu, 21 Jul 2022 22:36:30 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7990b000000b005281d926733sm2738659pff.199.2022.07.21.22.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 22:36:30 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fix a memory leak of multiple devices
Date: Fri, 22 Jul 2022 13:36:10 +0800
Message-Id: <20220722053610.23912-1-huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
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
Cc: huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The memory allocated for multiple devices should be freed after use.
Let's add a helper to fix it since there is more than one to use it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 dump/main.c              |  4 +++-
 fsck/main.c              |  4 +++-
 fuse/main.c              |  2 ++
 include/erofs/internal.h |  1 +
 lib/super.c              | 12 +++++++++++-
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 40e850a..f2a09b6 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -630,12 +630,14 @@ int main(int argc, char **argv)
 
 	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
 		usage();
-		goto exit_dev_close;
+		goto exit_put_super;
 	}
 
 	if (dumpcfg.show_inode)
 		erofsdump_show_fileinfo(dumpcfg.show_extent);
 
+exit_put_super:
+	erofs_put_super();
 exit_dev_close:
 	dev_close();
 exit:
diff --git a/fsck/main.c b/fsck/main.c
index 5a2f659..8ed3fc5 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -818,7 +818,7 @@ int main(int argc, char **argv)
 
 	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
 		erofs_err("failed to verify superblock checksum");
-		goto exit_dev_close;
+		goto exit_put_super;
 	}
 
 	err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
@@ -843,6 +843,8 @@ int main(int argc, char **argv)
 		}
 	}
 
+exit_put_super:
+	erofs_put_super();
 exit_dev_close:
 	dev_close();
 exit:
diff --git a/fuse/main.c b/fuse/main.c
index 95f939e..3e55bb8 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -299,6 +299,8 @@ int main(int argc, char *argv[])
 	}
 
 	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
+
+	erofs_put_super();
 err_dev_close:
 	blob_closeall();
 	dev_close();
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6a70f11..48498fe 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -318,6 +318,7 @@ struct erofs_map_dev {
 
 /* super.c */
 int erofs_read_superblock(void);
+void erofs_put_super(void);
 
 /* namei.c */
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
diff --git a/lib/super.c b/lib/super.c
index f486eb7..b267412 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -46,14 +46,18 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 
 	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
 	sbi->devs = calloc(ondisk_extradevs, sizeof(*sbi->devs));
+	if (!sbi->devs)
+		return -ENOMEM;
 	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
 	for (i = 0; i < ondisk_extradevs; ++i) {
 		struct erofs_deviceslot dis;
 		int ret;
 
 		ret = dev_read(0, &dis, pos, sizeof(dis));
-		if (ret < 0)
+		if (ret < 0) {
+			free(sbi->devs);
 			return ret;
+		}
 
 		sbi->devs[i].mapped_blkaddr = dis.mapped_blkaddr;
 		sbi->total_blocks += dis.blocks;
@@ -109,3 +113,9 @@ int erofs_read_superblock(void)
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
 	return erofs_init_devices(&sbi, dsb);
 }
+
+void erofs_put_super(void)
+{
+	if (sbi.devs)
+		free(sbi.devs);
+}
-- 
2.17.1

