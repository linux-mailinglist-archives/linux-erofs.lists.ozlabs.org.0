Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ADA9626A0
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 14:13:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv3G24kbFz2yj3
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 22:12:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724847176;
	cv=none; b=XX6TfsrxyE1UmtQn0wN+jmLtnbKiAikA48betaByNeH+mtdnkNPReEOMp6h9h9WsQANJ0ldZDRaCPWlWsY88rgsHnUV9Geeydq1/goEn1xNYUs/oVcsrgsaU5Ett8qO4+v19UeWyxOt8JJ9IVGr98jd81NjPqP2A6whctIKjQ3ok2zpnnFyR/jWnN86VjFnT4fyS6XhrcR3umTqauNNqp1BY4I+/yVTGIjqPcO73edHBbd/dQX0nOFgnJXXsLdR0qD8mc7F96Wp2KcAv/2oUQC7WDaFLcUUHT62hjOfEHGWqsqyRBhkPZnKQ8XqfV/+p5fHy2mZ2JoU7FPUph747eA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724847176; c=relaxed/relaxed;
	bh=Yy/8o7EAwDdVAuBYYecMQiTuPWHk5mSP3winHB3UasY=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=Wds1oSzxjhzL8UFcAT4FevibC0pExb3wOMdLTiWspxNz4jxU6oijAXSwfs+yWmjvVtcQdZPrSBsZ5QkiB01p07QGYX2I+1HDjVmKBlotVRJkNpTea6JeumPVAmHdj5QEsUNev9U24EIAMWHvW8yLA0wwCZha1aun0aqoqw8JeeiPNe1FRL3ub05La80V00PpxMywwm5lFacK5P2u0xoPNEKHIBkRQgTWsM+czpvd0YpHSluQuzz7fJa92emXz7jjNE7mSl4kcWYqHc1b24oYqCDQdSZwYhKSbz3S8dhgAA/9U2nIShaYo3bE8cRE6JoDWxaLCBpHeJzHnb5RHnv2bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv3FB0RKxz2xs1
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 22:12:12 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wv3DG3Ybdz4f3nT6
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 20:11:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F04641A16E8
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 20:11:41 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4X7E89mFlHTCw--.41618S3;
	Wed, 28 Aug 2024 20:11:41 +0800 (CST)
Message-ID: <89b6b6ae-f805-43be-86ca-d3fb06ad8fec@huaweicloud.com>
Date: Wed, 28 Aug 2024 20:11:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module
 exits
To: David Howells <dhowells@redhat.com>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
 <952423.1724841455@warthog.procyon.org.uk>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <952423.1724841455@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgCHr4X7E89mFlHTCw--.41618S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry7Kw4xZr1xGFykXFy5Jwb_yoW8Ww4rpa
	4ku34xCr18WryUJF4fJw1jvr4UZF4UGF1UJ3s7Gr1UJ3W7Aw18X3WF9F45AF9FkF1UAF45
	t3WUtr1vyr1UZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUOv38UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWbO4BkSYgABsu
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
Cc: brauner@kernel.org, yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com, Baokun Li <libaokun@huaweicloud.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On 2024/8/28 18:37, David Howells wrote:
> libaokun@huaweicloud.com wrote:
>
>> In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs',
>> but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
>> deleting its subtree. This triggers the following WARNING:
>>
>> ==================================================================
>> remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at least 'requests'
>> WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x160/0x1c0
>> Modules linked in: netfs(-)
>> CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
>> RIP: 0010:remove_proc_entry+0x160/0x1c0
>> Call Trace:
>>   <TASK>
>>   netfs_exit+0x12/0x620 [netfs]
>>   __do_sys_delete_module.isra.0+0x14c/0x2e0
>>   do_syscall_64+0x4b/0x110
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> ==================================================================
>>
>> Therefore use remove_proc_subtree instead() of remove_proc_entry() to
>> fix the above problem.
>>
>> Fixes: 7eb5b3e3a0a5 ("netfs, fscache: Move /proc/fs/fscache to /proc/fs/netfs and put in a symlink")
>> Cc: stable@kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Should remove_proc_entry() just remove the entire subtree anyway?
Yeah, in general, when we remove a proc entry, we don't care if it has
subtrees. But I'm not sure if there are certain scenarios where entries
must be removed in a certain order .
>
> But you can add:
>
> 	Acked-by: David Howells <dhowells@redhat.com>
>
> David

Thanks for your ack!

-- 
With Best Regards,
Baokun Li

