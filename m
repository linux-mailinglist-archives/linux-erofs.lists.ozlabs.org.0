Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E7874876
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 08:07:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1709795227;
	bh=o6jmMS5ftog2n0B7SrrOO+JNiryINnnA0QaOnF9uZvo=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Umo1Xd3H+c5/4i9xwx+Mofrjn2SysNmuJk0YhvRNs/NYGRtm7ihb06jQtB+mGjszH
	 Hmc3xohvPYr8epJljiGxWXYTUPOc2uArYqt373qAWt7efdm/NSefLNAXsE3SI/50cw
	 lC27an3jAEFaouGEbv1m/NoLd/lpwbR/iVqIhvxcaIJ/S1PTHJ1Tx/bm1Fx+Sk4LZv
	 aT43yrearZrUgoVxs2o4l+3tgNSkDdxgwnlAjqnPQqCSof17y9sTCQxjPXRfodyWO2
	 B9NrEMsJjuulkERGUdgmGN1S8l2Gctbi/LvaB5VneWkv2JiT5edT7KyLXO8IU9BM5+
	 SxnP15pN6kx0g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tr0jQ6vrgz3dVN
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 18:07:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tr0jH3fgMz30f5
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 18:06:56 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tr0fN5CQmz2BfJ8;
	Thu,  7 Mar 2024 15:04:28 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A7F21A0172;
	Thu,  7 Mar 2024 15:06:50 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 15:06:49 +0800
Message-ID: <7e9746db-033e-64d0-a3d5-9d341c66cec7@huawei.com>
Date: Thu, 7 Mar 2024 15:06:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <20240307050717.GB538574@ZenIV>
In-Reply-To: <20240307050717.GB538574@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2024/3/7 13:07, Al Viro wrote:
> On Thu, Mar 07, 2024 at 10:44:59AM +0800, Baokun Li wrote:
>
>> +static int erofs_anon_init_fs_context(struct fs_context *fc)
>> +{
>> +	fc->ops = &erofs_anon_context_ops;
>> +	return 0;
>> +}
>
> ITYM
>          struct pseudo_fs_context *ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
> 	return ctx ? 0 : -ENOMEM;
>
> and to hell with erofs_anon_context_ops, along with its fill_super, calls
> of simple_fill_super(), etc.  Unless I'm missing something, you are not
> even creating dentries here, let alone making them possible to look up.
Totally agree! It does streamline a lot!
>> +static void erofs_kill_pseudo_sb(struct super_block *sb)
>> +{
>> +	kill_anon_super(sb);
>> +}
> *blink*
>
> What's wrong with simply using kill_anon_super as ->kill_sb?
Sure, I'll just use kill_anon_super().
>> +int erofs_anon_register_fs(void)
>> +{
>> +	return register_filesystem(&erofs_anon_fs_type);
>> +}
> What for?  The only thing it gives you is an ability to look it up by
> name.  Which is completely pointless, IMO,
The helper function here is to avoid extern erofs_anon_fs_type(), because
we define it in fscache.c, but also use it in super.c. Moreover, we 
don't need
to register it when CONFIG_EROFS_FS_ONDEMAND is not enabled, so we
also use this helper function for code isolation.
>
>>   	if (!erofs_pseudo_mnt) {
>> -		struct vfsmount *mnt = kern_mount(&erofs_fs_type);
>> +		struct vfsmount *mnt = kern_mount(&erofs_anon_fs_type);
> ... since you are getting to it by direct reference to file_system_type
> anyway.  Same unregistering, of course...
Thanks for having a look!
-- 
With Best Regards,
Baokun Li
.
