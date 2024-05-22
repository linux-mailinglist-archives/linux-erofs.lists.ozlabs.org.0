Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id D3E8F8CBA3D
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 06:11:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vkd5r75mwz3vZJ
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 14:06:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vkd5T2z8Tz3g69
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 14:06:02 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkd5836Rmz4f3lg6
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 12:05:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E18E01A06DE
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 12:05:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ4ib01ms1VYNQ--.24441S8;
	Wed, 22 May 2024 12:05:58 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH RESEND 4/5] cachefiles: correct the return value of cachefiles_check_volume_xattr()
Date: Wed, 22 May 2024 19:59:10 +0800
Message-Id: <20240522115911.2403021-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522115911.2403021-1-libaokun@huaweicloud.com>
References: <20240522115911.2403021-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHZQ4ib01ms1VYNQ--.24441S8
X-Coremail-Antispam: 1UD129KBjvdXoWrZFyrAFW5Cw4xuw4kZF13urg_yoWkZwc_uF
	9xAF4UZrs3Gr48JrsrAa42qrWSqr1UCwn8Jr1Yva13tws8KrW5XFWDtr9xAr17Wr4DK3Wq
	kryxZF13Xr9FgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbmkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
	A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
	M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2I
	x0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sREMKZDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/
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
Cc: libaokun@huaweicloud.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

In cachefiles_check_volume_xattr(), the error returned by vfs_getxattr is
not passed to ret, so it ends up returning -ESTALE, which leads to an
endless loop as follows:

cachefiles_acquire_volume
retry:
  cachefiles_check_volume_xattr
  // return -ESTALE
  cachefiles_bury_object
  //  EIO causes rename failure
  goto retry;

So pass the error code to ret when xlen < 0 to avoid the above problem.

Fixes: 32e150037dce ("fscache, cachefiles: Store the volume coherency data")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index bcb6173943ee..20e4a4391090 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -252,6 +252,7 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, len);
 	if (xlen != len) {
 		if (xlen < 0) {
+			ret = xlen;
 			trace_cachefiles_vfs_error(NULL, d_inode(dentry), xlen,
 						   cachefiles_trace_getxattr_error);
 			if (xlen == -EIO)
-- 
2.39.2

