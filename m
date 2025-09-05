Return-Path: <linux-erofs+bounces-978-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B98B44DDE
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Sep 2025 08:19:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJ5lb6L7cz30g6;
	Fri,  5 Sep 2025 16:19:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757053147;
	cv=none; b=mhgN/MdOQcZDXUTwMs/ej8Er6Lwb0UzRwwutlf/vqzZtHfL/RZad3+D4UTv92Acd1s33XVGFv5wu68bBlx3EKDQUBrt1IRj9BmSUlnF4a34v6jyItfoOQ0TZSYy8KRIHCHxLM1iSK98EvAm52anoz8SO+PCUoGNBeon+8lYNSthT3e5Kw3U7whh1czJS1IOx2yzHzbVfMTSqOs4NAT6Kk/lYQmuhI/lPcC2Ne5kk6im9nITicp+Mu5cXSwsdsOByUGbkM5hjafCtD8LGUo5EBw4QWNTXEF0RD0xE8QDoo0eP2p4p86Qy1wkYEAcyDTYGSMDlXt4F4kVouSaPDLKQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757053147; c=relaxed/relaxed;
	bh=+BChJki8313PYJIvhHHDEXid+okh67CTOkV77NCf6xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLmTEyiSnBUPgtcDhvURaA0Z9F3Jw0mDmUZs54XOmW11dWhkzNC3yg12OPuGDZklk11L51jrjw7ivVuet6ycODBIH5SdNzDAhuYQc7596/CzOHRs0gpxN76gycz9U1/Xxz4UvCJscl4DID8JJ8GuIimsXvGd4hqTKToOETslyHwmDHVzoK+I19VfMN1xy7tjnrc4YxltYics50S+69ejwtlfLoZx83jpgQA85r+nzOFTD/gxuuOE99lNakrbY7ZOG7OkvRu6h5GP0euWCOEz37DwtoBwgobNMQ+b9IgGqrn7wGhU82Y5+sNhIzfYGx//REgxPWeGiT+YGvVS3D8JsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kH4SYUu1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kH4SYUu1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJ5lZ0tnmz301n
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Sep 2025 16:19:04 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757053140; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+BChJki8313PYJIvhHHDEXid+okh67CTOkV77NCf6xQ=;
	b=kH4SYUu1V4duu5ymFU1Y/RUSvK4T4CSbC1KKkhcbYzwUKNLSIYbExuu2BpsTf6riVZd6W2MwAoeZsVmSqsz1IbM3yf7+0fFHXloxPQY44M+aHgI1cXpKj6PuOQ2HvweZSDvV/ySapOKkcxtzGHmnYfmMACH1nS35jUXvuI9jURM=
Received: from 30.221.131.209(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnJRVPd_1757053139 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 14:18:59 +0800
Message-ID: <35ff44b3-0b4f-41e1-ab22-92c2c4c507dc@linux.alibaba.com>
Date: Fri, 5 Sep 2025 14:18:57 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: avoid trailing '\n' in
 erofs_nbd_get_identifier()
To: hudsonZhu <hudson@cyzhu.com>
Cc: linux-erofs@lists.ozlabs.org
References: <20250905033955.1351125-1-hsiangkao@linux.alibaba.com>
 <A170109A-3EFF-4CE0-8AB2-EC65536A08C8@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <A170109A-3EFF-4CE0-8AB2-EC65536A08C8@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/5 14:12, hudsonZhu wrote:
> I have tested this patch and it can fix the autoclear issue when executing `mount.erofs -t erofs.nbd erofs.img /mnt`.
> 
> Nice patch, Xiang.

Could you share your Tested-by: on this patch?

e.g.
Tested-by: Chengyu Zhu <hudson@cyzhu.com>

Thanks,
Gao Xiang

