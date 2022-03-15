Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8584D95DD
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 09:02:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHm9D5RNMz30HR
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 19:02:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=hust.edu.cn (client-ip=202.114.0.240; helo=hust.edu.cn;
 envelope-from=dzm91@hust.edu.cn; receiver=<UNKNOWN>)
X-Greylist: delayed 609 seconds by postgrey-1.36 at boromir;
 Tue, 15 Mar 2022 19:02:34 AEDT
Received: from hust.edu.cn (unknown [202.114.0.240])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHm961NXfz2yn9
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 19:02:33 +1100 (AEDT)
Received: from localhost.localdomain ([172.16.0.254])
 (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
 by mx1.hust.edu.cn  with ESMTP id 22F7pr4U009621-22F7pr4X009621
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 15 Mar 2022 15:51:58 +0800
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Subject: [PATCH] fs: erofs: remember if kobject_init_and_add was done
Date: Tue, 15 Mar 2022 15:51:52 +0800
Message-Id: <20220315075152.63789-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
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
Cc: syzkaller <syzkaller@googlegroups.com>, linux-erofs@lists.ozlabs.org,
 Dongliang Mu <mudongliangabcd@gmail.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Dongliang Mu <mudongliangabcd@gmail.com>

Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
is triggered by injecting fault in kobject_init_and_add of
erofs_unregister_sysfs.

Fix this by remembering if kobject_init_and_add is successful.

Note that I've tested the patch and the crash does not occur any more.

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/erofs/internal.h | 1 +
 fs/erofs/sysfs.c    | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5aa2cf2c2f80..9e20665e3f68 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -144,6 +144,7 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 
 	/* sysfs support */
+	bool s_sysfs_inited;
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
 	struct completion s_kobj_unregister;
 };
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dac252bc9228..2b48a4df19b4 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
 				   "%s", sb->s_id);
 	if (err)
 		goto put_sb_kobj;
+	sbi->s_sysfs_inited = true;
 	return 0;
 
 put_sb_kobj:
@@ -221,9 +222,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
+	if (sbi->s_sysfs_inited) {
+		kobject_del(&sbi->s_kobj);
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
+	}
 }
 
 int __init erofs_init_sysfs(void)
-- 
2.25.1

