Return-Path: <linux-erofs+bounces-1813-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D69ABD0D5B7
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 12:55:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dpHBz37q6z2yFq;
	Sat, 10 Jan 2026 22:55:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768046123;
	cv=none; b=hL77loNeUi0GkgTAGzttHIwBsTUQjCQ4IgieNcoe+SJ85VoCg++BUZCP32IkgTFJag1r7JbhpOdoS9GHaRd/940375R8H71X3Q1sv0iohQQCqEZVgyjT6NSu1tKzULftY+mTooPcPzQq40WWffq7b/zh4OSCkBPakVPiKsCVQm4wugI7kngdz64MZxyIWr+HIKA7OpCSLqhbdZqAPXxuwCGdvsMUfASdC8hH1cCvFQuZYx7ai8euiFZN03jzttZanAft2pPeBARCA7UfgCKnq6zbanYYiQho0J1W4enMR7/3kZF/u6ICHv4XuRO2nw5ARG9yg8GtWyCCWyyH56oErw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768046123; c=relaxed/relaxed;
	bh=erwwePJ+8II8k641PkE+2cYBtLxUw8inNwTyx6ghjKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfF1T7FObfiqJjhu8zTYJARA8Q1YQ83vAqnbhJTya/roW5iaEhvVAus+QfplvDI22OMqpfG1Y1abCURkHY8qAjSy6lFHhEZAqAaWJz8zyNjyL48suwfj5lc584iWglLZrMGO+mYG4rpWUMCp2dW7BefY/kWHARZOFoOlY3xNG0h7u4LpGWwco3BrmnjBSdiwef9uJS1YfYwki/y9iqxQaXfmQsP6KOZ8ti7kmtWy80i23H3jwh3d7zkQnfQOPwADydhjoZwpJ64wQkEWRKH3fG6OVVcF3603LtjiXl6yzdrV9Fi/Z7U6yL3ddsgDLDvKy895dIZVxIxTXqz2WVDn7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qzNjfeh2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qzNjfeh2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dpHBx5QbKz2yFk
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 22:55:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768046115; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=erwwePJ+8II8k641PkE+2cYBtLxUw8inNwTyx6ghjKM=;
	b=qzNjfeh2czhV2VtmlY4WcKqKFWeZjGK8srK0rYZmfsJRoRn7zj5EGzj61R2Twi8dbSyXwcTMzDY25QZwd/x+QUfM32kYOMQzQl6l6KvWkw2MzwJFQAov51JOhsV9LHrlfsU2ZCPwu7hAg8bvB4+QtxtF5kEqNe+WDRZBkgnDg0g=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwjsYtx_1768046113 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 10 Jan 2026 19:55:13 +0800
Message-ID: <e3e1f6e5-c4ac-4913-a41b-20edbc1d7a46@linux.alibaba.com>
Date: Sat, 10 Jan 2026 19:55:12 +0800
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
Subject: Re: [PATCH v14 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chao@kernel.org, brauner@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-2-lihongbo22@huawei.com>
 <20260109181442.GA15532@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109181442.GA15532@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Darrick,

On 2026/1/10 02:14, Darrick J. Wong wrote:
> On Fri, Jan 09, 2026 at 10:28:47AM +0000, Hongbo Li wrote:
>> It's useful to get filesystem-specific information using the
>> existing private field in the @iomap_iter passed to iomap_{begin,end}
>> for advanced usage for iomap buffered reads, which is much like the
>> current iomap DIO.
>>
>> For example, EROFS needs it to:
>>
>>   - implement an efficient page cache sharing feature, since iomap
>>     needs to apply to anon inode page cache but we'd like to get the
>>     backing inode/fs instead, so filesystem-specific private data is
>>     needed to keep such information;
>>
>>   - pass in both struct page * and void * for inline data to avoid
>>     kmap_to_page() usage (which is bogus).
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> This looks like a dead simple patch to allow iomap pagecache users to
> set iomap_iter::private, so no objections here:
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks for the review!

Thanks,
Gao Xiang

> 
> --D
> 

