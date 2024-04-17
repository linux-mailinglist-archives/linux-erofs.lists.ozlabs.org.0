Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7533A8A7B0F
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 05:26:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713324392;
	bh=8kaLg8Q9JIbpEHXO/hXIQSAI33272QFNpBk1I/533tg=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hisu4uD4otnchQG/nrsi9aDtUXs8HnZMdEtGz/6R23d6+o4Ih6eXBxwttAH1qPAfh
	 YPnRmNZ5ASP0rvesCd1PW0HVmF+SBK4MutON6aceEwloAqotFA9+ncG9k4ntxhjK2R
	 sFJShEemoGJru3k1eKFxN+0jda+jKLW66i5ow8nucMglKMoP6oBNTu/JkEm1uOmGE4
	 AJTP+nI/57CH9K9WLV6dKlZLvMkLdrBzDNVP1PyivqmQKMFdelgdPNdM2uhcFDTda5
	 HOsI38gXky/D9lUly9FNZE/PXB/Mt0STifSCso3E4KtMNHD6gCzN3pUqaORyAG8YPE
	 x4l4gn5grQGYA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VK5t0156sz3dRp
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 13:26:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VK5sv5Kx0z3bmY
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 13:26:24 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VK5pJ759Sz1RDd9;
	Wed, 17 Apr 2024 11:23:20 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 262A91A016C;
	Wed, 17 Apr 2024 11:26:19 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 11:26:18 +0800
Message-ID: <47247f78-eafb-cb4f-495f-e91a647c3f3c@huawei.com>
Date: Wed, 17 Apr 2024 11:26:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, <xiang@kernel.org>
References: <20240415121746.1207242-1-libaokun1@huawei.com>
 <20240415-betagten-querlatte-feb727ed56c1@brauner>
 <15ab9875-5123-7bc2-bb25-fc683129ad9e@huawei.com> <Zh3NAgWvNASTZSea@debian>
 <e70a28b4-074e-c48a-b717-3e17f1aae61d@huawei.com>
 <20240416-blumig-dachgeschoss-bc683f4ef1bf@brauner> <Zh6QC0++kpUUL5nf@debian>
 <779ff32f-3f3b-c602-5da8-c88b361716ac@huawei.com> <Zh898uJW0AFtE0Rk@debian>
In-Reply-To: <Zh898uJW0AFtE0Rk@debian>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/4/17 11:11, Gao Xiang wrote:
> On Wed, Apr 17, 2024 at 10:59:53AM +0800, Baokun Li wrote:
>> On 2024/4/16 22:49, Gao Xiang wrote:
>>> On Tue, Apr 16, 2024 at 02:35:08PM +0200, Christian Brauner wrote:
>>>>>> I'm not sure how to resolve it in EROFS itself, anyway...
>>>> Instead of allocating the erofs_sb_info in fill_super() allocate it
>>>> during erofs_get_tree() and then you can ensure that you always have the
>>>> info you need available during erofs_kill_sb(). See the appended
>>>> (untested) patch.
>>> Hi Christian,
>>>
>>> Yeah, that is a good way I think.  Although sbi will be allocated
>>> unconditionally instead but that is minor.
>>>
>>> I'm on OSSNA this week, will test this patch more when returning.
>>>
>>> Hi Baokun,
>>>
>>> Could you also check this on your side?
>>>
>>> Thanks,
>>> Gao Xiang
>> Hi Xiang,
>>
>> This patch does fix the initial problem.
>>
>>
>> Hi Christian,
>>
>> Thanks for the patch, this is a good idea. Just with nits below.
>> Otherwise feel free to add.
>>
>> Reviewed-and-tested-by: Baokun Li <libaokun1@huawei.com>
>>>>   From e4f586a41748b6edc05aca36d49b7b39e55def81 Mon Sep 17 00:00:00 2001
>>>> From: Christian Brauner <brauner@kernel.org>
>>>> Date: Mon, 15 Apr 2024 20:17:46 +0800
>>>> Subject: [PATCH] erofs: reliably distinguish block based and fscache mode
>>>>
>> SNIP
>>
>>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>>> index c0eb139adb07..4ed80154edf8 100644
>>>> --- a/fs/erofs/super.c
>>>> +++ b/fs/erofs/super.c
>>>> @@ -581,7 +581,7 @@ static const struct export_operations erofs_export_ops = {
>>>>    static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>    {
>>>>    	struct inode *inode;
>>>> -	struct erofs_sb_info *sbi;
>>>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>>>    	struct erofs_fs_context *ctx = fc->fs_private;
>>>>    	int err;
>>>> @@ -590,15 +590,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>    	sb->s_maxbytes = MAX_LFS_FILESIZE;
>>>>    	sb->s_op = &erofs_sops;
>>>> -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>>>> -	if (!sbi)
>>>> -		return -ENOMEM;
>>>> -
>>>>    	sb->s_fs_info = sbi;
>> This line is no longer needed.
>>>>    	sbi->opt = ctx->opt;
>>>>    	sbi->devs = ctx->devs;
>>>>    	ctx->devs = NULL;
>>>> -	sbi->fsid = ctx->fsid;
>>>>    	ctx->fsid = NULL;
>>>>    	sbi->domain_id = ctx->domain_id;
>>>>    	ctx->domain_id = NULL;
>> Since erofs_sb_info is now allocated in erofs_fc_get_tree(), why not
>> encapsulate the above lines as erofs_ctx_to_info() helper function
>> to be called in erofs_fc_get_tree()？Then erofs_fc_fill_super() wouldn't
>> have to use erofs_fs_context and would prevent the fsid from being
>> freed twice.
> Hi Baokun,
>
> I'm not sure if Christian has enough time to polish the whole
> codebase (I'm happy if do so).  Basically, that is just a hint
> to the issue, if you have more time, I guess you could also help
> revive this patch together (also because you also have a real
> EROFS test environment).
>
> Let me also check this next week after OSSNA travelling.
>
> Thanks,
> Gao Xiang

Hi Xiang,

Ok, then I will polish the patch and send it out as a v2.

Thanks,
Baokun
