Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 15266874A61
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 10:08:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1709802520;
	bh=NzYUxrkDYLYIk+Whz/nhovSA9OS9dsMHAJHShcPyP3Y=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VWZYp2FROeFrzYNW+ll1ObUMw8Z+bpPeUMjXtOkVTg6uet3/BptWb/l5O8pp+8kvd
	 73Z0JgsvOLDad+FJUH+aR/sEybcAbSNBugJsH5Y1sj+7zUdiMKADdiXIayooH//BSY
	 C1nPkx/QQN7KO2gYJvDstfH2oqLjUqpb7zWAlZQqgzxvIgiB/+J3EFQ5fIMo0toGmj
	 NCNsuqfZUc52Z/rZ5NNypYXxcMjG81khptUWSiUWQDcCYKpSqNY3TPLe+WIOTGO+Fm
	 k7zAIMRBxdmzY+/fwjW3Q7+tBua6ge94ATsC6IQQ70R/OjyF8uGWrxA8RmR21vECXZ
	 /pzLANr/MkKvg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tr3Ph5fmbz3dXT
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 20:08:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tr3Pb4n4Qz3cF4
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 20:08:35 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Tr3Ls2yX2zXhsC;
	Thu,  7 Mar 2024 17:06:13 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F4981400DD;
	Thu,  7 Mar 2024 17:08:30 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 17:08:29 +0800
Message-ID: <84a79c06-692a-25b8-b95c-21e565eced19@huawei.com>
Date: Thu, 7 Mar 2024 17:08:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <20240307050717.GB538574@ZenIV>
 <7e9746db-033e-64d0-a3d5-9d341c66cec7@huawei.com>
 <20240307072112.GC538574@ZenIV> <20240307084608.GD538574@ZenIV>
In-Reply-To: <20240307084608.GD538574@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
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
From: Baokun Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Baokun Li <libaokun1@huawei.com>
Cc: chengzhihao1@huawei.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/3/7 16:46, Al Viro wrote:
> On Thu, Mar 07, 2024 at 07:21:12AM +0000, Al Viro wrote:
>> On Thu, Mar 07, 2024 at 03:06:49PM +0800, Baokun Li wrote:
>>>>> +int erofs_anon_register_fs(void)
>>>>> +{
>>>>> +	return register_filesystem(&erofs_anon_fs_type);
>>>>> +}
>>>> What for?  The only thing it gives you is an ability to look it up by
>>>> name.  Which is completely pointless, IMO,
>>> The helper function here is to avoid extern erofs_anon_fs_type(), because
>>> we define it in fscache.c, but also use it in super.c. Moreover, we don't
>>> need
>>> to register it when CONFIG_EROFS_FS_ONDEMAND is not enabled, so we
>> You don't need to register it at all.
>>
>> The one and only effect of register_filesystem() is making file_system_type
>> instance visible to get_fs_type() (and making it show up in /proc/filesystems).
>>
>> That's it.  If you want to have it looked up by name (e.g. for userland
>> mounts), you need to register.  If not, you do not need to do that.
>>
>> Note that kern_mount() take a pointer to struct file_system_type,
>> not its (string) name.  So all you get from registration is an extra line
>> in /proc/filesystems.  What's the point?
> PS: at one point I considered renaming it to something that would sound
> less vague, but the best variant I'd been able to come up with was
> "publish_filesystem()", which is not much better and has an extra problem -
> how do you describe the reverse of that?  "withdraw_filesystem()"?
> Decided that it wasn't worth the amount of noise and headache...
I feel the emphasis on "fs_name" rather than "filesystem" is less
likely to be misunderstood. What do you think about renaming
to add_fs_name/remove_fs_name?

-- 
With Best Regards,
Baokun Li
.
