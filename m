Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1478A5645
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 17:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713194657;
	bh=no4P2eEklmZxh5wJJkY7jw/ry57KsIEdYvIBbzYz8Mo=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ckVGuZfWs7ae2vqHsgHHqNH9i5t617i4ay9HOILDm53KgjRI8Wc0o7PCnUs7c2dKq
	 6b6mnwvJNoUfrOzw4HejwkGOlWNlXZtq21YHe2zPkGcInqC/ofXdeE+H09sEfHTD6A
	 POKEHrACWqcktVq45CBHfRAgRopbIei09FXhbxFueNz/zPVL2rSd+zV0//oVr9evHL
	 tQVGEVrgWbs7acjREBkVAsx8STYw9uQQiL+gQdG93ohgiaSrR/x8wQRMV7SxyB5amq
	 j97mi09t27LU7/t3MWldIRMT1nC1YC9A15ELix4BPmZdYPEzYNdmUjQPVpUMWZVAO+
	 9FnajdwLayl7w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJ9v52s1Rz3dW1
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 01:24:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJ9tx1yFSz3d2m
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Apr 2024 01:24:05 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VJ9qL5XzQz2CcN7;
	Mon, 15 Apr 2024 23:21:02 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 4654F1402C7;
	Mon, 15 Apr 2024 23:23:59 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 23:23:58 +0800
Message-ID: <15ab9875-5123-7bc2-bb25-fc683129ad9e@huawei.com>
Date: Mon, 15 Apr 2024 23:23:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
To: Christian Brauner <brauner@kernel.org>
References: <20240415121746.1207242-1-libaokun1@huawei.com>
 <20240415-betagten-querlatte-feb727ed56c1@brauner>
Content-Language: en-US
In-Reply-To: <20240415-betagten-querlatte-feb727ed56c1@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/4/15 21:38, Christian Brauner wrote:
> On Mon, Apr 15, 2024 at 08:17:46PM +0800, Baokun Li wrote:
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
>> To avoid this problem, add SB_NODEV to fc->sb_flags after successfully
>> parsing the fsid, and then the superblock inherits this flag when it is
>> allocated, so that the sb_flags can be used to distinguish whether it is
>> in block dev based mode when calling erofs_kill_sb().
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/erofs/super.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index b21bd8f78dc1..7539ce7d64bc 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -520,6 +520,7 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>   		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
>>   		if (!ctx->fsid)
>>   			return -ENOMEM;
>> +		fc->sb_flags |= SB_NODEV;
> Hm, I wouldn't do it this way. That's an abuse of that flag imho.
> Record the information in the erofs_fs_context if you need to.
The stack diagram that triggers the problem is as follows, the call to
erofs_kill_sb() fails before fill_super() has been executed, and we can
only use super_block to determine whether it is currently in nodev
fscahe mode or block device based mode. So if it is recorded in
erofs_fs_context (aka fc->fs_private), we can't access the recorded data
unless we pass fc into erofs_kill_sb() as well.

do_new_mount
  fs_context_for_mount
   alloc_fs_context
    erofs_init_fs_context
     // Mount options have not been parsed yet,
     // it is not clear if there is an fsid
  parse_monolithic_mount_data
   generic_parse_monolithic
    erofs_fc_parse_param
     case Opt_fsid:
       // fc->sb_flags |= SB_NODEV;
  vfs_get_tree
   erofs_fc_get_tree
    get_tree_bdev
     s = sget_dev(fc, dev)
       s = alloc_super()
         s->s_flags = fc->sb_flags;
     setup_bdev_super
       // return error
       sb->s_bdev = bdev // s_bdev is NULL
     deactivate_locked_super
       erofs_kill_sb
         // Block device based mode is considered fscahe mode for nodev
         erofs_is_fscache_mode(sb)
           IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !sb->s_bdev
          kill_anon_super(sb)
            free_anon_bdev(dev)
              ida_free(&unnamed_dev_ida, MINOR(dev))
              ((int)id < 0)
              WARN(1, "ida_free called for id=%d which is not 
allocated.\n", id);


Thanks!
-- 
With Best Regards,
Baokun Li
