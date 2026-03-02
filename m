Return-Path: <linux-erofs+bounces-2464-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOYjInKwpWkiEgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2464-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 16:44:50 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E821DC161
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 16:44:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPjt65hfcz3bmk;
	Tue, 03 Mar 2026 02:44:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772466286;
	cv=none; b=if5fq6PV/xUf1hm/dG2M7+zn0bLNvmH2Kn3H9+QCZJ/hMCYqL6UNMALdxm0ioxXgeF2qhfEXR27qaY7OyHWEc7GLUKeOFC2GNa93soXEjaSKFNyPSTD/RUznqIOa0VGOZhKHqqoHsuLonpPpPWjh8f7T10KNPcA19KunZLVR3ntOnB1Pj+1hwB4yqmSjKtq3f9/QllKg/Pf1xdVphUuqeg7TWttwaH210XAqJEios2+9CvOsGVkVvvv3wN+Dyd9EAsDxsnIIuMnZrhIzlKzPTzz+MeSlaAG3t3mSuN97X5wh9n1VIsp72VbvJkLooFXDBWwoP1JtszuX4TNhs+XD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772466286; c=relaxed/relaxed;
	bh=wj0w/xQh5o6IBz0DZYCCjc0ms03BW6MfdL9PvHTJvFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6oLZEsCh7xreqpNS2OMvp0aVN76tb9vW+dRVQPKAfZcjd0sWAJXvhyVpiIRBUo72KKWeHjcVS1/70bXWyLkRntA3PQ5gSqdlQvC6mHe49uaRoP69Tuc7m6iS4t5VoL/0ZtVEs8PPUgS2edjCLfxKVRx3kDQslcsvJ93MMttjdc2s1IgfFDng56JIU7VEDge0Tb2nacm6NMtH/Tk1jeSJfkN+WR7UnYYzyU55rxNSqaJqJuIyvV+ujd9ozFaLK69+5I+r0I65LXglcKBHTQxN+3B9NaZulM+IS6ldYPt/ZJsX5Gzhag7DQl/ehmx0L60h5x9wuVEL7GNhQpFnOZjDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DhTOfff8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DhTOfff8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPjt459T5z3bmc
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 02:44:43 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772466279; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wj0w/xQh5o6IBz0DZYCCjc0ms03BW6MfdL9PvHTJvFs=;
	b=DhTOfff8HMl8GVuNdzv4s7edU9imMZKG6oyg18M08VA724N9NmRoFt30LGY4pF486TGtaxJgFgSn8IBFHfsMiQ23mmmIP3pUMjz8+zYd1NUUiHbgPjVivvERm0vp1m/XrRRFnV947Q06xYR6ZMysCZbmIdV7gW+9RkBA+U7Bntc=
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-6HSno_1772466276 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 23:44:37 +0800
Message-ID: <e5ad170a-f443-48a1-9d8a-d8a0cef5a27a@linux.alibaba.com>
Date: Mon, 2 Mar 2026 23:44:36 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: fix xattr crash in rebuild path when
 source has xattr
To: Lucas Karpinski <lkarpinski@nvidia.com>, lishixian
 <lishixian8@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: qinbinjuan@huawei.com, caihaomin@huawei.com, caihe@huawei.com,
 wayne.ma@huawei.com, zhukeqian1@huawei.com, jingrui@huawei.com,
 zhaoyifan28@huawei.com
References: <20260302130356.769479-1-lishixian8@huawei.com>
 <f9c910ae-a713-4c85-80bf-e79ca6386f83@nvidia.com>
 <f1d6133d-e1e2-44a4-9a58-01a917c6e114@linux.alibaba.com>
 <2ac49ff4-7177-435d-8b0a-837dd8705b4b@nvidia.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2ac49ff4-7177-435d-8b0a-837dd8705b4b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 70E821DC161
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2464-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lkarpinski@nvidia.com,m:lishixian8@huawei.com,m:linux-erofs@lists.ozlabs.org,m:qinbinjuan@huawei.com,m:caihaomin@huawei.com,m:caihe@huawei.com,m:wayne.ma@huawei.com,m:zhukeqian1@huawei.com,m:jingrui@huawei.com,m:zhaoyifan28@huawei.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,nvidia.com:email,qq.com:email,inode.sbi:url,huawei.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action



On 2026/3/2 23:39, Lucas Karpinski wrote:
> On 2026-03-02 10:28 a.m., Gao Xiang wrote:
>> Hi Lucas,
>>
>> On 2026/3/2 23:22, Lucas Karpinski wrote:
>>> On 2026-03-02 8:03 a.m., lishixian wrote:
>>>> When rebuilding from source EROFS images, erofs_read_xattrs_from_disk()
>>>> is called for inodes that have xattr. At that point inode->sbi points to
>>>> the source image's sbi, which is opened read-only and never gets
>>>> erofs_xattr_init(), so sbi->xamgr is NULL. get_xattritem(sbi) then
>>>> dereferences xamgr and crashes with SIGSEGV.
>>>>
>>>> Fix by using the build target's xamgr when initializing src's sbi.
>>>>
>>>> Reported-by: Yixiao Chen <489679970@qq.com>
>>>> Fixes: https://github.com/erofs/erofs-utils/issues/42
>>>> Signed-off-by: lishixian <lishixian8@huawei.com>
>>>> Reviewed-by: Yifan Zhao <zhaoyifan28@huawei.com>
>>>> ---
>>>>    lib/rebuild.c | 1 +
>>>>    mkfs/main.c   | 1 +
>>>>    2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/lib/rebuild.c b/lib/rebuild.c
>>>> index f89a17c..f1e79c1 100644
>>>> --- a/lib/rebuild.c
>>>> +++ b/lib/rebuild.c
>>>> @@ -437,6 +437,7 @@ int erofs_rebuild_load_tree(struct erofs_inode
>>>> *root, struct erofs_sb_info *sbi,
>>>>            erofs_err("failed to read superblock of %s", fsid);
>>>>            return ret;
>>>>        }
>>>> +    sbi->xamgr = g_sbi.xamgr;
>>>>          inode.nid = sbi->root_nid;
>>>>        inode.sbi = sbi;
>>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>>> index b84d1b4..cb0f0cc 100644
>>>> --- a/mkfs/main.c
>>>> +++ b/mkfs/main.c
>>>> @@ -1011,6 +1011,7 @@ static void erofs_rebuild_cleanup(void)
>>>>          list_for_each_entry_safe(src, n, &rebuild_src_list, list) {
>>>>            list_del(&src->list);
>>>> +        src->xamgr = NULL; /* borrowed from g_sbi, do not free */
>>>>            erofs_put_super(src);
>>>>            erofs_dev_close(src);
>>>>            free(src);
>>>
>>> I was similarly looking at this issue in my patchset so I can confirm it
>>> fixes the seg fault.
>>>
>>> Tested-by: Lucas Karpinski <lkarpinski@nvidia.com>
>>
>> Thanks for this, but as I said to lishixian we shouldn't use
>> global g_sbi in the liberofs anymore.
>>
>> Could we try to assign sbi->xamgr in the caller instead?
>>
>> And
>>
>>> in my patchset
>>
>> Do you have more urgent fixes? I'm about to release
>> erofs-utils 1.9.1 since there are some urgent fixes
>> so fixes would be better to be sent out now.
>>
>> Also I think we should have a basic testcase to cover
>> this, I will try to add one this week.
>>
>> Thanks,
>> Gao Xiang
>>
> Sorry, responded at the same time and didn't get to see your message first.
> 
> The rest of my changes are for a new feature implementation, so nothing
> urgent in that regard.

Okay, if you have any question about rebuilding feel
free to ask.

Sorry about that but my own TODO queue is full but I try to
answer any question if helps.

Thanks,
Gao Xiang

