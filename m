Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3E5A8BFF
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Sep 2022 05:45:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJ6Pn1VLBz3bk9
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Sep 2022 13:45:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=P3E1UMhV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=P3E1UMhV;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJ6Pj6J2Nz2xG4
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Sep 2022 13:45:11 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id q3so12715501pjg.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 31 Aug 2022 20:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Gd606AZnons4cjLyy1xBHjT09B3G6R66SB4dvzam21g=;
        b=P3E1UMhVu/jHWRgbH5LxvPn+VV//jrCh7jj2BbYkifd9ZgZ4nigpVupBhFarTyhYg+
         XQkS+Q58rQrGPAGxLcBDNFhEOSc4Ppv2j7XLvA0h993lfV3b+x/TY04SAoeppl/MEAhU
         DnM9elvvW9/korznvJpd85A8VJ5AQL/hU2D0N2ttMjklTN+h5EQFf/n4NnyGSBTTBRa+
         sRCvYU1ATZUinJt8FeZkaD3uSntXzTacmSt9BDvFpJ1RCevs2edDlOcikNyc/i6MwCqm
         RHBXtxxAh5oZ5BhiRv3vwdc2tsUgwN7KT+9o2O8s+YEf2x/KSoCk6N7pgUcvJcn4sbVm
         iyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Gd606AZnons4cjLyy1xBHjT09B3G6R66SB4dvzam21g=;
        b=4QLyLCHHBjbeoHZ74hhKr5hzjKqwcmZh/XVs6lEkvCalGj/1iVQGaa20E3HPcA8Arm
         nhgFmerbZavNgoXjxfejlw6th3/eT0eLQRjm+rXNrqJbDMBU/IiBDui87K+I6qlKPu/M
         w7HMizugJzAn735E/c8BfEcYvaYr1ZIid/5YlG0DzwcvjGSMO8CjAGx6mmHZEOOUkbhJ
         clZdn+CacgG0Rm7n8++L4lJQIIRU9co2nCcvt4Owqf5jHUZG7uQLTSlHwgHTBI5CoVic
         dXgxJmVbc2uNpC763eBO0pPs2wvtvwrs0EJw05k2wwnhn5rrP6/4lsv+HdyG1/1/GVvd
         EmHA==
X-Gm-Message-State: ACgBeo1tnH3PVp5fGX6jlL93yLp0khFTGUrYVpPziA6OpAIXyYL/ykJf
	1lwpt70D0s6ZPcL1QZJ8V7OrGXjcfJa6Bg==
X-Google-Smtp-Source: AA6agR7qZWYNWPW9qs159uxIZYgIjTgEKv8m7O0Pki8ZXnMfq2abz6acCEojmE2cAMHurt52TF94jA==
X-Received: by 2002:a17:903:2302:b0:175:376c:ba5a with SMTP id d2-20020a170903230200b00175376cba5amr8366411plh.160.1662003908438;
        Wed, 31 Aug 2022 20:45:08 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id 66-20020a620645000000b00536431c6ae0sm12064657pfg.101.2022.08.31.20.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 20:45:07 -0700 (PDT)
Message-ID: <8097af66-f39d-e197-5a47-a62e731c598a@bytedance.com>
Date: Thu, 1 Sep 2022 11:45:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [RFC PATCH 1/5] erofs: add 'domain_id' mount
 option for on-demand read sementics
To: linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yinxin.x@bytedance.com, jefflexu@linux.alibaba.com, huyue2@coolpad.com
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
 <20220831123125.68693-2-zhujia.zj@bytedance.com>
 <YxAnqC8pYf75epr1@B-P7TQMD6M-0146.local>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <YxAnqC8pYf75epr1@B-P7TQMD6M-0146.local>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/9/1 11:31, Gao Xiang 写道:
> On Wed, Aug 31, 2022 at 08:31:21PM +0800, Jia Zhu wrote:
>> Introduce 'domain_id' mount option to enable shared domain sementics.
>> In which case, the related cookie is shared if two mountpoints in the
>> same domain have the same data blob. Users could specify the name of
>> domain by this mount option.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/internal.h |  1 +
>>   fs/erofs/super.c    | 17 +++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index cfee49d33b95..fe435d077f1a 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -76,6 +76,7 @@ struct erofs_mount_opts {
>>   #endif
>>   	unsigned int mount_opt;
>>   	char *fsid;
>> +	char *domain_id;
>>   };
>>   
>>   struct erofs_dev_context {
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 3173debeaa5a..fb5a84a07bd5 100644
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
>> +		kfree(ctx->opt.domain_id);
>> +		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
>> +		if (!ctx->opt.domain_id)
>> +			return -ENOMEM;
>> +#ifdef CONFIG_EROFS_FS_ONDEMAND
>> +#else
>> +		errorfc(fc, "domain_id option not supported");
> 
> Just one question, why not write as below?
> 
> #ifdef CONFIG_EROFS_FS_ONDEMAND
> 		kfree(ctx->opt.domain_id);
> 		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
> 		if (!ctx->opt.domain_id)
> 			return -ENOMEM;
> #else
> 		errorfc(fc, "domain_id option not supported");
> #endif
> 
> Thanks,
> Gao Xiang
> 
Thanks for catching this. Maybe something went wrong when I split the
patch. I'll fix it in next version.

Thanks,
Zhu Jia
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
>> @@ -838,6 +851,7 @@ static void erofs_fc_free(struct fs_context *fc)
>>   
>>   	erofs_free_dev_context(ctx->devs);
>>   	kfree(ctx->opt.fsid);
>> +	kfree(ctx->opt.domain_id);
>>   	kfree(ctx);
>>   }
>>   
>> @@ -892,6 +906,7 @@ static void erofs_kill_sb(struct super_block *sb)
>>   	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>>   	erofs_fscache_unregister_fs(sb);
>>   	kfree(sbi->opt.fsid);
>> +	kfree(sbi->opt.domain_id);
>>   	kfree(sbi);
>>   	sb->s_fs_info = NULL;
>>   }
>> @@ -1044,6 +1059,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>>   	if (opt->fsid)
>>   		seq_printf(seq, ",fsid=%s", opt->fsid);
>> +	if (opt->domain_id)
>> +		seq_printf(seq, ",domain_id=%s", opt->domain_id);
>>   #endif
>>   	return 0;
>>   }
>> -- 
>> 2.20.1
