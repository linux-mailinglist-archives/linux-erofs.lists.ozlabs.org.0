Return-Path: <linux-erofs+bounces-539-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 79388AFB255
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Jul 2025 13:34:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbMZp17H6z30WF;
	Mon,  7 Jul 2025 21:34:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751888050;
	cv=none; b=cBdmQ4PVdvLviajihsAIwyDeNfXBhbTZpbPVbkUNb0a8j/syuHSHmaRt+Gt0oL504p9OlVNgp1wD0qtgVDEtpVLKCdBkZQD+EEY19zSXx8683saQGESHH6ufZo+z2VypQUX+u/aQth37VE5n6hLsQcMmdd79W4J5Ur2WVQrhq6vizTv+VreY7OGAWgvvtlQnn4FriHR/IGE470X7/IOCGWvv7YzyyOozFJ5IU3cwZMhtx0Ng5JPQ7bCn7B7HnbokJvaY1b/6jEQsiWv34u8o6bacRB16VmSFus/Bc0n2L6FdvlrlqeTPr+ug3qruEg5xDLGxK7LwZyhO8OU/ZmUqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751888050; c=relaxed/relaxed;
	bh=uBdpiyc+2d429rDFYCZo5jGAK67BFk1kVNL8eKXs99c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9q+E2SKkL5ICjsFw7YemVlLllnIdKJVnfssiL92PNvW9c5ocXzRr2d65Pqzkmxkc1YNoeq1W951Qa1wjUJ/d2qpbwV8DNOowK71neXNaQHwdUR02bepraZDMbb8enaXaTCglrTjrRLXGMJYv7A/9kXJFANVAoGMROHYIVqPw4NTjNimLAmPm9yER57+xBi5uz+fP7VuDz4zFY8iIecCFEVdHF96L6t/962JPKvlFedhpzViWi7CA1WDc7NSLmK7sVMdxzGNodK5StuggrvkFZOVAgQ0mXYKaNvpc1cxweOlbjZVE8yzVWGcO/HOmYitKV3EddonFWJ6dnZ5ST7tcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Iu6z4J3G; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Iu6z4J3G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbMZm0Ymwz30Vs
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Jul 2025 21:34:06 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751888042; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uBdpiyc+2d429rDFYCZo5jGAK67BFk1kVNL8eKXs99c=;
	b=Iu6z4J3GrWl5VSAYOI4oTn5U+Fos18LVYw8MScJUF/5lm0SQWQtDautId19rwdLNOJvgI+jpxzBA7Z6Pd+gpPimTBi9f5Cqu+r7hwaaU8Qkyxn96vlh/hFQlNXBc3Fb8HsgFtvfmsFIa+qmMgqmrI4ePlyHrOkWlFdwt2KREb8o=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wi7a3Js_1751888039 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Jul 2025 19:34:00 +0800
Message-ID: <f2b5d473-7ca0-4800-bcd7-0049fcd9b717@linux.alibaba.com>
Date: Mon, 7 Jul 2025 19:33:59 +0800
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
Subject: Re: [PATCH] erofs: fix to add missing tracepoint in erofs_readahead()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250707084832.2725677-1-chao@kernel.org>
 <c911e159-d216-4b0f-865b-f4524e6f8f0f@linux.alibaba.com>
 <0b45c2d9-a610-4839-baa6-75041a6c37d5@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0b45c2d9-a610-4839-baa6-75041a6c37d5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/7 19:22, Chao Yu wrote:
> On 7/7/25 18:17, Gao Xiang wrote:
>>
>>
>> On 2025/7/7 16:48, Chao Yu wrote:
>>> Commit 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
>>> converts to use iomap interface, it removed trace_erofs_readahead()
>>> tracepoint in the meantime, let's add it back.
>>>
>>> Fixes: 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
>>
>> Thanks Chao, btw, should we add tracepoint to erofs_read_folio() too?
> 
> Xiang, I guess it is useful for debug if we can add it, let me figure out
> a patch for that?

Yes, it's up to you if you'd like to submit anothe patch for this.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

