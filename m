Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA6A1763D
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2025 04:27:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcXhP51vMz30T2
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2025 14:27:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737430052;
	cv=none; b=RbtErQujTyKr0NANpfXorvcyC85cjpVp52XXdbwwoFp3LK2mvD1Nc/bJ8UJ0dMzZTIbEedhi3993BsbB0GOzjIdaAzz5dLLkpAnNZBx7Adf6fTOAxEfGLiaLc4dlwRs+MVm//Tz3HjeSALGu3YZXeUn75LQ3jvvJi2WiQgtVddKOGisII2Pl5rBkew/TaDzrSsmLWSgCUqKENb96yUBoeN4jrbDAVHjvV3z7stMcPCgi1jtX4FqhpWGnPKIBy82mgIWU2ZAvYrFtnsQW31iLmCSZq56Bnbi/VrjMAQyArVE0n7WIOKrbEUTV7GUijqkzjTybjObRmE0MywLvJsI0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737430052; c=relaxed/relaxed;
	bh=hB2vfeJ/qibd6RDbSZFlQ1R2F/ZDIYQy6bzau95f+uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SdRPheXMHhMgNm8QtTWb1iVKq0mSNpGYEN1hrm/Z/4QMuHhjUzpg/XSDhOcC4+nU6xuqC9d6ZkLJXa5ZnQGR3oxai9MKQDQ5YW94h98Jq+1DFSJSNCyI9NX1mpk7RlybT6Vvdy+A9Mhg6KwnyEbXGa38eZUAFFJYpyG42zZMyM3IHuk3vMqil/js+EZ+0oIkzh9sfbPvQ4CWqpBXPiL28bVtLRAnwGhSCLJeMXUa7DP2Wovi11ek4A83Oyv+/mvhhn0aO8Q04Gf2YAyFgf86jRZyR290rfKZfL6otQoh19SaGayw0eBkuvkBptlRUmtnjqEZhVrNZw6hZ41tpeNQ+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b/9+0TrK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b/9+0TrK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YcXhL4nMjz2ytQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Jan 2025 14:27:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737430044; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hB2vfeJ/qibd6RDbSZFlQ1R2F/ZDIYQy6bzau95f+uM=;
	b=b/9+0TrKj1PqYukMua99PgM6jQgM9V7aS8nv7cKO6b21PBy0nmZbCsFTTfabJI1m2WCuH9A1hDKgei4k1wAwqqc6a1QPpA77UhcvSnv+ZYOxmCZ+emzBxXvA8wqmaiuZI5OwswCL8I1L2LHs8uuVzIrnzKu9SYbW57wpUWAf6nA=
Received: from 30.221.129.227(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WO3lava_1737430042 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Jan 2025 11:27:23 +0800
Message-ID: <1e6554d0-5b46-47c0-a9e1-8c26dafa29b3@linux.alibaba.com>
Date: Tue, 21 Jan 2025 11:27:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] data corruption of init process
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>, linux-erofs@lists.ozlabs.org
References: <c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de>
 <14b78097-ee6a-4e91-9688-172ce807299b@linux.alibaba.com>
 <1ee54399-88ef-440e-9262-cba0bcc28c90@pengutronix.de>
 <b73823e2-a976-4831-90c7-405316440236@linux.alibaba.com>
 <109605af-8df5-49dc-be5e-81ec907bfcbf@linux.alibaba.com>
 <8d18ce00-404c-42a7-9fed-5673a71eac3e@pengutronix.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <8d18ce00-404c-42a7-9fed-5673a71eac3e@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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



On 2025/1/21 01:36, Stefan Kerkmann wrote:
> Hi Gao,
> 
> I have enabled KASAN and applied your requested changes, but nothing suspicious happened.

Sigh...

> 
>> - Could we get the exact file offset of `init` which init process is
>>    crashed?  It will help us to chase down the the primary scene.
> 
> I'll try to track that down. If you have any hints how to-do that let me know :-).

Many thanks for the test...
I just hacked some code but un-tested as below:

diff --git a/kernel/exit.c b/kernel/exit.c
index 1dcddfe537ee..868fea16732f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -873,6 +873,8 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
  	spin_unlock_irq(&sighand->siglock);
  }

+extern struct inode *erofs_iget(struct super_block *sb, u64 nid);
+
  void __noreturn do_exit(long code)
  {
  	struct task_struct *tsk = current;
@@ -903,9 +905,59 @@ void __noreturn do_exit(long code)
  		 * If the last thread of global init has exited, panic
  		 * immediately to get a useable coredump.
  		 */
-		if (unlikely(is_global_init(tsk)))
+		if (unlikely(is_global_init(tsk))) {
+			struct path path;
+			struct inode *inode;
+
+			get_fs_pwd(tsk->fs, &path);
+
+			inode = d_inode(path.dentry);
+			if (inode && inode->i_sb->s_magic == EROFS_SUPER_MAGIC_V1) {
+				struct inode *inode;
+				int i = 0;
+
+				inode = erofs_iget(inode->i_sb, 190291);
+				if (IS_ERR(inode))
+					goto skip;
+
+				for (i = 0; i < 30; ++i) {
+					struct page *page = find_get_page(inode->i_mapping, i);
+					void *data;
+
+					if (!page)
+						continue;
+					data = kmap_local_page(page);
+
+					hash = fnv_32_buf(data, PAGE_SIZE, FNV1_32_INIT);
+					pr_err("%px i_ino %lu, index %lu dst %px (%x) err %d",
+					       page, page->mapping->host->i_ino, i, ptr, hash);
+					kunmap_local(data);
+				}
+				iput(inode);
+
+				inode = erofs_iget(inode->i_sb, 868416);
+				if (IS_ERR(inode))
+					goto skip;
+
+				for (i = 0; i < 19; ++i) {
+					struct page *page = find_get_page(inode->i_mapping, i);
+					void *data;
+
+					if (!page)
+						continue;
+					data = kmap_local_page(page);
+					hash = fnv_32_buf(data, PAGE_SIZE, FNV1_32_INIT);
+					pr_err("%px i_ino %lu, index %lu dst %px (%x) err %d",
+					       page, page->mapping->host->i_ino, i, ptr, hash);
+					kunmap_local(data);
+				}
+				iput(inode);
+			}
+skip:
  			panic("Attempted to kill init! exitcode=0x%08x\n",
  				tsk->signal->group_exit_code ?: (int)code);
+		}
+

  #ifdef CONFIG_POSIX_TIMERS
  		hrtimer_cancel(&tsk->signal->real_timer);

You could follow the idea to dump the page cache data when init
is killed, I wonder the output...


Thanks,
Gao Xiang
