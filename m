Return-Path: <linux-erofs+bounces-288-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 37844AAD375
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 04:42:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsfgY3VmLz2yhX;
	Wed,  7 May 2025 12:42:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746585753;
	cv=none; b=EjuoJagYqUZ3O/zymisKdbeaFhaewF3Z8R5WWVOZgQsEu93U+KcbO9amtVFFKQn6AOtOr6+UVMV9Q9PECrmRx5q7f/KWGwKtdqEolnZAH4yWz9EXuIllV8XLixucEfLezQmyib8QslNai8R7s4uXV29Zkwjla276J2OXMRT6IDmb294YaF2JLqVLlJgwlSuFXCx8OMBc+pF8iHXGguxyg0gbLNUcNG1mLEAyNsV4rtcKD8vhOIKnFLvb2Lnell0DtfTI9e7PSFp3gZZ/3MAWe6wk1TseoTJqrXUESzufezVvTDPMKCyZN9kD3fW0GXy57xYSCx8Kcq5iGZ+LH9p5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746585753; c=relaxed/relaxed;
	bh=zJikcTQk9Z8vf+vv6wxs06aouJcHm5T6PfC75KHz4p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yc1wE/6wAaQG5WlaMf+hE/cionebb+U5OnKaoOFFVXPh+JYqjAYlAtIHthufodimiYz+YXxfvz9hJQr6n2ACUz6DmZu2POEdlohWLGOtImWDxAE7SM5Kcmx4QNH4B3rREbDRUMevmMmav4AKI7d2tfVoBwnbbYlFNUoxCmdafXcjdCuOP5AG1AfzxUkHwnpko+HwwMczaWIruHkH6NpsPgfB5rHVgdd/IQhIGvzFSCRWLNgArIE1AXjvaL7p9nV9dcf0i9xJA5tMuierT6X334e7ad33dPfoDU1f8KYhCG6iNk76d3ctGAIErvUdZrqDTM0u3dop1zhdgLJlgRVhgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dQ4Z8loi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dQ4Z8loi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsfgW0zPhz2yD5
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 12:42:30 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746585746; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zJikcTQk9Z8vf+vv6wxs06aouJcHm5T6PfC75KHz4p8=;
	b=dQ4Z8loiQKmHMHdQoCSAwKwgdcR+P6EmV6q9VDR6utmPvcgq4lshK1mfeGxtnvEGZKeNKQMTy5gnQB2DERvRQf9VICM5boXk18ck8EQtK+Y0GjZI9F12/hBKQfVeqEr6hX2wDt/WjTiQ8HpsKOMUbMTnBbdCun9AZwPCnHtnsSE=
Received: from 30.221.131.179(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZkK2Sl_1746585744 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 May 2025 10:42:24 +0800
Message-ID: <1151f059-fd08-4dba-9448-c8c535ea8700@linux.alibaba.com>
Date: Wed, 7 May 2025 10:42:24 +0800
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
Subject: Re: [PATCH v3] erofs: fix file handle encoding for 64-bit NIDs
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com
Cc: dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250429134257.690176-1-lihongbo22@huawei.com>
 <18d272ce-6a80-4fdc-b67b-ddc2ffa522d4@linux.alibaba.com>
 <3e068311-9223-4c1b-9091-15eb2d867ede@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3e068311-9223-4c1b-9091-15eb2d867ede@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/7 09:53, Hongbo Li wrote:
> 
> 
> On 2025/5/6 23:10, Gao Xiang wrote:
>> Hi Hongbo,
>>
>> On 2025/4/29 21:42, Hongbo Li wrote:
>>> In erofs, the inode number has the location information of
>>> files. The default encode_fh uses the ino32, this will lack
>>> of some information when the file is too big. So we need
>>> the internal helpers to encode filehandle.
>>
>> EROFS uses NID to indicate the on-disk inode offset, which can
>> exceed 32 bits. However, the default encode_fh uses the ino32,
>> thus it doesn't work if the image is large than 128GiB.
>>
> Thanks for helping me correct my description.
> 
> Here, an image larger than 128GiB won't trigger NID reversal. It requires a 128GiB file inside, and the NID of the second file may exceed U32 during formatting. So here can we change it to "However, the default encode_fh uses the ino32, thus it may not work if there exist a file which is large than 128GiB." ?

Why? Currently EROFS doesn't arrange inode metadata
together, but close to its data (or its directory)
if possible for data locality.

So NIDs can exceed 32-bit for images larger than
128 GiB.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 


