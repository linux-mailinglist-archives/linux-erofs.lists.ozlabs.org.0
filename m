Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE838A9195
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 05:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713411430;
	bh=I/Dmz2Z7h1LidZoo+c6HaUOLOU7Tpy9NkWJI2oEkHLs=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=X08Bw+8pF4BHnwd3haClk2xYNLqSox66T7sTQXac2eMcYsxjgHMO9k8ER4641W/fk
	 QmS17Zft209v2bafxxBc98R9tHaKu4u89nO5EtzpQCC/ToMAIGFKzOn+EcuPAnTGXo
	 Vvm7zPbUjbBhZ0NI8Oo4swD5jtF18YZRJCsHT7+//X1Eum3Jt/5RtNedRTYd4UkguC
	 BKRyRta1ljU1E73429fOqlVsIIYtZsojbGp6zqzrDb73yxoaZQ7GcCw/D3rIj8OZTf
	 kW4GEG9CNeg91b5cRSAkdKMRQ3/NMDlJh8Pqyp/345w+jeLXGqwDO7vt50EpbUVb2W
	 WDwgwM9AEZxuQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKk3p56tDz3cQH
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 13:37:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKk3f6553z3bs0
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 13:36:59 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VKjzN4YW0zwSfx;
	Thu, 18 Apr 2024 11:33:20 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 820671800C5;
	Thu, 18 Apr 2024 11:36:24 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 11:36:23 +0800
Message-ID: <7fdf4bff-2d3d-bdc0-5446-caa58aeca314@huawei.com>
Date: Thu, 18 Apr 2024 11:36:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] erofs: reliably distinguish block based and fscache
 mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>
References: <20240417065513.3409744-1-libaokun1@huawei.com>
 <71e66b02-9c2b-4981-83e1-8af72d6c0975@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <71e66b02-9c2b-4981-83e1-8af72d6c0975@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/4/18 10:16, Jingbo Xu wrote:
> Hi Baokun,
>
> Thanks for catching this and move forward fixing this!

Hi Jingbo，

Thanks for your review！

>
> On 4/17/24 2:55 PM, Baokun Li wrote:
>> When erofs_kill_sb() is called in block dev based mode, s_bdev may not have
>> been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it will
>> be mistaken for fscache mode, and then attempt to free an anon_dev that has
>> never been allocated, triggering the following warning:
>>
>> ============================================
>> ida_free called for id=0 which is not allocated.
>> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
>> Modules linked in:
>> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
>> RIP: 0010:ida_free+0x134/0x140
>> Call Trace:
>>   <TASK>
>>   erofs_kill_sb+0x81/0x90
>>   deactivate_locked_super+0x35/0x80
>>   get_tree_bdev+0x136/0x1e0
>>   vfs_get_tree+0x2c/0xf0
>>   do_new_mount+0x190/0x2f0
>>   [...]
>> ============================================
>>
>> Instead of allocating the erofs_sb_info in fill_super() allocate it
>> during erofs_get_tree() and ensure that erofs can always have the info
>> available during erofs_kill_sb().
>
> I'm not sure if allocating erofs_sb_info in erofs_init_fs_context() will
> be better, as I see some filesystems (e.g. autofs) do this way.  Maybe
> another potential advantage of doing this way is that erofs_fs_context
> is not needed anymore and we can use sbi directly.
Yes, except for some extra memory usage when remounting,
this idea sounds great. Let me send a version of v3 to get rid
of erofs_fs_context.
>
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>> Changes since v1:
>>    Allocate and initialise fc->s_fs_info in erofs_fc_get_tree() instead of
>>    modifying fc->sb_flags.
>>
>> V1: https://lore.kernel.org/r/20240415121746.1207242-1-libaokun1@huawei.com/
>>
>>   fs/erofs/super.c | 51 ++++++++++++++++++++++++++----------------------
>>   1 file changed, 28 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index b21bd8f78dc1..4104280be2ea 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -581,8 +581,7 @@ static const struct export_operations erofs_export_ops = {
>>   static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   {
>>   	struct inode *inode;
>> -	struct erofs_sb_info *sbi;
>> -	struct erofs_fs_context *ctx = fc->fs_private;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   	int err;
>>   
>>   	sb->s_magic = EROFS_SUPER_MAGIC;
>> @@ -590,19 +589,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	sb->s_maxbytes = MAX_LFS_FILESIZE;
>>   	sb->s_op = &erofs_sops;
>>   
>> -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>> -	if (!sbi)
>> -		return -ENOMEM;
>> -
>> -	sb->s_fs_info = sbi;
>> -	sbi->opt = ctx->opt;
>> -	sbi->devs = ctx->devs;
>> -	ctx->devs = NULL;
>> -	sbi->fsid = ctx->fsid;
>> -	ctx->fsid = NULL;
>> -	sbi->domain_id = ctx->domain_id;
>> -	ctx->domain_id = NULL;
>> -
>>   	sbi->blkszbits = PAGE_SHIFT;
>>   	if (erofs_is_fscache_mode(sb)) {
>>   		sb->s_blocksize = PAGE_SIZE;
>> @@ -704,11 +690,32 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	return 0;
>>   }
>>   
>> -static int erofs_fc_get_tree(struct fs_context *fc)
>> +static void erofs_ctx_to_info(struct fs_context *fc)
>>   {
>>   	struct erofs_fs_context *ctx = fc->fs_private;
>> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>> +
>> +	sbi->opt = ctx->opt;
>> +	sbi->devs = ctx->devs;
>> +	ctx->devs = NULL;
>> +	sbi->fsid = ctx->fsid;
>> +	ctx->fsid = NULL;
>> +	sbi->domain_id = ctx->domain_id;
>> +	ctx->domain_id = NULL;
>> +}
> I'm not sure if abstracting this logic into a seperate helper really
> helps understanding the code as the logic itself is quite simple and
> easy to be understood. Usually it's a hint of over-abstraction when a
> simple helper has only one caller.
>
Static functions that have only one caller are compiled inline, so we
don't have to worry about how that affects the code.

The reason these codes are encapsulated in a separate function is so
that the code reader understands that these codes are integrated
as a whole, and that we shouldn't have to move one or two of these
lines individually.

But after we get rid of erofs_fs_context, those won't be needed
anymore.
>>   
>> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
>> +static int erofs_fc_get_tree(struct fs_context *fc)
>> +{
>> +	struct erofs_sb_info *sbi;
>> +
>> +	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>> +	if (!sbi)
>> +		return -ENOMEM;
>> +
>> +	fc->s_fs_info = sbi;
>> +	erofs_ctx_to_info(fc);
>> +
>> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>>   		return get_tree_nodev(fc, erofs_fc_fill_super);
>>   
>>   	return get_tree_bdev(fc, erofs_fc_fill_super);
>> @@ -767,6 +774,7 @@ static void erofs_fc_free(struct fs_context *fc)
>>   	kfree(ctx->fsid);
>>   	kfree(ctx->domain_id);
>>   	kfree(ctx);
>> +	kfree(fc->s_fs_info);
>>   }
>>   
>>   static const struct fs_context_operations erofs_context_ops = {
>> @@ -783,6 +791,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
>>   	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>>   	if (!ctx)
>>   		return -ENOMEM;
>> +
>>   	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
>>   	if (!ctx->devs) {
>>   		kfree(ctx);
>> @@ -799,17 +808,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
>>   
>>   static void erofs_kill_sb(struct super_block *sb)
>>   {
>> -	struct erofs_sb_info *sbi;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   
>> -	if (erofs_is_fscache_mode(sb))
>> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>>   		kill_anon_super(sb);
>>   	else
>>   		kill_block_super(sb);
>>   
>> -	sbi = EROFS_SB(sb);
>> -	if (!sbi)
>> -		return;
>> -
>>   	erofs_free_dev_context(sbi->devs);
>>   	fs_put_dax(sbi->dax_dev, NULL);
>>   	erofs_fscache_unregister_fs(sb);
-- 
With Best Regards,
Baokun Li
