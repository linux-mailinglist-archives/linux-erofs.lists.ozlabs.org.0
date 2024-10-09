Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7904899727A
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 18:57:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNzbD1STTz3bdX
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 03:57:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728493063;
	cv=none; b=Yq78tT/huAEvbJqUD+/G5h6yjex3SPEV/o2cMVE2cYNc3TZOLjb6xlKrZCZ5NHVi35bLC2oirRMIIGKLQq9ZPY+tP26Ov05E/Np/D0F9Ft/1LHc7RvQ+WQT/P9qZm9/ifJ5JtlSUl7VxcQuOxTCwQPeA6jBmpJpzhoMxFimkLvH8x9I64g+JltwSnOpBEIZjnRLkoDCURL6/8iJEHLOk/PNPSX9goD0i/NFQ22Fvrnn6tMtSmZKh9T1vsNTjvoMUBIf2y2mlSAi9x221J5OQn2NbGmpiY8O3vSa4fAq6jsxf18D3Eal14ecOBOYnwdz6NDyoIcU4PTBf7eiMMO+i2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728493063; c=relaxed/relaxed;
	bh=ORzfNt9VkzdEGnE1FeMIA05Qm7yBuvqlTlcI1zkx72I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lgG4vwqhCWoXXJVwTs2x2oaQrXCj4WREd7BBUq/rPB9I/MI3WpwCPFvJ49h1cy+U9AfOAnA5xx6e0cv7WDSoX2H/TkUUGNNPQuvvHvFFj/GdmG+lXvAYQc4wa3E+zNozIEO1dCw4kgaqnE06fGS+q7j1lmVBcx26Ze8AVm7NCOIVVtCCC97ega+5o5zCo7ijGlNC+v6Jrly6Xn9fhV99JwdDG/rjNXE1FNdMpmJ/zggJ9lK4yBSvlIpvB/4dxlBe2ouQ7MKYeE8rDcbqwYa8mXIyrENImritIrAtQ7y8WuUriYpVW1R0XUMU5dOI1WfVITFe/KpuJFniw5zS9FrZyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HpPCD8/B; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HpPCD8/B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNzb332FHz2yQL
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 03:57:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728493049; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=ORzfNt9VkzdEGnE1FeMIA05Qm7yBuvqlTlcI1zkx72I=;
	b=HpPCD8/BTgLvU8aFW9OgLWsuqrZmLjKeJMPGQNWSRQfYIO8lvFp9qA6rr5mnw5V7pkoDUxPMmxVNDUSr3KGHOSdFNrsXJ3n8G7Vfn5ry3tQunOh1Dt4fxzLND/uhgVHepNM0jtbV8bAYLslO2fDJxnxKtg/9eqkg6TxCiUDmnV0=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGjbNX._1728493046)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 00:57:27 +0800
Message-ID: <8ec1896f-93da-4eca-ab69-8ae9d1645181@linux.alibaba.com>
Date: Thu, 10 Oct 2024 00:57:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] erofs: use get_tree_bdev_flags() to avoid
 misleading messages
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241009033151.2334888-2-hsiangkao@linux.alibaba.com>
 <ZwYxVcvyjJR_FM0U@infradead.org>
 <8a40d27c-28f1-467b-9a9e-359b36ee5e33@linux.alibaba.com>
In-Reply-To: <8a40d27c-28f1-467b-9a9e-359b36ee5e33@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/9 15:37, Gao Xiang wrote:
> Hi Christoph,
> 

...

>>>
>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>> index 666873f745da..b89836a8760d 100644
>>> --- a/fs/erofs/super.c
>>> +++ b/fs/erofs/super.c
>>> @@ -705,7 +705,9 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>>>       if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>>>           return get_tree_nodev(fc, erofs_fc_fill_super);
>>> -    ret = get_tree_bdev(fc, erofs_fc_fill_super);
>>> +    ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
>>> +        IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
>>> +            GET_TREE_BDEV_QUIET_LOOKUP : 0);
>>
>> Why not pass it unconditionally and provide your own more useful
>> error message at the end of the function if you could not find any
>> source?
> 
> My own (potential) concern is that if CONFIG_EROFS_FS_BACKED_BY_FILE
> is off, EROFS should just behave as other pure bdev fses since I'm
> not sure if some userspace program really relies on
> "Can't lookup blockdev" behavior.
> 
> .. Yet that is just my own potential worry anyway.

Many thanks all for the review... So I guess it sounds fine?



Hi Christian,

If they also look good to you, since it's a VFS change,
if possible, could you apply these two patches through
the VFS tree for this cycle?  There is a redundant blank
line removal in the first patch, I guess you could help
adjust or I need to submit another version?

I also have another related fix in erofs tree to address
a syzbot issue
https://lore.kernel.org/r/20240917130803.32418-1-hsiangkao@linux.alibaba.com

but it shouldn't cause any conflict with the second
patch though..

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 

