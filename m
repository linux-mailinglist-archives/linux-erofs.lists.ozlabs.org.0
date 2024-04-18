Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 694E18A9298
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 07:50:53 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KPF0XH2R;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKn224CT8z3cR2
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 15:50:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KPF0XH2R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKn1t3hV1z3c1L
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 15:50:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713419436; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4eOeKenzK1gFrzCAeTlcjNO1rvtm7qAGVD0c/9ky3IQ=;
	b=KPF0XH2Rd60kNt4YPZcQwIEYFtGAKsYEAEac+J/cG5zNPRMio++3KtJjacdvqRzl16q+WpMfEzY/8fHwj9s1a4pxdaBaFG0F+LPDm4G6qKF2Jb5M78SlR1NoZ1IqMkHviX0aEruaxTz3DU/ABR69hL0fNlISTrAgwm8RqaROaBc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W4nXygh_1713419431;
Received: from 30.221.145.60(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W4nXygh_1713419431)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 13:50:32 +0800
Message-ID: <fb65c7d0-c348-409e-b977-07616d28b279@linux.alibaba.com>
Date: Thu, 18 Apr 2024 13:50:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: reliably distinguish block based and fscache
 mode
Content-Language: en-US
To: Baokun Li <libaokun1@huawei.com>
References: <20240417065513.3409744-1-libaokun1@huawei.com>
 <71e66b02-9c2b-4981-83e1-8af72d6c0975@linux.alibaba.com>
 <7fdf4bff-2d3d-bdc0-5446-caa58aeca314@huawei.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <7fdf4bff-2d3d-bdc0-5446-caa58aeca314@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 4/18/24 11:36 AM, Baokun Li wrote:
> On 2024/4/18 10:16, Jingbo Xu wrote:
>> Hi Baokun,
>>
>> Thanks for catching this and move forward fixing this!
> 
> Hi Jingbo，
> 
> Thanks for your review！
> 
>>
>> On 4/17/24 2:55 PM, Baokun Li wrote:
>>> When erofs_kill_sb() is called in block dev based mode, s_bdev may
>>> not have
>>> been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it
>>> will
>>> be mistaken for fscache mode, and then attempt to free an anon_dev
>>> that has
>>> never been allocated, triggering the following warning:
>>>
>>> ============================================
>>> ida_free called for id=0 which is not allocated.
>>> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
>>> Modules linked in:
>>> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
>>> RIP: 0010:ida_free+0x134/0x140
>>> Call Trace:
>>>   <TASK>
>>>   erofs_kill_sb+0x81/0x90
>>>   deactivate_locked_super+0x35/0x80
>>>   get_tree_bdev+0x136/0x1e0
>>>   vfs_get_tree+0x2c/0xf0
>>>   do_new_mount+0x190/0x2f0
>>>   [...]
>>> ============================================
>>>
>>> Instead of allocating the erofs_sb_info in fill_super() allocate it
>>> during erofs_get_tree() and ensure that erofs can always have the info
>>> available during erofs_kill_sb().
>>
>> I'm not sure if allocating erofs_sb_info in erofs_init_fs_context() will
>> be better, as I see some filesystems (e.g. autofs) do this way.  Maybe
>> another potential advantage of doing this way is that erofs_fs_context
>> is not needed anymore and we can use sbi directly.
> Yes, except for some extra memory usage when remounting,
> this idea sounds great. Let me send a version of v3 to get rid
> of erofs_fs_context.

I'm not sure if Gao Xaing also prefers this.  I think it would be better
to wait and listen for his thoughts before we sending v3.

>>
>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> ---
>>> Changes since v1:
>>>    Allocate and initialise fc->s_fs_info in erofs_fc_get_tree()
>>> instead of
>>>    modifying fc->sb_flags.
>>>
>>> V1:
>>> https://lore.kernel.org/r/20240415121746.1207242-1-libaokun1@huawei.com/
>>>
>>>   fs/erofs/super.c | 51 ++++++++++++++++++++++++++----------------------
>>>   1 file changed, 28 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>> index b21bd8f78dc1..4104280be2ea 100644
>>> --- a/fs/erofs/super.c
>>> +++ b/fs/erofs/super.c
>>> @@ -581,8 +581,7 @@ static const struct export_operations
>>> erofs_export_ops = {
>>>   static int erofs_fc_fill_super(struct super_block *sb, struct
>>> fs_context *fc)
>>>   {
>>>       struct inode *inode;
>>> -    struct erofs_sb_info *sbi;
>>> -    struct erofs_fs_context *ctx = fc->fs_private;
>>> +    struct erofs_sb_info *sbi = EROFS_SB(sb);
>>>       int err;
>>>         sb->s_magic = EROFS_SUPER_MAGIC;
>>> @@ -590,19 +589,6 @@ static int erofs_fc_fill_super(struct
>>> super_block *sb, struct fs_context *fc)
>>>       sb->s_maxbytes = MAX_LFS_FILESIZE;
>>>       sb->s_op = &erofs_sops;
>>>   -    sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>>> -    if (!sbi)
>>> -        return -ENOMEM;
>>> -
>>> -    sb->s_fs_info = sbi;
>>> -    sbi->opt = ctx->opt;
>>> -    sbi->devs = ctx->devs;
>>> -    ctx->devs = NULL;
>>> -    sbi->fsid = ctx->fsid;
>>> -    ctx->fsid = NULL;
>>> -    sbi->domain_id = ctx->domain_id;
>>> -    ctx->domain_id = NULL;
>>> -
>>>       sbi->blkszbits = PAGE_SHIFT;
>>>       if (erofs_is_fscache_mode(sb)) {
>>>           sb->s_blocksize = PAGE_SIZE;
>>> @@ -704,11 +690,32 @@ static int erofs_fc_fill_super(struct
>>> super_block *sb, struct fs_context *fc)
>>>       return 0;
>>>   }
>>>   -static int erofs_fc_get_tree(struct fs_context *fc)
>>> +static void erofs_ctx_to_info(struct fs_context *fc)
>>>   {
>>>       struct erofs_fs_context *ctx = fc->fs_private;
>>> +    struct erofs_sb_info *sbi = fc->s_fs_info;
>>> +
>>> +    sbi->opt = ctx->opt;
>>> +    sbi->devs = ctx->devs;
>>> +    ctx->devs = NULL;
>>> +    sbi->fsid = ctx->fsid;
>>> +    ctx->fsid = NULL;
>>> +    sbi->domain_id = ctx->domain_id;
>>> +    ctx->domain_id = NULL;
>>> +}
>> I'm not sure if abstracting this logic into a seperate helper really
>> helps understanding the code as the logic itself is quite simple and
>> easy to be understood. Usually it's a hint of over-abstraction when a
>> simple helper has only one caller.
>>
> Static functions that have only one caller are compiled inline, so we
> don't have to worry about how that affects the code.
> 
> The reason these codes are encapsulated in a separate function is so
> that the code reader understands that these codes are integrated
> as a whole, and that we shouldn't have to move one or two of these
> lines individually.
> 
> But after we get rid of erofs_fs_context, those won't be needed
> anymore.

Yeah, I understand. It's only coding style concerns.



-- 
Thanks,
Jingbo
