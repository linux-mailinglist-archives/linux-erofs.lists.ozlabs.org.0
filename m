Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC30B4D9C35
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 14:28:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHvPR6Lvnz30Dp
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 00:28:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=hust.edu.cn (client-ip=202.114.0.240; helo=hust.edu.cn;
 envelope-from=dzm91@hust.edu.cn; receiver=<UNKNOWN>)
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHvPK2mPcz2yQC
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 00:28:35 +1100 (AEDT)
Received: from localhost.localdomain ([10.11.68.233])
 (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
 by mx1.hust.edu.cn  with ESMTP id 22FDSG1u003439-22FDSG1x003439
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 15 Mar 2022 21:28:20 +0800
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Subject: [PATCH] fs: erofs: add sanity check for kobject in
 erofs_unregister_sysfs
Date: Tue, 15 Mar 2022 21:28:14 +0800
Message-Id: <20220315132814.12332-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
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
Cc: linux-erofs@lists.ozlabs.org, Dongliang Mu <mudongliangabcd@gmail.com>,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Dongliang Mu <mudongliangabcd@gmail.com>

Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
is triggered by injecting fault in kobject_init_and_add of
erofs_unregister_sysfs.

Fix this by adding sanity check for kobject in erofs_unregister_sysfs

Note that I've tested the patch and the crash does not occur any more.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/erofs/sysfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dac252bc9228..f3babf1e6608 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -221,9 +221,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
+	if (sbi->s_kobj.state_in_sysfs) {
+		kobject_del(&sbi->s_kobj);
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
+	}
 }
 
 int __init erofs_init_sysfs(void)
-- 
2.25.1

