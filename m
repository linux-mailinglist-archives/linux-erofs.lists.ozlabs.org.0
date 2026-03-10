Return-Path: <linux-erofs+bounces-2552-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBkdLpq9r2kucAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2552-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 07:43:38 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D12245DFE
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 07:43:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVPTy6ggzz3bjb;
	Tue, 10 Mar 2026 17:43:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773125014;
	cv=none; b=b9NiaS6JyvBnepEPmRccBcFycq2v7yXBa+910NO0AJqWQdX86MDKsDSzBESWZbc8BC6HOp3FleP0IOh38p6KIUkkXgDesP6ozVl7JqIM6PGLF8tUHbJF762i+FR0QQnMVwEtX9hc3GJA+ZdLm5pj+CeEg2fTkeSfeNqi4RFXFMsbuM75y1bNstqOeC5nFp/dVbpUa3Glwbh5xFRvhfm6ctK41X1OH+uie1DnxrKs9FkbZkoDZaDILQOVxnL93PKTnX0btZ2l93guQhEzLN+0XQ9ExhoA9OmeUDDbADaLjorqd2Xm3gSj/z5qkk6mc3ZRcaLFzN/zV4a8A5RiUOvI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773125014; c=relaxed/relaxed;
	bh=z+NWuR6D28V3FwcjD4wRFykiU5WsJ5XGd59owvJkdWU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UIL3MQm/CnP7980D6q9xeaC9STiDAzbh5Z4WCYitdMZbpq8/MzRm9AePGMsomGdbU9Fc9o1FdxPAhX3X0yvsAALMQSERBDnOnt3gyDDvywwaBXTYdtGAfESSC6JR3LlWLCCFgsjnw+zmIvQKodIFxoo3/k/VrbEIYzHkDje2xkV0nirunM+0vpBLWvendZb4/gkMQ58lKK6xSBX7N/CLCGqmLYO8efPrEbJ5K5hf8hlozcbxOHZRcke33XqnKQVzO247ZYDdrunhlKGS8oPoEkSClsb+PK2MrkUJmQy9ezhk4fhgjzsHbfeElAyygaX2ZyqUN4vBNG6wsrJPYZ3haw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fR5D1qin; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fR5D1qin;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVPTx5ghQz2yFY
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 17:43:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4004C44197;
	Tue, 10 Mar 2026 06:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F08C19423;
	Tue, 10 Mar 2026 06:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773125011;
	bh=kmAHE66Z62sPt/kCRQBOfYRaj9T5VBqB56d8tCGRNZI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fR5D1qine57olTg3hpBxhT4rnXpUN3Iap9wCSI0VnbNOyCEq9lpGEvrskCnHMMQK4
	 V9b+vd1GS4PsA+MAybnBaFNHU1O2uo5yeHqmYwn/axv23Mv+t0Ixy51UiWg9ZDET1u
	 HVpVP+XxhJSNErHa3Oyp3/yVsWVUylI/o2YW4LQ0+x6GBZCrvevN1BjBNgGK7ySmKZ
	 JOLmyXVUWX/FBEEs9geZ4l7QRz55JDndv5dF8heZfjFXflwjsAwf9VB08WsV64Pzbm
	 v0o/tBWT6Q7XGVrjEG3eOvocGvJlVTha8PscHGoz4neqsAeU5nwP33JrLilQ2IQp/4
	 sqVSbquXfUmoA==
Message-ID: <dc645bd1-2881-4472-8918-0eada3786ab3@kernel.org>
Date: Tue, 10 Mar 2026 14:43:25 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Chunhai Guo <guochunhai@vivo.com>,
 Hongbo Li <lihongbo22@huawei.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] erofs: introduce nolargefolio mount option
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20260309023053.1685839-1-chao@kernel.org>
 <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: B9D12245DFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2552-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.ozlabs.org,vger.kernel.org,gmail.com,linux.alibaba.com,google.com,vivo.com,huawei.com,infradead.org,suse.cz];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:guochunhai@vivo.com,m:lihongbo22@huawei.com,m:willy@infradead.org,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlesource.com:url,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Xiang,

On 3/9/26 11:03, Gao Xiang wrote:
> Hi Chao,
> 
> (+cc -fsdevel, willy, Jan kara)
> 
> On 2026/3/9 10:30, Chao Yu wrote:
>> This patch introduces a new mount option 'nolargefolio' for EROFS.
>> When this option is specified, large folio will be disabled by
>> default for all inodes, this option can be used for environments
>> where large folio resources are limited, it's necessary to only
>> let specified user to allocate large folios on demand.
> 
> For this kind of options, I think more real backgrounds
> about avoiding high-order allocations are needed in the
> commit message (at least for later reference) also like
> what I observed in:
> https://android-review.googlesource.com/c/kernel/common/+/3877981

Basically, the background is about contention scenario on large folio allocation,
it's among multiple users including EROFS in Android-system, as it's related to
internal scene of product, so I can not provide more details now, I'm sorry
about that, but I'm glad to discuss based on the background and pain point once
if I can share more, let's see. :)

> 
> because the entire community tends to enable large folios
> unconditionally if possible.  Without enough clarification,
> even I merge this, there will be endless questions again
> and again about this.
> 
> And Jan once raised up if it should be a user interface
> or auto-tuning one:
> https://lore.kernel.org/r/z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5

Thanks for sharing this anyway, I didn't notice this previously...

Thanks,

> > My question is that if the needs are real, I wonder if
> it should be a vfs generic decision instead (because
> it's not due to the filesystem restriction but due to
> real system memory pressure or heavy workload for
> example).  However, if the answer is that others don't
> really care about this, I'm fine to leave it as an
> erofs-specific option as long as the actual case is
> clear in the commit message.
> > Thanks,
> Gao Xiang
> 
> 
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   Documentation/filesystems/erofs.rst | 1 +
>>   fs/erofs/inode.c                    | 3 ++-
>>   fs/erofs/internal.h                 | 1 +
>>   fs/erofs/super.c                    | 8 +++++++-
>>   4 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
>> index fe06308e546c..d692a1d9f32c 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -137,6 +137,7 @@ fsoffset=%llu          Specify block-aligned filesystem offset for the primary d
>>   inode_share            Enable inode page sharing for this filesystem.  Inodes with
>>                          identical content within the same domain ID can share the
>>                          page cache.
>> +nolargefolio           Disable large folio support for all files.
>>   ===================    =========================================================
>>     Sysfs Entries
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 4b3d21402e10..26361e86a354 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -254,7 +254,8 @@ static int erofs_fill_inode(struct inode *inode)
>>           return 0;
>>       }
>>   -    mapping_set_large_folios(inode->i_mapping);
>> +    if (!test_opt(&EROFS_SB(inode->i_sb)->opt, NO_LARGE_FOLIO))
>> +        mapping_set_large_folios(inode->i_mapping);
>>       aops = erofs_get_aops(inode, false);
>>       if (IS_ERR(aops))
>>           return PTR_ERR(aops);
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index a4f0a42cf8c3..b5d98410c699 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -177,6 +177,7 @@ struct erofs_sb_info {
>>   #define EROFS_MOUNT_DAX_NEVER        0x00000080
>>   #define EROFS_MOUNT_DIRECT_IO        0x00000100
>>   #define EROFS_MOUNT_INODE_SHARE        0x00000200
>> +#define EROFS_MOUNT_NO_LARGE_FOLIO    0x00000400
>>     #define clear_opt(opt, option)    ((opt)->mount_opt &= ~EROFS_MOUNT_##option)
>>   #define set_opt(opt, option)    ((opt)->mount_opt |= EROFS_MOUNT_##option)
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 972a0c82198d..a353369d4db8 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -390,7 +390,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>>   enum {
>>       Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>       Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
>> -    Opt_inode_share,
>> +    Opt_inode_share, Opt_nolargefolio,
>>   };
>>     static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -419,6 +419,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>>       fsparam_flag_no("directio",    Opt_directio),
>>       fsparam_u64("fsoffset",        Opt_fsoffset),
>>       fsparam_flag("inode_share",    Opt_inode_share),
>> +    fsparam_flag("nolargefolio",    Opt_nolargefolio),
>>       {}
>>   };
>>   @@ -541,6 +542,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>           else
>>               set_opt(&sbi->opt, INODE_SHARE);
>>           break;
>> +    case Opt_nolargefolio:
>> +        set_opt(&sbi->opt, NO_LARGE_FOLIO);
>> +        break;
>>       }
>>       return 0;
>>   }
>> @@ -1105,6 +1109,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>>           seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
>>       if (test_opt(opt, INODE_SHARE))
>>           seq_puts(seq, ",inode_share");
>> +    if (test_opt(opt, NO_LARGE_FOLIO))
>> +        seq_puts(seq, ",nolargefolio");
>>       return 0;
>>   }
>>   
> 


