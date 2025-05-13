Return-Path: <linux-erofs+bounces-307-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EF423AB4C92
	for <lists+linux-erofs@lfdr.de>; Tue, 13 May 2025 09:17:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxSTn51zfz2yFK;
	Tue, 13 May 2025 17:17:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747120637;
	cv=none; b=j44Q/EexPT4FFjlmUa0zIUhdY/a4AS8SHS/BT4p9AXbJZLnOnCKbbwsv5lnbO+4qqO/gl/J7r6agjweqsAXUkOl1H6LhaB5Z1Y9N0tOvXCe5tFIXzfU3NcFQ96FqqOWliYd3oAQF1mzGBuDe39jHlHo42QqgjzNP8CUWttUQRiJAkKMJgJ1bfxSmohlIYxoI8krLFGuhM+yy4DvTc3/GGw+qYRr8vNzMV8JzM5cojFnqYdyIte1EjBiQJ1cSJ2FFD9mkX+tpmywkphfNCKfCSQvy/NHOuSZLToCh+jfDNRg9QNXo5DfMVdppuRNGezHbl6xLVakRMIeXGlYcHwnTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747120637; c=relaxed/relaxed;
	bh=fP8M5x2O0Q4shZ299CnxDV5ETn/5L7lKCTDwIFxMRZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AYw0f0hhoJ16Wk/LBgER2GhncsyNZ69Vl53pltaeS0Divpf01uousULC1NHYlGB/+JGQSYxLwfx3DPE+HUVz/Moh2gc2MtN0Z5Gwwg+5IBLi7DKjQFtox+n6oQ6vzMDXoL2uMLhQKp9GuOigX4JGEHCrASu492VoIrPHlFZ4Ap44A3rb7IwaY1mX0hI0P9Xw8Zfj6AbYVJWxA5bO2HBdzSWHG7alsL/xwXSIiaSS+BFcHJcJr8ZDVMEv1ZvJo3PFJNf+1uCI3L+qU+Pqq7JfIq2/UmZh7GNw2sBJWRBFI8038c7xf+GXmxu/YvVs1tbtYsjHSUURKsvF1Fz+7gNxaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jTZ8gaQk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jTZ8gaQk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxSTl2wpJz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 May 2025 17:17:12 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747120628; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fP8M5x2O0Q4shZ299CnxDV5ETn/5L7lKCTDwIFxMRZ0=;
	b=jTZ8gaQkvnw2/7UK0VjgxHzrD5CaZ+kF0RCpKOFWtq9h8Yhh8onFJ1li/Rnt2bHv1/7LjPg8LIhmOVX4Dd6/BM4ThnhSkfzNnx1MOQTKCPNkirC9/Oeyu2iSoL32qtv3FIuFZ2ZZnNHtOvc5GlE1ioAH4rr3B7VPYqH/YC5EXCI=
Received: from 30.221.133.89(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WaVp9Sn_1747120625 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 May 2025 15:17:06 +0800
Message-ID: <c5110e03-90ea-40be-b05f-bc920332a1e1@linux.alibaba.com>
Date: Tue, 13 May 2025 15:17:05 +0800
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
Subject: Re: [PATCH v4 2/2] erofs: add 'fsoffset' mount option for file-backed
 & bdev-based mounts
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20250408122351.2104507-1-shengyong1@xiaomi.com>
 <20250408122351.2104507-2-shengyong1@xiaomi.com>
 <4aced850-18a0-4b05-80f4-4f690e387a13@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4aced850-18a0-4b05-80f4-4f690e387a13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/13 15:06, Hongbo Li wrote:
> 
> 
> On 2025/4/8 20:23, Sheng Yong wrote:
>> From: Sheng Yong <shengyong1@xiaomi.com>
>>
>> When attempting to use an archive file, such as APEX on android,
>> as a file-backed mount source, it fails because EROFS image within
>> the archive file does not start at offset 0. As a result, a loop
>> device is still needed to attach the image file at an appropriate
>> offset first. Similarly, if an EROFS image within a block device
>> does not start at offset 0, it cannot be mounted directly either.
>>
>> To address this issue, this patch adds a new mount option `fsoffset=x'
>> to accept a start offset for both file-backed and bdev-based mounts.
>> The offset should be aligned to block size. EROFS will add this offset
> 
> Hi Yong,
> 
> Why the offset should be aligned to block size? I mean, we can use the original offset directly during read, and then add this offset after reading.

Currently metabuf and bio are all block-based I/Os (otherwise
taking metadata for example, it could cross page boundary), I
uess it's complex to support unaligned offsets.  Also it seems
lack of use cases?

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo


