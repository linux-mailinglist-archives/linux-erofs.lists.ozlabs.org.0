Return-Path: <linux-erofs+bounces-849-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC4B2EB0A
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 04:00:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6mkL1F1mz30RK;
	Thu, 21 Aug 2025 12:00:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755741642;
	cv=none; b=B6S8V5cVPpZZtCPQtWW1p36fHtTfO08TYqChdrmzbt/nbQRtHtTG7RidjNOor7iave8KugyiPywOygkHfHYNR/+IEyNQrdE7oznM6J4+j5hla6Jn0QN0gacNWrOW76Lik3y2+wLN7ylLSHGwxrSjl1Mu4UIkG4WNZ3Wv5ptSb4I0NY4dVyrp1FheOxMXK4W8qNGSq4GgnCEzLAe2DnRAvGc/b0RqL/v3wenc4bkq+0etPbr9l/gW5R0Cx7B5iYTTTVAVqMs5ZoSmjSGHS0AzPfTWm88wXjLqRGNZOVK6CJd2WOo/FbY4Mx/exHjvqdWhErn5EAGEujhzFaaCiF6W3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755741642; c=relaxed/relaxed;
	bh=IaH1lJAtuLb04gPwJ8JH8ZhvGnRp3RmJF/1ZzxB7K5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDs0f5kbziK3VFPAneFbox8ervestrLvBk9nDL0eSxlvaxzRHmb+8L9bjXnb0qRwxoMqTGWv2xCQREiahTeOefnX3LE+wkPzdcUelfVKXxOjji5KonhT7S6j6Lfho7JqXVa9ZMgoY5T6kWwaFpib6rZ6HYTxMfJNo/3Q9hrp8SNEtNO6koKJyhKD+hZIvT96mqeqlwMpfRgldG9qs9sXFZdUV0xfWuSCYgK3witoDE7G2NN7JJ3usBMVarH2bU4sl5/YpYv+jTMSNYPyvI4k/49J9fVDXYKpTphC3QjdJcRJO1fg9gZ4MxKm6fnF0KVNNRoZROkpB6h2n0hbKjsRFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fCxIAFWk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fCxIAFWk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6mkJ2c3Jz2xnM
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 12:00:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755741634; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IaH1lJAtuLb04gPwJ8JH8ZhvGnRp3RmJF/1ZzxB7K5I=;
	b=fCxIAFWkmIb9AmBGoZOV+JErMMuWFq7KR1hWlS0hM325fm1gX8kYDWDwpGQq2bQ78Do4Jzj4XEd8tDFhJhJHgz6mPn42AT3hipvCH32s4loligkPx8//XWs7L49Mp0CWJO1oDbBqNe/NU+fIBckiS+cIsr9BLMk/87Ab/2xklVA=
Received: from 30.221.130.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmE-nJN_1755741632 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 10:00:33 +0800
Message-ID: <96d466e7-eb96-48b7-bd89-b67381737b4b@linux.alibaba.com>
Date: Thu, 21 Aug 2025 10:00:32 +0800
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
Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
To: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
References: <20250820072352.4151620-1-friendy.su@sony.com>
 <39f81655-8bef-428c-843b-b57c9e50c90d@linux.alibaba.com>
 <TY0PR04MB61910F716A77A3E6F0F8FE43FD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <5be2a340-acbc-4ce9-8bb6-1bfb91562944@linux.alibaba.com>
 <TY0PR04MB61914EA9FEB78ACA041F59CBFD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <TY0PR04MB61914EA9FEB78ACA041F59CBFD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/20 17:38, Friendy.Su@sony.com wrote:
> Hi, Gao,
> 
>> What's your `--chunksize` ? consider the following:
> 
>    chunksize = 4096
>    dsunit = 512 = 2M
> 
>> and two inodes:
> 
>> inode A (8k)    2M, 2M+4k
> 
>> inode B (12k)   4M, 2M, 4M+4k, 4M+8k?
> 
>> Is it possible? what's the expected behavior of
>> this case.
> 
> Yes. This is the expected behavior. See runtime below:

I understand that is the expected behavior according to this
patch, but I'm just unsure if it's an expected behavior for
the future wider setups (because some users may use `--dsunit`
for other usage).

So I tend to just constrain the case to your limited case
first, could you explain more if chunk deduplication is
needed for your scenarios? and what's your real `chunksize`?

Maybe adding another command option for this is better.

Thanks,
Gao Xiang

