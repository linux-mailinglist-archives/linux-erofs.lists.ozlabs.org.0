Return-Path: <linux-erofs+bounces-1445-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4441EC9082D
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Nov 2025 02:41:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dHbbx6bprz2yG5;
	Fri, 28 Nov 2025 12:41:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764294061;
	cv=none; b=lf8+++ppcSPPqX7AivTsq4MvVNVShQXDziiMpdOfL32SkpeiwHWQxoHlXSAHq97SAXM9OOCm0PyR+h8VlZLwwAxVIYBSwJ/YkPJS+go9dR0HTYq7QpfOSSfaldQ6q2nEJrW2esbEgPacCyCGfk2HIEDg4UNIJmMFi57QWfnhfRDggjMA8skKbKQ+XDhWQ6LwtyRKPUysQ1D0Gp4vrm8qiziI91harsx3Sph4k5TXOGkUpOfY8MryiAsMgw33Ob1sf0jgA8slizrzQatZCu+l1Emu8TKVJj3+YwIfXNONGFcfxbXLcczPZEvRbX6pnYC+Oe2CN4brlKLlWl/Q2D2H4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764294061; c=relaxed/relaxed;
	bh=CpsoWGihg5zy3BeGFjBwgtw52Pr/CBr3dGHsUPYc2o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJJsKRV4/0F8NzFmo1FHEddp1KgTfrERzDHdj4pbFtOXFQxo6Yly9U62Ks0kNk+ElTABaH0TLzxY3IfiIyHwMjNn8JtoCwWp7L4g9fd9XwqI3yTyNs2xA3uJGjXYMe/WAb82IZ24qoglTPzolvxVvmrHWnTaCUsmZv8+srpw/QXzwRlMwF4FDKQO7CVcCuySirIQJgf6dYghNUn6cziNTEuh/KwERB1pY5WlD9D8LDpnOzdM4n1bMExmoYoj4zXRfQPiAZNXxyknqu7JoEC1op+jZjndsslX4cTmmS+E12HxtdDDNAAbTxfQq0mbRSqhPpHRebuVGwD6eo0iifnYow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tPxzVvbH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tPxzVvbH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dHbbt5rWdz2yFy
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Nov 2025 12:40:56 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764294050; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CpsoWGihg5zy3BeGFjBwgtw52Pr/CBr3dGHsUPYc2o4=;
	b=tPxzVvbHPSeR+nIu8U8pd2VXTyaBN0iTcMgF2SFUB346io2LhbrLpEqeFU/ONFzCrwONtntVaS5w7gF9sp3Uw7M8WO50OPc+d/pqdV32SVocnMMIaZgEFOCLLa92RLRXVsux4J/IVdqqhqs7PSrSyPG0sekAObunxwqhnW3tGeM=
Received: from 30.221.130.183(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtZNSKV_1764294047 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Nov 2025 09:40:47 +0800
Message-ID: <c0c827d8-569a-49ef-a6ac-a758744533a4@linux.alibaba.com>
Date: Fri, 28 Nov 2025 09:40:46 +0800
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
Subject: Re: [PATCH v2] erofs: get rid of raw bi_end_io() usage
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Stephen Zhang <starzhangzsd@gmail.com>
References: <20251127080237.2589998-1-hsiangkao@linux.alibaba.com>
 <20251127080756.2602939-1-hsiangkao@linux.alibaba.com>
 <aSjzua4jp_zZ1g1o@fedora>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aSjzua4jp_zZ1g1o@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/28 08:58, Ming Lei wrote:
> On Thu, Nov 27, 2025 at 04:07:56PM +0800, Gao Xiang wrote:
>> These BIOs are actually harmless in practice, as they are all pseudo
>> BIOs and do not use advanced features like chaining.  Using the BIO
>> interface is a more friendly and unified approach for both bdev and
>> and file-backed I/Os.
>>
>> Let's use bio_endio() instead.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v2:
>>   - call bio_endio() unconditionally in erofs_fileio_ki_complete().
> 
> bio_endio() can cover bio not submitted yet, so:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thank you and Christoph for review!

Thanks,
Gao Xiang

