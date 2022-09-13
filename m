Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD165B66FD
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 06:36:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRVyw2x7Bz308w
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 14:36:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=HnvnR19M;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=HnvnR19M;
	dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRVys3r6Dz2xfs
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 14:36:05 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id c198so10583396pfc.13
        for <linux-erofs@lists.ozlabs.org>; Mon, 12 Sep 2022 21:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=9SHXWUEc8+WV+LeDXW4eEXPOgYcfsNmtwn8kPQPqdbs=;
        b=HnvnR19MbXdptGwdmVxul13UFRyv+ZEuSS++a2VHlPbeX4OF4fXegWzIhzw47jbPVL
         MB6svwYYkTXR7N52HdU6FZFYQahbZeblPiLxgVQsHtuVY+cJ9CDRVbZnyKM5AKRmGin9
         pCsvDi2+PXYqTC8WSDJhaNWsxZDQf4LwjvYkub4vkoTzhR6xH9JZU/2M7AfbL0/OyLko
         bUzemPU91bzcyMQrRQSSZu/EQQ+113/xMwZzRxni4Gq8xflL47ZUlzFGciheY1W4NUXl
         8kBtNJc6AAbC88oSNcGZIHba96aDmbzA57uGzWxLYvuCgGje7pGEvKJSkI5/XS/WKLyx
         R04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=9SHXWUEc8+WV+LeDXW4eEXPOgYcfsNmtwn8kPQPqdbs=;
        b=tdxvHcLYKGPLDXdlV+AykqiEi6FKflJx6E7WCHHK5H9a1xjabsd1Tcmo3qdVoxq13V
         Yc6Skf5Gbks6KvWDytux5G3lTgzFi4QZvSd2pRHr970CZ5dki8HqtPafccVj6a3bAmRI
         LEgZ9mnOB1KbaIraOYdZEZ35nJfkm5SeiVt1aIdxiTg7/rlU9tthRdOu1cswFXhzzdoc
         3piP7a1SpOtmmyHQ5g8xGWvxnsYbUps8e3kPM+N6zK88UVVpzg2+yvXqjb3N401JWW7B
         42v+dX+Bjg7Nb72M2UaYov9OWj7ORpxPC30F6n5c3l9/W3plERAk20u6OTt9PcId8Eax
         Mubw==
X-Gm-Message-State: ACgBeo09LRCuaUvbIZNXCzOuuQ4rpIxYO7UpME+zvB6XYTGQkNtg43PZ
	sf3gmFS+PYRgTXr0PkQjcJnZCQ==
X-Google-Smtp-Source: AA6agR7RN4cIMrcl8WzVnYh07kBxd96P6zBiy+X6KQEm24uwTXoJnN6+fYILdgi8BTKG0Fc+F3HHvA==
X-Received: by 2002:aa7:9247:0:b0:544:6566:8ba0 with SMTP id 7-20020aa79247000000b0054465668ba0mr6638777pfp.11.1663043762194;
        Mon, 12 Sep 2022 21:36:02 -0700 (PDT)
Received: from [10.76.37.214] ([114.251.196.101])
        by smtp.gmail.com with ESMTPSA id s129-20020a625e87000000b00537b1aa9191sm6696654pfb.178.2022.09.12.21.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 21:36:01 -0700 (PDT)
Message-ID: <babdb60b-227a-ac37-8fda-367556987c3f@bytedance.com>
Date: Tue, 13 Sep 2022 12:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V2 3/5] erofs: add 'domain_id' prefix when
 register sysfs
To: JeffleXu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-4-zhujia.zj@bytedance.com>
 <539dcc26-a250-5bf4-0f3c-a3f7cdc2ce48@linux.alibaba.com>
 <fc63c7ed-bffe-4127-7622-a7ce0c4b4378@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <fc63c7ed-bffe-4127-7622-a7ce0c4b4378@linux.alibaba.com>
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



在 2022/9/9 17:26, JeffleXu 写道:
> 
> 
> On 9/9/22 5:23 PM, JeffleXu wrote:
>>
>>
>> On 9/2/22 6:53 PM, Jia Zhu wrote:
>>> In shared domain mount procedure, add 'domain_id' prefix to register
>>> sysfs entry. Thus we could distinguish mounts that don't use shared
>>> domain.
>>>
>>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>>> ---
>>>   fs/erofs/sysfs.c | 11 ++++++++++-
>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>>> index c1383e508bbe..c0031d7bd817 100644
>>> --- a/fs/erofs/sysfs.c
>>> +++ b/fs/erofs/sysfs.c
>>> @@ -201,12 +201,21 @@ static struct kobject erofs_feat = {
>>>   int erofs_register_sysfs(struct super_block *sb)
>>>   {
>>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>> +	char *name = NULL;
>>>   	int err;
>>>   
>>> +	if (erofs_is_fscache_mode(sb)) {
>>> +		name = kasprintf(GFP_KERNEL, "%s%s%s", sbi->opt.domain_id ?
>>> +				sbi->opt.domain_id : "", sbi->opt.domain_id ? "," : "",
>>> +				sbi->opt.fsid);
>>> +		if (!name)
>>> +			return -ENOMEM;
>>> +	}
>>
>>
>> How about:
>>
>> name = erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id;
>> if (sbi->opt.domain_id) {
>> 	str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id, sbi->opt.fsid);
>> 	name = str;
>> }
> 
> Another choice:
> 
> if (erofs_is_fscache_mode(sb)) {
> 	if (sbi->opt.domain_id) {
> 		str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id, sbi->opt.fsid);
> 		name = str;
> 	} else {
> 		name = sbi->opt.fsid;
> 	}
> } else {
> 	name = sb->s_id;
> }
> 
> 
Thanks for your advise, this version looks more intuitive. I'll apply it
in next version.
> 
> 
>>
>>
>>>   	sbi->s_kobj.kset = &erofs_root;
>>>   	init_completion(&sbi->s_kobj_unregister);
>>>   	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
>>> -			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
>>> +			name ? name : sb->s_id);
>>
>> 	kobject_init_and_add(..., "%s", name);
>> 	kfree(str);
>>
>> though it's still not such straightforward...
>>
>> Any better idea?
>>
>>
>>> +	kfree(name);
>>>   	if (err)
>>>   		goto put_sb_kobj;
>>>   	return 0;
>>
> 
