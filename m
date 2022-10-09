Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF68F5F8A71
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Oct 2022 11:51:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MlckY64pZz3dqL
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Oct 2022 20:51:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=M0BkIGpC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=M0BkIGpC;
	dkim-atps=neutral
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MlckQ2vHgz3bXG
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Oct 2022 20:51:07 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id h13so7053112pfr.7
        for <linux-erofs@lists.ozlabs.org>; Sun, 09 Oct 2022 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4m/+MFcLOu4fQCGtHWhklBXP7FJWyhQPBvhnJItC0c=;
        b=M0BkIGpCPs5WRIhkp5YvPZkU11BRLUcfcPNWBr3DX2G/p7/g7R0/gWmemHB6ZtiJw6
         jJlsadqBG5YSHH1FbvPluGZTEHsH8CynoCL5n/Rwvbfq8AZ2s00eduguIaNplfp168nJ
         4SVwb1BM4Imfwk5YISPgREglA7TCyGIo6lW/AYsnrm14/mFiDBLBGZzhrWTxpiJKh7RJ
         XNXZ4/CSmAl0PZ/G4AMnlnLtPQikFhtu9tEE2Vg2y7E8MWtLkyUk82+9jT/kuIeVRX5r
         EjTPdmtsl7eDlzOYEogrczXyUuRKb6e3pJ6r9lm1bfWt1RfSVz+EJXZlpENZgJP8AIbd
         vDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4m/+MFcLOu4fQCGtHWhklBXP7FJWyhQPBvhnJItC0c=;
        b=ASpm29kkBCPUIk3bdDN1zvlWnzGlu3GR/hcu+Y7Q340RzHIgt3VmrhAcOUMBCEGv5e
         kwDihyIoNAa8i64rRB+WJXyfsmhxyj5Hazu2Qe3UCeFHgs+43B5oSrQSPU480KSk7UJW
         bYLRV/QShvtiqEjO0f3nwo+Y7ZBG1RSPMCjqD0Ox4K/hhS+bvN3nkJ8Avl/DwNpwSGUb
         hfd0H1B+Awl95DWmvxyED7Om2VUxCKyfz8WkhCyLB5kS9yLylX+OG3RWDoB6gdY8LZ1i
         ggTukiJTBTW59ghPFiaEderxMnlXTXJIJQdNV0JxfI522V35QtBNqwf0vhhJdMtmNAcU
         UW5Q==
X-Gm-Message-State: ACrzQf28Nf3aLP8Nwbz8o40530Ld/DWwNWekKxZGMnG6KL9wRQDM5gdC
	1u3BgW6mBNK52dCTnx7N2c2j0w==
X-Google-Smtp-Source: AMsMyM7F2xzqmrYGH1iUoyWGCA+/PPWnIKp4VkJG06mIj7pLxR5nygmemQM7ncAmvXBG27h9VFZziw==
X-Received: by 2002:a05:6a00:1a08:b0:545:362c:b219 with SMTP id g8-20020a056a001a0800b00545362cb219mr13787740pfv.27.1665309064778;
        Sun, 09 Oct 2022 02:51:04 -0700 (PDT)
Received: from [10.3.156.122] ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id b7-20020a621b07000000b0053b723a74f7sm4795147pfb.90.2022.10.09.02.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 02:51:04 -0700 (PDT)
Message-ID: <35dfe983-f916-d972-497d-269ec44cf7bf@bytedance.com>
Date: Sun, 9 Oct 2022 17:50:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [External] Re: [RFC PATCH 2/5] cachefiles: extract ondemand info
 field from cachefiles_object
To: JeffleXu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 xiang@kernel.org
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
 <20220818135204.49878-3-zhujia.zj@bytedance.com>
 <4fbf60f5-4ed1-3dd8-e4d3-de796e701956@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <4fbf60f5-4ed1-3dd8-e4d3-de796e701956@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/10/8 17:06, JeffleXu 写道:
> 
> 
> On 8/18/22 9:52 PM, Jia Zhu wrote:
> 
>>   /*
>>    * Backing file state.
>>    */
>> @@ -67,8 +73,7 @@ struct cachefiles_object {
>>   	unsigned long			flags;
>>   #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
>>   #ifdef CONFIG_CACHEFILES_ONDEMAND
>> -	int				ondemand_id;
>> -	enum cachefiles_object_state	state;
>> +	void				*private;
>>   #endif
>>   };
> 
> Personally I would prefer
> 
> 	struct cachefiles_object {
> 		...
> 	#ifdef CONFIG_CACHEFILES_ONDEMAND
> 		struct cachefiles_ondemand_info *private;
> 	#endif
> 	}
> 
> and
> 
>> @@ -88,6 +93,7 @@ void cachefiles_put_object(struct cachefiles_object
> *object,
>>   		ASSERTCMP(object->file, ==, NULL);
>>
>>   		kfree(object->d_name);
>> + #ifdef CONFIG_CACHEFILES_ONDEMAND
>> +		kfree(object->private);
>> + #endif
>>
>>   		cache = object->volume->cache->cache;
>>   		fscache_put_cookie(object->cookie,
> 
> so that we can get rid of CACHEFILES_ONDEMAND_OBJINFO() stuff, to make
> the code more readable.
Hi JingBo. Thanks for your review. I'll revise it in next version.
> 
> 
> 
