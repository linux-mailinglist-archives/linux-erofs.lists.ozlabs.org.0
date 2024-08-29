Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AFE963EB8
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 10:35:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvZNz2vRMz2yw3
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 18:35:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724920544;
	cv=none; b=Cb2fA1Ar6xtYoQ5eKXfoAMsVNxQdn/AwJftmu7/nxEFiZIL+vKQjMkeVvHimrH6uw4le+jj+GOn9pUE73oHK/eOpydySsg3Ts2ibGL7BD6wkAhH8E4fHiC+ilGW9+emxhvkU9exTOqZuJTN8wkjcVe1v1MDywtv/mWBFtQbAPubJXj1ii+6SKd2r2YBp3OJfKiSI0to4FNUHvKF5P24TfmkUAyK1u2lLUDZN4Z+N4ywTVcR04ahhe6mEvahakUvg6fWUTvUWNSrHJU4hljwFhki3800INU1f4oB5DTbO6m5KqUyrZneKMnkc43qjx46Hu5E6yqB93+8t/3hX4uO8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724920544; c=relaxed/relaxed;
	bh=vWD4whaMEMrepWx4z1YExreJGNLgKOogfuQWVKgjGfw=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=gBXxxazJ0vCK/wafeHZjln6DxB+HGidc6aR8latMes8y8MTsdJDIS7dNjMkO88/CRAfrMZbmq7rxkz5EPHf+h3hThbszUKSc1kesPko+H1i/R267I2JHks8QUN9TcDBbRrbM+9OKYcARcwSRnBafcTChC9VjvijD4C9+rv2HHv5lrTLcWrOBV49djVNBef0HgW1payiTzNH8IXGIKzfw/jB29yI5lz+1GEw7YP306RTxk6MxC3ZozPqL5oNbLkdjnb0NcRouooSziBH5pEyK5gcDRrK0R9Xb4BGbsiv/1qRA/uLiDLi3xHwbUOXdc1S7WDmjJwSk9/fMRx5eFmo4Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvZNv61Y1z2ysv
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 18:35:39 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WvZNR5J0Yz4f3kjf
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 16:35:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BB0D21A07B6
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 16:35:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4XNMtBmyzYkDA--.10163S4;
	Thu, 29 Aug 2024 16:35:27 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Subject: [PATCH v2] cachefiles: fix dentry leak in cachefiles_open_file()
Date: Thu, 29 Aug 2024 16:34:09 +0800
Message-Id: <20240829083409.3788142-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3n4XNMtBmyzYkDA--.10163S4
X-Coremail-Antispam: 1UD129KBjvJXoWxury8ZF45AFW8Zw1DCw4kJFb_yoW5ZF15pF
	ZayFyxJryrWrWkGr48AFnYqr1rA3yjqF1DX3Z5Wr1kAr1qvr1aqr17tr1Fqry5GrZ7Ar42
	qF1UCa43JryjkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbTGQDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAKBWbO339ALgABsp
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
Cc: brauner@kernel.org, yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com, libaokun@huaweicloud.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

A dentry leak may be caused when a lookup cookie and a cull are concurrent:

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

Whether cachefiles_open_file() returns true or false, the reference count
obtained by lookup_positive_unlocked() in cachefiles_look_up_object()
should be released.

Therefore release that reference count in cachefiles_look_up_object() to
fix the above issue and simplify the code.

Fixes: 1f08c925e7a3 ("cachefiles: Implement backing file wrangling")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
v1->v2:
	Use of new solution.

v1: https://lore.kernel.org/r/20240826040018.2990763-1-libaokun@huaweicloud.com

 fs/cachefiles/namei.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f53977169db4..2b3f9935dbb4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -595,14 +595,12 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	 * write and readdir but not lookup or open).
 	 */
 	touch_atime(&file->f_path);
-	dput(dentry);
 	return true;
 
 check_failed:
 	fscache_cookie_lookup_negative(object->cookie);
 	cachefiles_unmark_inode_in_use(object, file);
 	fput(file);
-	dput(dentry);
 	if (ret == -ESTALE)
 		return cachefiles_create_file(object);
 	return false;
@@ -611,7 +609,6 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	fput(file);
 error:
 	cachefiles_do_unmark_inode_in_use(object, d_inode(dentry));
-	dput(dentry);
 	return false;
 }
 
@@ -654,7 +651,9 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 		goto new_file;
 	}
 
-	if (!cachefiles_open_file(object, dentry))
+	ret = cachefiles_open_file(object, dentry);
+	dput(dentry);
+	if (!ret)
 		return false;
 
 	_leave(" = t [%lu]", file_inode(object->file)->i_ino);
-- 
2.39.2

