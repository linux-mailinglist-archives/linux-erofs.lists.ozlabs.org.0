Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A73D5F8A74
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Oct 2022 11:52:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MlcmC6P42z3cjY
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Oct 2022 20:52:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=5X6uW2V+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=5X6uW2V+;
	dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mlcm82FZdz30NN
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Oct 2022 20:52:40 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so8158271pgs.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 09 Oct 2022 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSVDnAgp4oFS6GtK5rwH8v4//Iq76mLV9/G+ci+5hkU=;
        b=5X6uW2V+efbPbpyDNO3HlTgh8q1X5rnRaOc6ctfh4Nyq+P+npywuh1EOO5ouC2B8Pj
         S//KvKWa8t5eAgr4fmtMzJBmpY27L5ZomycvSDcVYpkoDjD4DkKEaGBQhHXrpvlpTJf+
         /vywDKTauGCQoTz02QOGcT95fyWQEQMOVMp9BfI8nD+HDUnp8CBQ6a4V/zqSPqpUe9eQ
         Ih3Bnk4n+7voDmxcf/d+fCO9EnGN6uOlOe1K0oGr7j0ePkR5XiTBTB8h4AegVlCAkUmx
         CSr3ILx2UbazKdN2vbowNDI43x6gdknGrj1pO4/hL+yfEeK3vdle+o6mDaea1gxUZwlN
         vYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vSVDnAgp4oFS6GtK5rwH8v4//Iq76mLV9/G+ci+5hkU=;
        b=ZeVqNFG1JV4nHD25F/S4IHZfnpcdT+kKCl/OrdzzUB3ECqWjAAvJcWeddKS4XkwzSC
         kyMG34t0B7CpEHrgrAamMefWe04ZyLWFeoTkcfFtBzJV9G2u3OFEncuXQRIVdu9AbyCu
         t3uZRPAu62UUSJ88cKo6JderQZqPMVbFPjt+ieTqF1O/3735i2PFHx6oWe5nFqs+YKYB
         lS7NYuewIVPGAD7dU1UYZUbXV9BBjtUfSinuuLLdKhtI5cQVav8HgqtGPHidXTLI4gNh
         /HHqNObPlp78UODD4QCyXwvn74mb+uX8HBOVkaexmz7gmE4tiqLn2YlGMiWzyn3tIa46
         JMGg==
X-Gm-Message-State: ACrzQf1qeqE53lNcdS7VRScVgrlMXCEtCZjWTyXtLtoHY4Z6E24Fchz8
	WHqf+hSR/+mZtxbM0eOeMuYbbQ==
X-Google-Smtp-Source: AMsMyM7IzOZu1tCczAGU+xbSMs7nJWyuEw0Ic2cn/6a4gM+q7tFnu7M34AMMxZfdqitGv9f1oFrLDg==
X-Received: by 2002:a65:44c1:0:b0:428:ab8f:62dd with SMTP id g1-20020a6544c1000000b00428ab8f62ddmr11994518pgs.211.1665309157196;
        Sun, 09 Oct 2022 02:52:37 -0700 (PDT)
Received: from [10.3.156.122] ([63.216.146.187])
        by smtp.gmail.com with ESMTPSA id c82-20020a624e55000000b0056265011136sm4678686pfb.112.2022.10.09.02.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 02:52:36 -0700 (PDT)
Message-ID: <bdbf258d-096c-4c44-c195-0ecff7504a32@bytedance.com>
Date: Sun, 9 Oct 2022 17:52:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [External] Re: [RFC PATCH 5/5] cachefiles: add restore command to
 recover inflight ondemand read requests
To: JeffleXu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 xiang@kernel.org
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
 <20220818135204.49878-6-zhujia.zj@bytedance.com>
 <514c06f7-017d-bca5-6a87-0dae54c0d83d@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <514c06f7-017d-bca5-6a87-0dae54c0d83d@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/10/8 17:00, JeffleXu 写道:
> 
> 
> On 8/18/22 9:52 PM, Jia Zhu wrote:
>> Previously, in ondemand read scenario, if the anonymous fd was closed by
>> user daemon, inflight and subsequent read requests would return EIO.
>> As long as the device connection is not released, user daemon can hold
>> and restore inflight requests by setting the request flag to
>> CACHEFILES_REQ_NEW.
>>
>> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
>> ---
>>   fs/cachefiles/daemon.c   |  1 +
>>   fs/cachefiles/internal.h |  3 +++
>>   fs/cachefiles/ondemand.c | 23 +++++++++++++++++++++++
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
>> index c74bd1f4ecf5..014369266cb2 100644
>> --- a/fs/cachefiles/daemon.c
>> +++ b/fs/cachefiles/daemon.c
>> @@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
>>   	{ "tag",	cachefiles_daemon_tag		},
>>   #ifdef CONFIG_CACHEFILES_ONDEMAND
>>   	{ "copen",	cachefiles_ondemand_copen	},
>> +	{ "restore",	cachefiles_ondemand_restore	},
>>   #endif
>>   	{ "",		NULL				}
>>   };
>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>> index b4af67f1cbd6..d504c61a5f03 100644
>> --- a/fs/cachefiles/internal.h
>> +++ b/fs/cachefiles/internal.h
>> @@ -303,6 +303,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
>>   				     char *args);
>>   
>> +extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
>> +					char *args);
>> +
>>   extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
>>   extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
>>   
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 79ffb19380cd..5b1c447da976 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -178,6 +178,29 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   	return ret;
>>   }
>>   
>> +int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
>> +{
>> +	struct cachefiles_req *req;
>> +
>> +	XA_STATE(xas, &cache->reqs, 0);
>> +
>> +	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>> +		return -EOPNOTSUPP;
>> +
>> +	/*
>> +	 * Search the requests which being processed before
>> +	 * the user daemon crashed.
>> +	 * Set the CACHEFILES_REQ_NEW flag and user daemon will reprocess it.
>> +	 */
> 
> The comment can be improved as:
> 
> 	Reset the requests to CACHEFILES_REQ_NEW state, so that the
>          requests have been processed halfway before the crash of the
>          user daemon could be reprocessed after the recovery.
> 
Thanks, I'll apply it.
> 
>> +	xas_lock(&xas);
>> +	xas_for_each(&xas, req, ULONG_MAX)
>> +		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
>> +	xas_unlock(&xas);
>> +
>> +	wake_up_all(&cache->daemon_pollwq);
>> +	return 0;
>> +}
>> +
>>   static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   {
>>   	struct cachefiles_object *object;
> 
