Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C565B6DD8
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 15:00:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRk8P044mz304J
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 23:00:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=FrvzOOFu;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=FrvzOOFu;
	dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRk8G3Xnmz2xHx
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 22:59:55 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id t3so11747072ply.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=xG9hg062b2ZIS+JDzyuJF9PDLmjCBLQtx5EPxF5Afdo=;
        b=FrvzOOFuTsDxW1FIWU2/cr+lbtpLEpLNQu1O2Fyq5PwLA6HtIbHcqBfIHFLkmr1nZD
         +qXuzx5UW0q8G/FpJK+ycBdP1GopWgWOcbciCYmEs64d/0MGpiTVuGIPvh5/0pVlcGUk
         SeV/tErBE3Hbe085vAvSzHaVvUKUrKOWXyeeqIyp1GrqzoopDGAeom8hwAPZ+J8Xi26I
         SNAmBSojnSFF5EUtn/qOIVXxKV4/IFLDfr1nNkh7AH4HktInbBTbRFe5J/8FOiFBTEzK
         VuVOkCwZjfcNqIET+2GOxutqogTqmjm9xJomlQp46C69+C5FW93IjB10faMrRZ0OR/eF
         UHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=xG9hg062b2ZIS+JDzyuJF9PDLmjCBLQtx5EPxF5Afdo=;
        b=dZx62/3hfSxX1Bh5ez0qx/XwQMadHQbQo73K/vJCxW1Sd/+Pi+iYyJ3IU+Orgj9p7/
         Tx02w6uRiuHDGOWTlXWOyF73jqQR0XC7E6EyfslVgFh0tWWK7Pbn5s2d15pij1qRYfdx
         UZHBoxSSNPK70P85HoRPX7JxcWThSsB4WmJsbsLEEu4vKO+cJd6g0RnnaPCHqZMAvlKP
         P4PbCCYyjzJ6Prmumiwg84yEpxuf2nt7ZGHOyPzceEOpZPJUquIFzvPZ68YLqr2gZezo
         YmwiueXsXGYtvJrcbQ6dHeRXKrBPz4LfXBG3tB2WbK26DgFuhIJkiZzguQY/oz+f3aRm
         AsKg==
X-Gm-Message-State: ACgBeo2Z2Krd8K0//LVLAfabGsICz2DhWS/QlutVaI7qGoHC1AO6cIm/
	v3D2Hz2gR8ClXG5VnsoO4+GWEg==
X-Google-Smtp-Source: AA6agR5bhxWeNfqv9JPYlGg1fagPXBZrurfTVzo+IVWkH3d+2spTZ8UiMMiwfdk/y+jxRkZi4aAmnQ==
X-Received: by 2002:a17:90a:1b6e:b0:1f5:1902:af92 with SMTP id q101-20020a17090a1b6e00b001f51902af92mr3984254pjq.238.1663073992788;
        Tue, 13 Sep 2022 05:59:52 -0700 (PDT)
Received: from [10.76.37.214] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id z8-20020aa79e48000000b0053b850b17c8sm7803611pfq.152.2022.09.13.05.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 05:59:52 -0700 (PDT)
Message-ID: <23018405-bd62-45b6-d3d0-6f0acb5630f5@bytedance.com>
Date: Tue, 13 Sep 2022 20:59:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V2 5/5] erofs: support fscache based shared
 domain
To: JeffleXu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-6-zhujia.zj@bytedance.com>
 <097a8ffb-c8b0-ed10-6c82-8a6de9bed09b@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <097a8ffb-c8b0-ed10-6c82-8a6de9bed09b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/9/13 14:27, JeffleXu 写道:
> 
> 
> On 9/2/22 6:53 PM, Jia Zhu wrote:
>> Several erofs filesystems can belong to one domain, and data blobs can
>> be shared among these erofs filesystems of same domain.
>>
>> Users could specify domain_id mount option to create or join into a domain.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/fscache.c  | 73 +++++++++++++++++++++++++++++++++++++++++++++
>>   fs/erofs/internal.h | 12 ++++++++
>>   fs/erofs/super.c    | 10 +++++--
>>   3 files changed, 93 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 439dd3cc096a..c01845808ede 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -559,12 +559,27 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>>   void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
>>   {
>>   	struct erofs_fscache *ctx = *fscache;
>> +	struct erofs_domain *domain;
>>   
>>   	if (!ctx)
>>   		return;
>> +	domain = ctx->domain;
>> +	if (domain) {
>> +		mutex_lock(&domain->mutex);
>> +		/* Cookie is still in use */
>> +		if (atomic_read(&ctx->anon_inode->i_count) > 1) {
>> +			iput(ctx->anon_inode);
>> +			mutex_unlock(&domain->mutex);
>> +			return;
>> +		}
>> +		iput(ctx->anon_inode);
>> +		kfree(ctx->name);
>> +		mutex_unlock(&domain->mutex);
>> +	}
>>   
>>   	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>>   	fscache_relinquish_cookie(ctx->cookie, false);
>> +	erofs_fscache_domain_put(domain);
>>   	ctx->cookie = NULL;
>>   
>>   	iput(ctx->inode);
>> @@ -609,3 +624,61 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
>>   	sbi->volume = NULL;
>>   	sbi->domain = NULL;
>>   }
>> +
>> +static int erofs_fscache_domain_init_cookie(struct super_block *sb,
>> +		struct erofs_fscache **fscache, char *name, bool need_inode)
>> +{
>> +	int ret;
>> +	struct inode *inode;
>> +	struct erofs_fscache *ctx;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +	struct erofs_domain *domain = sbi->domain;
>> +
>> +	ret = erofs_fscache_register_cookie(sb, &ctx, name, need_inode);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ctx->name = kstrdup(name, GFP_KERNEL);
>> +	if (!ctx->name)
>> +		return -ENOMEM;
> 
> Shall we clean up the above registered cookie in the error path?
> 
If this step fails, error will be transmitted to vfs_get_tree() and
erofs_kill_sb() will relinquish the cookie.
>> +
>> +	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
>> +	if (!inode) {
>> +		kfree(ctx->name);
>> +		return -ENOMEM;
>> +	}
> 
> Ditto.
> 
>> +
>> +	ctx->domain = domain;
>> +	ctx->anon_inode = inode;
>> +	inode->i_private = ctx;
>> +	erofs_fscache_domain_get(domain);
>> +	*fscache = ctx;
>> +	return 0;
>> +}
>> +
>> +int erofs_domain_register_cookie(struct super_block *sb,
>> +	struct erofs_fscache **fscache, char *name, bool need_inode)
>> +{
>> +	int err;
>> +	struct inode *inode;
>> +	struct erofs_fscache *ctx;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +	struct erofs_domain *domain = sbi->domain;
>> +	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
>> +
>> +	mutex_lock(&domain->mutex);
> 
> What is domain->mutex used for?
> 
This lock is used to avoid race conditions between cookie's
traverse/del/insert in the inode list.
It seems to be possible to increase the granularity of the lock
after v2's change "Only initialize one pseudo fs to manage anonymous 
inodes(cookies).".
> 
>> +	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
>> +		ctx = inode->i_private;
>> +		if (!ctx)
>> +			continue;
>> +		if (!strcmp(ctx->name, name)) {
>> +			*fscache = ctx;
>> +			igrab(inode);
>> +			mutex_unlock(&domain->mutex);
>> +			return 0;
>> +		}
>> +	}
>> +	err = erofs_fscache_domain_init_cookie(sb, fscache, name, need_inode);
>> +	mutex_unlock(&domain->mutex);
>> +	return err;
>> +}
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 2790c93ffb83..efa4f4ad77cc 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -110,6 +110,9 @@ struct erofs_domain {
>>   struct erofs_fscache {
>>   	struct fscache_cookie *cookie;
>>   	struct inode *inode;
>> +	struct inode *anon_inode;
> 
> Why can't we reuse @inode for anon_inode?
> 
We use pseudo sb's anonymous inodes list to manage the cookie.
Wouldn't it be a bit of messy if reuses erofs meta inode?
> 
>> +	struct erofs_domain *domain;
>> +	char *name;
>>   };
>>   
>>   struct erofs_sb_info {
>> @@ -625,6 +628,9 @@ int erofs_fscache_register_domain(struct super_block *sb);
>>   int erofs_fscache_register_cookie(struct super_block *sb,
>>   				  struct erofs_fscache **fscache,
>>   				  char *name, bool need_inode);
>> +int erofs_domain_register_cookie(struct super_block *sb,
>> +				  struct erofs_fscache **fscache,
>> +				  char *name, bool need_inode);
>>   void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
>>   
>>   extern const struct address_space_operations erofs_fscache_access_aops;
>> @@ -646,6 +652,12 @@ static inline int erofs_fscache_register_cookie(struct super_block *sb,
>>   {
>>   	return -EOPNOTSUPP;
>>   }
>> +static inline int erofs_domain_register_cookie(struct super_block *sb,
>> +						struct erofs_fscache **fscache,
>> +						char *name, bool need_inode)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>>   
>>   static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
>>   {
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 667a78f0ee70..11c5ba84567c 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -245,8 +245,12 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>>   	}
>>   
>>   	if (erofs_is_fscache_mode(sb)) {
>> -		ret = erofs_fscache_register_cookie(sb, &dif->fscache,
>> -				dif->path, false);
>> +		if (sbi->opt.domain_id)
>> +			ret = erofs_domain_register_cookie(sb, &dif->fscache, dif->path,
>> +					false);
>> +		else
>> +			ret = erofs_fscache_register_cookie(sb, &dif->fscache, dif->path,
>> +					false);
>>   		if (ret)
>>   			return ret;
>>   	} else {
>> @@ -726,6 +730,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   			err = erofs_fscache_register_domain(sb);
>>   			if (err)
>>   				return err;
>> +			err = erofs_domain_register_cookie(sb, &sbi->s_fscache,
>> +					sbi->opt.fsid, true);
>>   		} else {
>>   			err = erofs_fscache_register_fs(sb);
>>   			if (err)
> 
