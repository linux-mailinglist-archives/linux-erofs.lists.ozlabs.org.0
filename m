Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB2E95E79D
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Aug 2024 06:23:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WscxG6RqBz2yFQ
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Aug 2024 14:23:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724646208;
	cv=none; b=PlFbOkfGAwahuaPWzOOHFQRGR4b8QFuzwHsys+CSrdJ5hWwMYICTc7Y4GgzJNyKQ0JYEOTQ+Mxq8BLY0XhUvPJSKf4ugyMEcrEtlUfs828NRA0HkVkRj16W1xtWK7SfLrLmRPTMeVgqIn7Mxh/jdMWoA9LY1CjfCv/DRlZG/tRxpJvfR8hHjFEazV6PvypMOzhYkoE8kU1Ma6IZenA1u4ceJ932Xb7WxsyIIm7QtGlr8tf6/+wCGOH/DcA/9ZA1F7FNiIBmAHQgEpXdRxeNEhHAaQOp4DUufv2/rzWlSzxQejCg1FkZ46Xkg5GycRecvhIkt3F0iKI9qBDufb0OAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724646208; c=relaxed/relaxed;
	bh=/wQSp5p7t9OxagKxhIsJxo0K6R+6pXflHv68FgdMVBw=;
	h=X-Greylist:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo; b=lDh1s2GkiNU3E+fXvEaS9bziiCnWiCZz30tGddIfzZC97Nrus+rpa0Uw3hnLo9rgZx9gqYTMz9u862ofS3ODNrNeD9q1+K3YPyMxz5G7KBBxFiLg9CEUezopKw9k9mp13SLQO7ED85BspYtqpmW0OVWvF5aFTtBfK0QSUWr9lICMC5cz0DYpBCKGNdMHXUJHaHRlZeZwqBGNl0TIGhXBjEAs2IGpwbK8TnxGLaB2TQk7DioRnDnR75Ve+Ps4l3eiOmiKMTcoES+9OI3RZ6nNFtdYpALHdmvyfqsbgthDhmMXZHJjA4RlMFQ2M6yE0EUuIOj1yPxZBb0Y1y2sWxl+gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1076 seconds by postgrey-1.37 at boromir; Mon, 26 Aug 2024 14:23:24 AEST
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wscx82nvnz2xKh
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Aug 2024 14:23:21 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WscWz1CV1z4f3jMx
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Aug 2024 12:05:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9A9AA1A018D
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Aug 2024 12:05:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4X7_stmGK71Cg--.11259S4;
	Mon, 26 Aug 2024 12:05:17 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
Date: Mon, 26 Aug 2024 12:00:18 +0800
Message-Id: <20240826040018.2990763-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHr4X7_stmGK71Cg--.11259S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry7Cw1xCr4rWr43Gw1UAwb_yoW8uw4fpF
	ZIyryxGryrury8Gr48JF1rtr1rJ347JF4qqw1kXr18Ar1DZr1rXr17tr1FqryUGrWUZr42
	qF1UK343Jr1jk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYpnQUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAHBWbK6v869gAAs2
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, stable@kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com, libaokun@huaweicloud.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

In ondemand mode, dentry leaks may be caused when the mount has the
following concurrency with cull:

            P1             |             P2
-----------------------------------------------------------
cachefiles_lookup_cookie
  cachefiles_look_up_object
    lookup_one_positive_unlocked
     // get dentry
                            cachefiles_cull
                              inode->i_flags |= S_KERNEL_FILE;
    cachefiles_open_file
      cachefiles_mark_inode_in_use
        __cachefiles_mark_inode_in_use
          can_use = false
          if (!(inode->i_flags & S_KERNEL_FILE))
            can_use = true
	  return false
        return false
        // Returns an error but doesn't put dentry

After that the following WARNING will be triggered when the backend folder
is umounted:

==================================================================
BUG: Dentry 000000008ad87947{i=7a,n=Dx_1_1.img}  still in use (1) [unmount of ext4 sda]
WARNING: CPU: 4 PID: 359261 at fs/dcache.c:1767 umount_check+0x5d/0x70
CPU: 4 PID: 359261 Comm: umount Not tainted 6.6.0-dirty #25
RIP: 0010:umount_check+0x5d/0x70
Call Trace:
 <TASK>
 d_walk+0xda/0x2b0
 do_one_tree+0x20/0x40
 shrink_dcache_for_umount+0x2c/0x90
 generic_shutdown_super+0x20/0x160
 kill_block_super+0x1a/0x40
 ext4_kill_sb+0x22/0x40
 deactivate_locked_super+0x35/0x80
 cleanup_mnt+0x104/0x160
==================================================================

Add the missing dput() to cachefiles_open_file() for a quick fix.

Fixes: 1f08c925e7a3 ("cachefiles: Implement backing file wrangling")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f53977169db4..0bd2f367c3ff 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -554,6 +554,7 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	if (!cachefiles_mark_inode_in_use(object, d_inode(dentry))) {
 		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
 			  dentry, d_inode(dentry)->i_ino);
+		dput(dentry);
 		return false;
 	}
 
-- 
2.39.2

