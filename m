Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CD38B002F
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 05:52:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPQ6z2mpFz3cDw
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 13:52:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPQ6w46Yhz3bpd
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 13:52:40 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPPmV2XvLz4f3jd8
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:36:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DD8A21A10C5
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 11:36:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ5Nfihmarc3Kw--.25590S8;
	Wed, 24 Apr 2024 11:36:49 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Subject: [PATCH 4/5] cachefiles: correct the return value of cachefiles_check_volume_xattr()
Date: Wed, 24 Apr 2024 11:27:31 +0800
Message-Id: <20240424032732.2711487-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424032732.2711487-1-libaokun@huaweicloud.com>
References: <20240424032732.2711487-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHZQ5Nfihmarc3Kw--.25590S8
X-Coremail-Antispam: 1UD129KBjvdXoWrZFyrAFW5Cw4xuw4kZF13urg_yoWkZwc_uF
	9xAF4UZrs3Gr48JrsrAa42qrWSqr1UCwn8Jr1Yva13tws8KrW5XFWDtr9xAr17Wr4DK3Wq
	kryxZF13Xr9FgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbPAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7M4kE6xkIj40Ew7xC0wCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUpVbPUUUUU==
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
Cc: libaokun@huaweicloud.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
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

