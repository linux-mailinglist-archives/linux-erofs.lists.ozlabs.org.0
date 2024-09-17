Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C35097AC90
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 10:07:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7DsF5MrJz2yN1
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 18:07:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726560430;
	cv=none; b=DWbcCOs3sXyH1d981irxBZuLvKnwixYZuP/4rE8Ca/rvcBnVpNVUFRzFfkHLvihSABqL91MkMPYHfK5mgFLPu3f/CFvh4e13kWqlEoO8hCjRSP4nGO1ox/0WW5NjO5HC6fnG2TrcZIjQuVRu4pqBqv4FPfBS19cOsVEcLkoibn8YnvWtmZwZGkV7wfYWJFfklMnzlmPGVAe5IXm0itPYq5B8uFunqvUu6F8Yo/RFTvIDT5B4p8uc3BQzJGQNS12z0YMbvjklOISh4u9qUewpQCBoqeMLtXH7QBnQHh/xxIwY2FDnmiMmjoyjfTdxff7guMJK4y+V4b/gAqi6gxWiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726560430; c=relaxed/relaxed;
	bh=zD8A7S8NSOoYTS0UIC1YFPPNS2TblfcXM5xymSmNV04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ssu+nwh0cp0EjjZeDWSdtK1Oq/GMvedI76QOGsbJS1/iWOnkWGUCftbOzVMnkKtb29XtdDPhUPfOMK0yjoxG2LghnUrJuENT3MjXR8DgQ7fewYMRh/Lh/6BGFXyjU8SEfnALPXyzkNVIM+yjqTXE+MfM+aKRngOm33Qyg3R2J/v6akTCcorrtl3H3PNlNHCW7/1qSFIgaQXQWcsb7yYF/tfuNonxvBav9inZ04KHsavQZQJ+3NV2AybVDdWSIZhfDe0avnl3fDJTPkPVmwxlLINgGef9gi0JDLvQtwbrJRdfYiYzMp5ewLIZJYnG0dqzZIk1ehx61fjO+WrALf4BRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d+H2VHso; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d+H2VHso;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7Ds81MNkz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 18:07:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726560422; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zD8A7S8NSOoYTS0UIC1YFPPNS2TblfcXM5xymSmNV04=;
	b=d+H2VHso7gqLttcwhVqPO1QZ5SbKF9Dj/abm8/bnfq7Hmmo8HMnOLm+dcxHYKKiW7cr/x+Oe0If8kyXjIf+NMzXbnRvVN7D3jdE1CngMwwxl+I1rRbBswbNTgJHM4JXZ0qhlgn58PEVOy9oVqDTKrjOzi/+b3Mz1o2lAikaS8yU=
Received: from 30.244.95.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFARaTY_1726560417)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 16:06:59 +0800
Message-ID: <b39d430d-3ecb-4537-8d9c-9f0c50cefdf0@linux.alibaba.com>
Date: Tue, 17 Sep 2024 16:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
To: Al Viro <viro@zeniv.linux.org.uk>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc> <20240916170801.GO2825852@ZenIV>
 <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
 <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
 <20240917073149.GD3107530@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240917073149.GD3107530@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/17 15:31, Al Viro wrote:
> On Tue, Sep 17, 2024 at 03:14:58PM +0800, Gao Xiang wrote:
> 
>>> Sorry for my ignorance.
>>> I mean i just borrowed the code from the fs/erofs/namei.c and i directly
>>> translated that into Rust code. That might be a problem that also
>>> exists in original working C code.
>>
>> As for EROFS (an immutable fs), I think after d_splice_alias(), d_name is
>> still stable (since we don't have rename semantics likewise for now).
> 
> Even on corrupted images?  If you have two directories with entries that
> act as hardlinks to the same subdirectory, and keep hitting them on lookups,
> it will have to transplant the subtree between the parents.

Oh, I missed unexpected directory hardlink corrupted cases.

> 
>> But as the generic filesystem POV, d_name access is actually tricky under
>> RCU walk path indeed.
> 
> ->lookup() is never called in RCU mode.

I know, I just said d_name access is tricky in RCU walk.

->lookup() is for real lookup, not search dcache as fast cached lookup
in the RCU context.

Thanks,
Gao Xiang

