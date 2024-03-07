Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399B8748F5
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 08:44:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1709797464;
	bh=Sozi5j/4xKm6chbXSJ4acWxVe6lWx+If+vi/FDm97/Y=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DaCWsUuqzXuiG4IemwNuAAygrT9QmO9yNWWwMZAfTmoBwXJ9ZbvLdm/G3T7Sb8KtJ
	 dwTj+fFW4redFR5tYevjF+tdYSLswi9cVFogfgDmuuPRu4+xUb8zMzc5NjROf2uSiN
	 mSZsIhpMxW1tGT0JBkV0Et0E+I8Y4rSKO1+1+eFZRJQRkNkvVCfcvV76arseHqvWMr
	 4c8uue0qNDdqZ14BqwgwBMhZ7o70l/CRDGsAim9LJn4Ugihrz4CQqCpabKMTixagoI
	 lmEFVavcS3HdUVtVbDEy8WvR4CiKO/AYgzepkJH+5hayrUpTj89N9TXr2+tA70xOfA
	 hk/BgbXy8E3AQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tr1XS0t7zz3dWw
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 18:44:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tr1XN4Skkz3cS3
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 18:44:20 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tr1T261TgzwPHK;
	Thu,  7 Mar 2024 15:41:26 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EC5D140410;
	Thu,  7 Mar 2024 15:43:45 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 15:43:44 +0800
Message-ID: <bca29c1a-6a4d-e128-b9b5-5c48020d4850@huawei.com>
Date: Thu, 7 Mar 2024 15:43:44 +0800
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
 <20240307072112.GC538574@ZenIV>
In-Reply-To: <20240307072112.GC538574@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2024/3/7 15:21, Al Viro wrote:
> On Thu, Mar 07, 2024 at 03:06:49PM +0800, Baokun Li wrote:
>>>> +int erofs_anon_register_fs(void)
>>>> +{
>>>> +	return register_filesystem(&erofs_anon_fs_type);
>>>> +}
>>> What for?  The only thing it gives you is an ability to look it up by
>>> name.  Which is completely pointless, IMO,
>> The helper function here is to avoid extern erofs_anon_fs_type(), because
>> we define it in fscache.c, but also use it in super.c. Moreover, we don't
>> need
>> to register it when CONFIG_EROFS_FS_ONDEMAND is not enabled, so we
> You don't need to register it at all.
>
> The one and only effect of register_filesystem() is making file_system_type
> instance visible to get_fs_type() (and making it show up in /proc/filesystems).
>
> That's it.  If you want to have it looked up by name (e.g. for userland
> mounts), you need to register.  If not, you do not need to do that.
>
> Note that kern_mount() take a pointer to struct file_system_type,
> not its (string) name.  So all you get from registration is an extra line
> in /proc/filesystems.  What's the point?
It's dawning on me, thank you so much for explaining! ღ( ´･ᴗ･` )

-- 
With Best Regards,
Baokun Li
.
