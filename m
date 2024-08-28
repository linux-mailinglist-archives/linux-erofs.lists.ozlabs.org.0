Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D5C9629AC
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 16:05:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv5ll1DQpz2yk6
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 00:05:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724853919;
	cv=none; b=gMBwXKX+iQJVSngex26LKj2Oy/jsvZ7Xvqa4dq0CY1Endsgfsm4ZMF18pFG19YANlL/Ft2EiSXQmZ4h2lieDhuZ/nDmLV3kMFDmi7gN+Rxkz+jjl6IHsmEYZlSz8DLmaDQ5g+3dSPWiPniI67xglyTno3n0mv0U7S4f06RhwvGnqzBouiu6eGOjEfsZH9J7mIdiewdFSXefj6KoehfqDHGZUcI0Anaxk5rTQV0Sn2xLfvyISyeG/rQcaVeoRx3emrkEgJzIkAEMMsV4YgwfzGnJfsE+bhipYh3qWmrcQrhM7bbQBvU4XmQS1PUvyn9dDRWw2aHrDJ7PrbTPEQb/52g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724853919; c=relaxed/relaxed;
	bh=VuQgx7zWBXfsgHAC0u2GAE+SjIfI16yNiYgnVxtfWHI=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=MqxN6EZ9Ofk9aX0nLNlhxrCtEpt2qyqDrTsu/+dJLczEwEgYL0w5m8St5QNUaRGt7R4cbBKoWnBo8SwbxWk9yrghC2o0sFLaI0ln949I+y3plIh5ptw7/lS6nLN8sifD49BSe+kd+AudAUgWCi1jCe6f3oD8sgkePmJfXCd+76g7ol0NiZQDNvFS0vvAklt5Doju0VjvzvmGgdovzVY9ePzhQFOjKmeaVy3ZattR2MuBQlcmGkHihjEzxj35OtgchT6iPUPSPJpSLm+6AqAk8qGVWdXD0T2aJkycY8e2pTWBhRavZyk7zm/zyWJ0e/09kcOPSvLQARoTpCGtt8+GGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv5lf4wPxz2yYy
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 00:05:18 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wv5lB5gF8z4f3n6m
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 22:04:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 45ECB1A07B6
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 22:05:10 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4WULs9mF7jaCw--.47393S3;
	Wed, 28 Aug 2024 22:05:10 +0800 (CST)
Message-ID: <11c591fd-221b-4eeb-a0bd-e9e303d391a6@huaweicloud.com>
Date: Wed, 28 Aug 2024 22:05:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
To: David Howells <dhowells@redhat.com>
References: <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com>
 <20240826040018.2990763-1-libaokun@huaweicloud.com>
 <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
 <988772.1724850113@warthog.procyon.org.uk>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <988772.1724850113@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXv4WULs9mF7jaCw--.47393S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw18uFyrZr4rury8CF1Dtrb_yoW5XFyDpF
	WSyr1UJry8WrWkGr4kAF1DZryFyrZFqw1UXFn8WF1DArs0qrWaqr1UXrn0gr15Jr4kJr45
	XF1Uua43ZryUJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAJBWbO338bKgABs1
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
Cc: Baokun Li <libaokun@huaweicloud.com>, Christian Brauner <brauner@kernel.org>, Yang Erkun <yangerkun@huawei.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Markus Elfring <Markus.Elfring@web.de>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, stable@kernel.org, Yu Kuai <yukuai3@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello David,

Thanks for the review.

On 2024/8/28 21:01, David Howells wrote:
> Baokun Li <libaokun@huaweicloud.com> wrote:
>
>> Actually, at first I was going to release the reference count of the
>> dentry uniformly in cachefiles_look_up_object() and delete all dput()
>> in cachefiles_open_file(),
> You couldn't do that anyway, since kernel_file_open() steals the caller's ref
> if successful.
Ignoring kernel_file_open(), we now put a reference count of the dentry
whether cachefiles_open_file() returns true or false.

And cachefiles_open_file() doesn't modify the dentry, so I'm thinking it's
releasing the reference count of the dentry that was got by
lookup_positive_unlocked() in cachefiles_look_up_object().

I'm not sure how kernel_file_open() steals the reference count,
am I missing something?


The code is as follows:

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f53977169db4..2b3f9935dbb4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -595,14 +595,12 @@ static bool cachefiles_open_file(struct 
cachefiles_object *object,
          * write and readdir but not lookup or open).
          */
         touch_atime(&file->f_path);
-       dput(dentry);
         return true;

  check_failed:
         fscache_cookie_lookup_negative(object->cookie);
         cachefiles_unmark_inode_in_use(object, file);
         fput(file);
-       dput(dentry);
         if (ret == -ESTALE)
                 return cachefiles_create_file(object);
         return false;
@@ -611,7 +609,6 @@ static bool cachefiles_open_file(struct 
cachefiles_object *object,
         fput(file);
  error:
         cachefiles_do_unmark_inode_in_use(object, d_inode(dentry));
-       dput(dentry);
         return false;
  }

@@ -654,7 +651,9 @@ bool cachefiles_look_up_object(struct 
cachefiles_object *object)
                 goto new_file;
         }

-       if (!cachefiles_open_file(object, dentry))
+       ret = cachefiles_open_file(object, dentry);
+       dput(dentry);
+       if (!ret)
                 return false;

         _leave(" = t [%lu]", file_inode(object->file)->i_ino);


Regards,
Baokun

>> but this may conflict when backporting the code to stable. So just keep it
>> simple to facilitate backporting to stable.
> Prioritise upstream, please.
>
> I think Markus's suggestion of inserting a label and switching to a goto is
> better.
>
> Thanks,
> David

