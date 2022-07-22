Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9D657D8E3
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 05:10:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LpvZx1H8Nz3c7s
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 13:10:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=drSpwTYW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=drSpwTYW;
	dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LpvZr52MLz30LR
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jul 2022 13:10:43 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id s206so3369916pgs.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jul 2022 20:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=uTejcsvJoytylOPn0fQyhlU3yuDTQeSxoTbOL1b0N5c=;
        b=drSpwTYWOHnEpz9txvTt4zBEx+zjWMGbTeUXayy/IycxNXW75/JnjsZ0XJbLs2l86v
         ZSUJCDXv2RJOE+BWweL/6wgTrt2LF43LZxRFsrzbqWAiUKhQIdtgs5E5Kp+O7gTZrB0t
         8pXCkCQbQ+8OVYdlZejkDjvJbOohckkhp3taBUABpmtzRfku5NxrClr/7qcQw9BZdYQN
         ZxjoDvf7M46hlWeYYqBJhbwhYrdiweRCGCaOaLp3QmTbR8dIieKRBsBFtYFbto/sl3e9
         Z3YKgR5QwYKDYrJrChkqkRwRIh3B2iK9ieU+kVVAXhWY6WWRJEQA2nq8qxffBaz+Imc3
         Fsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=uTejcsvJoytylOPn0fQyhlU3yuDTQeSxoTbOL1b0N5c=;
        b=FGeNMP6O/YM/xoLrsvQ5jZSYDJaDxJyVIhD1lkh/fg5+rJzz0wbD/tGKmvKGwlGvZG
         LfzcpCYG1TPncZ5vVxnVfVR+OW2QSboT/H+6fY94Gi3TAI+MBuyK5ZkuiZlTBWjlZ0Sw
         Ri3ev+JZT/J0Ql7jbnGoeTNV4M+Y12XIa2jJZdf1c/ODaAdqN7uC7VOD3KRgdKyqoFVw
         Y6a+1TmxWqlOUAoE7qQbIsND8KN2aFMQibVMDUupZ3pCfQgLK5ELaNSpDmw5QDje0Bp7
         EAoEqmQDi9JDdXeJEj5Oz1ESKBqRg72hQqhBoImIwWkdMkKdQYBBKRgwOOd6mwIQG8tP
         LIew==
X-Gm-Message-State: AJIora9uBYAM0x5u7nDeAPlztmX6lYk4X82uk7I9I6tjSLMK3qgCsk6H
	7/nJrKDHxrq1c1ACkJL0275i962gwd4=
X-Google-Smtp-Source: AGRyM1vqTCIKc+uSVmCLNbGhZ8w6pn34WIkhusZAQfTlZVs49id3ee+f84i5Fr/KietV0tPkQvcJXw==
X-Received: by 2002:a65:6b89:0:b0:41a:69b1:8674 with SMTP id d9-20020a656b89000000b0041a69b18674mr1283551pgw.417.1658459439046;
        Thu, 21 Jul 2022 20:10:39 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id r2-20020aa79ec2000000b0052ba82df682sm2526347pfq.102.2022.07.21.20.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 20:10:38 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org,
	huyue2@coolpad.com,
	zhangwen@coolpad.com
Subject: [PATCH RESEND] erofs-utils: fix a memory leak of multiple devices
Date: Fri, 22 Jul 2022 11:10:08 +0800
Message-Id: <20220722031008.21819-1-huyue2@coolpad.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The memory allocated for multiple devices should be freed when to exit.
Let's add a helper to fix it since there is more than one to use it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 dump/main.c              | 7 ++++---
 fsck/main.c              | 7 ++++---
 fuse/main.c              | 5 +++--
 include/erofs/internal.h | 1 +
 lib/super.c              | 6 ++++++
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 40e850a..c9b3a8f 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -615,7 +615,7 @@ int main(int argc, char **argv)
 	err = erofs_read_superblock();
 	if (err) {
 		erofs_err("failed to read superblock");
-		goto exit_dev_close;
+		goto exit_put_super;
 	}
 
 	if (!dumpcfg.totalshow) {
@@ -630,13 +630,14 @@ int main(int argc, char **argv)
 
 	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
 		usage();
-		goto exit_dev_close;
+		goto exit_put_super;
 	}
 
 	if (dumpcfg.show_inode)
 		erofsdump_show_fileinfo(dumpcfg.show_extent);
 
-exit_dev_close:
+exit_put_super:
+	erofs_put_super();
 	dev_close();
 exit:
 	blob_closeall();
diff --git a/fsck/main.c b/fsck/main.c
index 5a2f659..a8f0e24 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -813,12 +813,12 @@ int main(int argc, char **argv)
 	err = erofs_read_superblock();
 	if (err) {
 		erofs_err("failed to read superblock");
-		goto exit_dev_close;
+		goto exit_put_super;
 	}
 
 	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
 		erofs_err("failed to verify superblock checksum");
-		goto exit_dev_close;
+		goto exit_put_super;
 	}
 
 	err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
@@ -843,7 +843,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-exit_dev_close:
+exit_put_super:
+	erofs_put_super();
 	dev_close();
 exit:
 	blob_closeall();
diff --git a/fuse/main.c b/fuse/main.c
index 95f939e..95f7abc 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -295,11 +295,12 @@ int main(int argc, char *argv[])
 	ret = erofs_read_superblock();
 	if (ret) {
 		fprintf(stderr, "failed to read erofs super block\n");
-		goto err_dev_close;
+		goto err_put_super;
 	}
 
 	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
-err_dev_close:
+err_put_super:
+	erofs_put_super();
 	blob_closeall();
 	dev_close();
 err_fuse_free_args:
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
index f486eb7..913d2fb 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -109,3 +109,9 @@ int erofs_read_superblock(void)
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

