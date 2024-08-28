Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DFB9626A8
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 14:14:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv3HR0YS9z2yjR
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 22:14:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724847249;
	cv=none; b=dz01WjP/HLEbFo+bBaOkSrl1PmGkQMSpwcGd1MK3/lfXMdgAPLNMm6UQHJFGgwtu8kV2pvaPVYneRWL8hZ46bXZevDoHodghkNSLlz88da71FGuXTDLyi79Nz31PApVFdoaJZOSQlu50Kbi79/7W/SX9hp22N33Q88tNcRISBuqJZGemi5VhLNfv8Gi7i/iMYSTPbaw0C7hrWpANr1dQuSgMjBUR7dxelqQWpdtt4wMGjLsaiFJmam95IAj9cr0vXVueuOWW/7ipuWBeiJtohJ3iPxbzN5Lxe4ZAaJLdyX9AVDs+ioR+6euPyU1Ar2+ZmWH9lpFn1bAB9fpQhKsmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724847249; c=relaxed/relaxed;
	bh=JU6T9jjihbHqbRsgNPD923BxFYnJa34UiPZkrM5YCOk=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=amcT4aViXcAhrJ6VDhFI7bCILVj2n3z3FPJOGHLQB3RWD3AoIeY+Ztdx5jR3u6tR9a+mei5syTWnjKWUbEAj94L6ScOpFzyDYD8Rkph54K3gqYe4PyokYhOmT3z5KJspDqVw/hG7DMLVm9SzDYS/nM6kYLtX2a2csWn6FqLA71ng6Bcauni7Y+PjQmm9QWspGXI4a19nW2gAiI6e7YFpzgyS1MNfIu50gmh1y5OflRnfX5U7wdu//eJdd+LgAkpHHf4Zuavs/8NLokkrycBZ4KJBE9ia9BnYjyKn50OPUCt8DA5ASwhVGMODjmZ0Ssp5yqPm8PTb+f+GwQmTbpKlXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv3HK6LbWz2xs1
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 22:14:05 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wv3Gt2RsHz4f3jXy
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 20:13:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E70B41A018D
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 20:13:56 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4WCFM9mYnbTCw--.37858S3;
	Wed, 28 Aug 2024 20:13:55 +0800 (CST)
Message-ID: <b003bb7c-7af0-484f-a6d9-da15b09e3a96@huaweicloud.com>
Date: Wed, 28 Aug 2024 20:13:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module
 exits
To: Christian Brauner <brauner@kernel.org>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
 <20240828-fuhren-platzen-fc6210881103@brauner>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240828-fuhren-platzen-fc6210881103@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAHL4WCFM9mYnbTCw--.37858S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urWDGry8JFW7Zw1rGFykXwb_yoW8uF1rpa
	4kZ34fGr1DJryUJa1ftw4jqF4UZrs8JF13Kr1xGr18Z3WYyr1ktF109FW5uF9FkryFkw4j
	q3WUt3sYkr1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUFjjgDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWbO4BkSpQAAso
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
Cc: Baokun Li <libaokun@huaweicloud.com>, yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/8/28 19:22, Christian Brauner wrote:
> On Mon, 26 Aug 2024 19:34:04 +0800, libaokun@huaweicloud.com wrote:
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

Hi Christian,


Thank you for applying this patch!

I just realized that the parentheses are in the wrong place here,
could you please help me correct them?
>> Therefore use remove_proc_subtree instead() of remove_proc_entry() to
^^ remove_proc_subtree() instead

Regards, Baokun

> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>
> [1/1] netfs: Delete subtree of 'fs/netfs' when netfs module exits
>        https://git.kernel.org/vfs/vfs/c/0aef59b3eabb

