Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E95B95A1
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 09:44:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSq2q58xSz3bcv
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 17:44:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=oyz638cJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=oyz638cJ;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSq2l4Fb4z3062
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 17:43:57 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id o23so15654409pji.4
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=0aDjag9mgnZUwZDL3/dmCWrXaKWe2fIwx4al3A3NRMo=;
        b=oyz638cJKv6J2roLzQ7KUUqYcsktC7gk6sSK61//s+wfmM89JEHwWAFFzoyA9msFCh
         44J2ixTroDwnDnlQpQJFyyVd7oQ1sWmMiAjPIoVqCn2RNA9YCAOpnywWqYFXfHluDIE6
         7AvXNfldrSe9Si+E+wK6AwTI8CwdoR1ErcLG7iueucws0kOlmCc8HbjIFumwevGGDRLO
         v8fFYS70WGHt93NMrzi8r7zgJxcGHGeb/Hfk3rdn5fyWB4hehZKAYx2TeZDEghunP9Ys
         hgdZhXirIgAPO6X3Bue/aRm5tncCxy4BwS+Vqvkj7WTboJS5Y/LM4kPdRCdJucOX6j4a
         UzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=0aDjag9mgnZUwZDL3/dmCWrXaKWe2fIwx4al3A3NRMo=;
        b=yT7dfMR61j7OYScAdGVAqTTt8ZFR0mK8T0cv48a+pVDOUMx9k4dBc4G6D5pCqr0VS9
         7seeh0QZh2qvtx+uawgXFaHG+dZNCHZvrk7u+SuZbkK4ybQ03Hpenh9wZH+GdY+qwqZL
         Zzh0nZezNGRBccOh5eID3BEI3YGZYvDxQzca7JRSuVLpIa1TuJ9/PAL2Fu5aZj5vXEDg
         o8C/0OLxkmn6m3TvWVwO6gqbq3YFD5pyCq77B/CgqlC8EFMC+4cNRM10FPVhlG8E8md/
         fNZnTawzLuhk0RM/leeolsEEv1eEqt8TgcEu8SXsqwJaJr545UsAnUHd0Tvt+RsIPo0Q
         uBnQ==
X-Gm-Message-State: ACrzQf30kLJvn2QNjwm+zAHsYDMkq874MDV9b4Vz3gbPGyI1rvGnEtJb
	uFW3Y3jegeJ3ZhBXAEsXPhmWRg==
X-Google-Smtp-Source: AMsMyM6vuIQZnI1C1ZB+e9OYLPdSrSfPmwYiZ5VrqRkRue21ifj6ZjJQJo6NNXBl1QRT1db/LF3ohQ==
X-Received: by 2002:a17:902:d482:b0:178:1585:40b6 with SMTP id c2-20020a170902d48200b00178158540b6mr3092415plg.134.1663227834350;
        Thu, 15 Sep 2022 00:43:54 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902f35100b00172b87d9770sm12008735ple.81.2022.09.15.00.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 00:43:53 -0700 (PDT)
Message-ID: <dfebd3d3-29e6-b01e-a163-2ea0766062ae@bytedance.com>
Date: Thu, 15 Sep 2022 15:43:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V3 3/6] erofs: introduce 'domain_id' mount
 option
To: JeffleXu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-4-zhujia.zj@bytedance.com>
 <6644b9eb-d477-bbca-bbbe-b41776e38a46@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <6644b9eb-d477-bbca-bbbe-b41776e38a46@linux.alibaba.com>
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



在 2022/9/15 15:30, JeffleXu 写道:
> 
> 
> On 9/14/22 6:50 PM, Jia Zhu wrote:
>> Introduce 'domain_id' mount option to enable shared domain sementics.
>> In which case, the related cookie is shared if two mountpoints in the
>> same domain have the same data blob. Users could specify the name of
>> domain by this mount option.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> 
> Could you please move this patch to the end of this patch set, so that
> once the "domain_id" mount option is visible to users, this feature
> really works?
> 
Thanks for your example. I'll revise it.
> 
>> ---
>>   fs/erofs/internal.h |  1 +
>>   fs/erofs/super.c    | 17 +++++++++++++++++
>>   fs/erofs/sysfs.c    | 19 +++++++++++++++++--
>>   3 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index aa71eb65e965..2d129c6b3027 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -76,6 +76,7 @@ struct erofs_mount_opts {
>>   #endif
>>   	unsigned int mount_opt;
>>   	char *fsid;
>> +	char *domain_id;
>>   };
> 
> Indeed we can add @domain_id field into struct erofs_mount_opts in prep
> for the following implementation of the domain_id feature. IOW, the
> above change can be folded into patch 4, just like what [1] does.
> 
> [1]
> https://github.com/torvalds/linux/commit/c6be2bd0a5dd91f98d6b5d2df2c79bc32993352c#diff-eee5fb30f4e83505af808386e84c953266d2fd2e76b6e66cb94cf6e849881240R77
> 
> 
>>   
>>   struct erofs_dev_context {
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 7aa57dcebf31..856758ee4869 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -440,6 +440,7 @@ enum {
>>   	Opt_dax_enum,
>>   	Opt_device,
>>   	Opt_fsid,
>> +	Opt_domain_id,
>>   	Opt_err
>>   };
>>   
>> @@ -465,6 +466,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>>   	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
>>   	fsparam_string("device",	Opt_device),
>>   	fsparam_string("fsid",		Opt_fsid),
>> +	fsparam_string("domain_id",	Opt_domain_id),
>>   	{}
>>   };
>>   
>> @@ -568,6 +570,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>   			return -ENOMEM;
>>   #else
>>   		errorfc(fc, "fsid option not supported");
>> +#endif
>> +		break;
>> +	case Opt_domain_id:
>> +#ifdef CONFIG_EROFS_FS_ONDEMAND
>> +		kfree(ctx->opt.domain_id);
>> +		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
>> +		if (!ctx->opt.domain_id)
>> +			return -ENOMEM;
>> +#else
>> +		errorfc(fc, "domain_id option not supported");
>>   #endif
>>   		break;
>>   	default:
>> @@ -695,6 +707,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	sb->s_fs_info = sbi;
>>   	sbi->opt = ctx->opt;
>>   	ctx->opt.fsid = NULL;
>> +	ctx->opt.domain_id = NULL;
>>   	sbi->devs = ctx->devs;
>>   	ctx->devs = NULL;
>>   
>> @@ -834,6 +847,7 @@ static void erofs_fc_free(struct fs_context *fc)
>>   
>>   	erofs_free_dev_context(ctx->devs);
>>   	kfree(ctx->opt.fsid);
>> +	kfree(ctx->opt.domain_id);
>>   	kfree(ctx);
>>   }
>>   
>> @@ -887,6 +901,7 @@ static void erofs_kill_sb(struct super_block *sb)
>>   	fs_put_dax(sbi->dax_dev, NULL);
>>   	erofs_fscache_unregister_fs(sb);
>>   	kfree(sbi->opt.fsid);
>> +	kfree(sbi->opt.domain_id);
>>   	kfree(sbi);
>>   	sb->s_fs_info = NULL;
>>   }
>> @@ -1040,6 +1055,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>>   	if (opt->fsid)
>>   		seq_printf(seq, ",fsid=%s", opt->fsid);
>> +	if (opt->domain_id)
>> +		seq_printf(seq, ",domain_id=%s", opt->domain_id);
>>   #endif
>>   	return 0;
>>   }
>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>> index c1383e508bbe..341fb43ad587 100644
>> --- a/fs/erofs/sysfs.c
>> +++ b/fs/erofs/sysfs.c
>> @@ -201,12 +201,27 @@ static struct kobject erofs_feat = {
>>   int erofs_register_sysfs(struct super_block *sb)
>>   {
>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +	char *name;
>> +	char *str = NULL;
>>   	int err;
>>   
>> +	if (erofs_is_fscache_mode(sb)) {
>> +		if (sbi->opt.domain_id) {
>> +			str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id,
>> +					sbi->opt.fsid);
>> +			if (!str)
>> +				return -ENOMEM;
>> +			name = str;
>> +		} else {
>> +			name = sbi->opt.fsid;
>> +		}
>> +	} else {
>> +		name = sb->s_id;
>> +	}
>>   	sbi->s_kobj.kset = &erofs_root;
>>   	init_completion(&sbi->s_kobj_unregister);
>> -	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
>> -			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
>> +	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s", name);
>> +	kfree(str);
>>   	if (err)
>>   		goto put_sb_kobj;
>>   	return 0;
> 
