Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D31E3544
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2020 04:11:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49WvTY2ccXzDqNk
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2020 12:11:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WvTQ50M2zDqMb
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 May 2020 12:11:35 +1000 (AEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CFCA477FE5A40D352829;
 Wed, 27 May 2020 09:55:20 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 27 May
 2020 09:55:18 +0800
Subject: Re: [PATCH] erofs: code cleanup by removing ifdef macro surrounding
To: Gao Xiang <hsiangkao@redhat.com>, cgxu <cgxu519@mykernel.net>
References: <20200526090343.22794-1-cgxu519@mykernel.net>
 <20200526094939.GB8107@hsiangkao-HP-ZHAN-66-Pro-G1>
 <4c4a7f7d-c3b7-9093-ae76-32ad258e29a6@mykernel.net>
 <20200526103522.GC8107@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <451e6933-0465-6863-7972-999bd1cdf61f@huawei.com>
Date: Wed, 27 May 2020 09:55:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200526103522.GC8107@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/5/26 18:35, Gao Xiang wrote:
> On Tue, May 26, 2020 at 06:29:00PM +0800, cgxu wrote:
>> On 5/26/20 5:49 PM, Gao Xiang wrote:
>>> Hi Chengguang,
>>>
>>> On Tue, May 26, 2020 at 05:03:43PM +0800, Chengguang Xu wrote:
>>>> Define erofs_listxattr and erofs_xattr_handlers to NULL when
>>>> CONFIG_EROFS_FS_XATTR is not enabled, then we can remove many
>>>> ugly ifdef macros in the code.
>>>>
>>>> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>>>> ---
>>>> Only compile tested.
>>>>
>>>>   fs/erofs/inode.c | 6 ------
>>>>   fs/erofs/namei.c | 2 --
>>>>   fs/erofs/super.c | 4 +---
>>>>   fs/erofs/xattr.h | 7 ++-----
>>>>   4 files changed, 3 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>>>> index 3350ab65d892..7dd4bbe9674f 100644
>>>> --- a/fs/erofs/inode.c
>>>> +++ b/fs/erofs/inode.c
>>>> @@ -311,27 +311,21 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
>>>>   const struct inode_operations erofs_generic_iops = {
>>>>   	.getattr = erofs_getattr,
>>>> -#ifdef CONFIG_EROFS_FS_XATTR
>>>>   	.listxattr = erofs_listxattr,
>>>> -#endif
>>>
>>> It seems equivalent. And it seems ext2 and f2fs behave in the same way...
>>
>> I posted similar patch for ext2 and Jack merged to
>> his tree the other day, though that series also
>> included a real bugfix. I also posted similar patch
>> to f2fs, so if erofs and f2fs merge these patches
>> then all three will behave in the same way, ;-)
>>
>> You may refer below link for the detail.
>>
>> https://lore.kernel.org/linux-ext4/20200522044035.24190-2-cgxu519@mykernel.net/
> 
> Thanks for your link...
> 
>>
>>
>>> But I'm not sure whether we'd return 0 (if I didn't see fs/xattr.c by mistake)
>>> or -EOPNOTSUPP here... Some thoughts about this? >
>>> Anyway, I'm fine with that if return 0 is okay here, but I'd like to know your
>>> and Chao's thoughts about this... I will play with it later as well.

I'm okay with this change, please feel free to add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

>>
>> Originally, we set erofs_listxattr to ->listxattr only
>> when the config macro CONFIG_EROFS_FS_XATTR is enabled,
>> it means that erofs_listxattr() never returns -EOPNOTSUPP
>> in any case, so actually there is no logic change here,
>> right?
> 
> Yeah, I agree there is no logic change, so I'm fine with the patch.
> But I'm little worry about if return 0 is actually wrong here...
> 
> see the return value at:
> http://man7.org/linux/man-pages/man2/listxattr.2.html

Yeah, I guess vfs should check that whether lower filesystem has set .listxattr
callback function to decide to return that value, something like:

static ssize_t
ecryptfs_listxattr(struct dentry *dentry, char *list, size_t size)
{
...
	if (!d_inode(lower_dentry)->i_op->listxattr) {
		rc = -EOPNOTSUPP;
		goto out;
	}
...
	rc = d_inode(lower_dentry)->i_op->listxattr(lower_dentry, list, size);
...
}


> 
> Thanks,
> Gao Xiang
> 
>>
>>
>> Thanks,
>> cgxu
>>
> 
> .
> 
