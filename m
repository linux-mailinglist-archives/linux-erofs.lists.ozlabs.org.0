Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DAE56B0CD
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 05:12:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LfJH45MVTz3c3c
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 13:12:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Mx5khUmF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=duguoweisz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Mx5khUmF;
	dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LfJGz555Tz3brl
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Jul 2022 13:12:11 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id l12so9928973plk.13
        for <linux-erofs@lists.ozlabs.org>; Thu, 07 Jul 2022 20:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61HfukmZi5fLV81u76gxjYtHKU881xwbqgyWU3fTJ3k=;
        b=Mx5khUmFWLrS93Q6gnQaBsBCFc/Jf5YRC1OcONbBzZFI+mGlhi0GIDwH7Corj/BJQC
         7xfwWXsocNZpTSEbb7BCERHYmT+sRJCcl/WtQiwrTcSOCg90Sar9d81zOJFpXfMeUrcF
         ptEJgolfYNb1SL7dAXGLdg/kMD9HsqvXuE5fQG/gc4zLycGRYwV36KCxR47T4qFW+ykL
         DgOI+vrMuzk2G8utfM9HhyJg3HZO18SWGKKY4atbCPJFOoOR8m6+rsTRAeYc+zgnCGch
         CUENG/sxtnD6HD6xSRVXS9pQ2VbVSa1a56Lent/NjgrYGnYrUOx27E0mfeqmqVUwasFf
         SwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61HfukmZi5fLV81u76gxjYtHKU881xwbqgyWU3fTJ3k=;
        b=FN0FStJi/keDsNxdydBawa2tYx06PHp7BgvVFFMC1oKznZ/DCt/MnRDD1I7NT7GTko
         7p/pO04hGAq7hRFAp7+TGqny+trA6bH8b9oZ2NZ2LIG5E9lWQMbtvthxQqjiOxaIRSbE
         64p7naFVaVNJi/VWAWgosRzJmHy15H3IgAmOQ/iqL1mlkCP7tIamY78y3dwlzCLmux7m
         0a5agP1OjTJcHQeJoGJ3bVOPhuv76DHMgrhAgPTnuY8BPh7mqaDt0IoRynYdON+OEs8n
         AF1EvW0wRwwwmqZMtt8gxzcC6EXaZ4blpGy342hRyAL94f20lb90lCeVorP5iDUceORi
         0BBg==
X-Gm-Message-State: AJIora8hi3Kh8jFifWA9t4WogbHJYh8lDPhUGr3bwsdQxMu80Al8urhC
	4zpFHYdvf8YSo5UvN8p89C8=
X-Google-Smtp-Source: AGRyM1sgI432nxE2pPqOPSB36mrwaJOma5FyZo4BCC74UgWp0ktj9m9kiuCgI0p1b+dcnX90FJIQhQ==
X-Received: by 2002:a17:903:11c6:b0:167:90e5:59ac with SMTP id q6-20020a17090311c600b0016790e559acmr1383842plh.143.1657249928448;
        Thu, 07 Jul 2022 20:12:08 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d9-20020a655889000000b0040c97f0057dsm26484443pgu.17.2022.07.07.20.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 20:12:08 -0700 (PDT)
From: Guowei Du <duguoweisz@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] erofs: sequence each shrink task
Date: Fri,  8 Jul 2022 11:11:55 +0800
Message-Id: <20220708031155.21878-1-duguoweisz@gmail.com>
X-Mailer: git-send-email 2.36.1
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
Cc: duguowei <duguowei@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: duguowei <duguowei@xiaomi.com>

Because of 'list_move_tail', if two or more tasks are shrinking, there
will be different results for them.

For example:
After the first round, if shrink_run_no of entry equals run_no of task,
task will break directly at the beginning of next round; if they are
not equal, task will continue to shrink until encounter one entry
which has the same number.

It is difficult to confirm the real results of all tasks, so add a lock
to only allow one task to shrink at the same time.

How to test:
task1:
root#echo 3 > /proc/sys/vm/drop_caches
[743071.839051] Call Trace:
[743071.839052]  <TASK>
[743071.839054]  do_shrink_slab+0x112/0x300
[743071.839058]  shrink_slab+0x211/0x2a0
[743071.839060]  drop_slab+0x72/0xe0
[743071.839061]  drop_caches_sysctl_handler+0x50/0xb0
[743071.839063]  proc_sys_call_handler+0x173/0x250
[743071.839066]  proc_sys_write+0x13/0x20
[743071.839067]  new_sync_write+0x104/0x180
[743071.839070]  ? send_command+0xe0/0x270
[743071.839073]  vfs_write+0x247/0x2a0
[743071.839074]  ksys_write+0xa7/0xe0
[743071.839075]  ? fpregs_assert_state_consistent+0x23/0x50
[743071.839078]  __x64_sys_write+0x1a/0x20
[743071.839079]  do_syscall_64+0x3a/0x80
[743071.839081]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

task2:
root#echo 3 > /proc/sys/vm/drop_caches
[743079.843214] Call Trace:
[743079.843214]  <TASK>
[743079.843215]  do_shrink_slab+0x112/0x300
[743079.843219]  shrink_slab+0x211/0x2a0
[743079.843221]  drop_slab+0x72/0xe0
[743079.843222]  drop_caches_sysctl_handler+0x50/0xb0
[743079.843224]  proc_sys_call_handler+0x173/0x250
[743079.843227]  proc_sys_write+0x13/0x20
[743079.843228]  new_sync_write+0x104/0x180
[743079.843231]  ? send_command+0xe0/0x270
[743079.843233]  vfs_write+0x247/0x2a0
[743079.843234]  ksys_write+0xa7/0xe0
[743079.843235]  ? fpregs_assert_state_consistent+0x23/0x50
[743079.843238]  __x64_sys_write+0x1a/0x20
[743079.843239]  do_syscall_64+0x3a/0x80
[743079.843241]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Signed-off-by: duguowei <duguowei@xiaomi.com>
---
 fs/erofs/utils.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index ec9a1d780dc1..9eca13a7e594 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -186,6 +186,8 @@ static unsigned int shrinker_run_no;
 
 /* protects the mounted 'erofs_sb_list' */
 static DEFINE_SPINLOCK(erofs_sb_list_lock);
+/* sequence each shrink task */
+static DEFINE_SPINLOCK(erofs_sb_shrink_lock);
 static LIST_HEAD(erofs_sb_list);
 
 void erofs_shrinker_register(struct super_block *sb)
@@ -226,13 +228,14 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	struct list_head *p;
 
 	unsigned long nr = sc->nr_to_scan;
-	unsigned int run_no;
 	unsigned long freed = 0;
 
+	spin_lock(&erofs_sb_shrink_lock);
 	spin_lock(&erofs_sb_list_lock);
-	do {
-		run_no = ++shrinker_run_no;
-	} while (run_no == 0);
+	shrinker_run_no++;
+	/* if overflow, restarting from 1 */
+	if (shrinker_run_no == 0)
+		shrinker_run_no = 1;
 
 	/* Iterate over all mounted superblocks and try to shrink them */
 	p = erofs_sb_list.next;
@@ -243,7 +246,7 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 		 * We move the ones we do to the end of the list, so we stop
 		 * when we see one we have already done.
 		 */
-		if (sbi->shrinker_run_no == run_no)
+		if (sbi->shrinker_run_no == shrinker_run_no)
 			break;
 
 		if (!mutex_trylock(&sbi->umount_mutex)) {
@@ -252,7 +255,7 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 		}
 
 		spin_unlock(&erofs_sb_list_lock);
-		sbi->shrinker_run_no = run_no;
+		sbi->shrinker_run_no = shrinker_run_no;
 
 		freed += erofs_shrink_workstation(sbi, nr - freed);
 
@@ -271,6 +274,7 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 			break;
 	}
 	spin_unlock(&erofs_sb_list_lock);
+	spin_unlock(&erofs_sb_shrink_lock);
 	return freed;
 }
 
-- 
2.36.1

