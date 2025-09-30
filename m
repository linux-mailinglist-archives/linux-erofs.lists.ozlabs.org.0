Return-Path: <linux-erofs+bounces-1143-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB00ABABF5F
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 10:08:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbW0l3XwFz3cZR;
	Tue, 30 Sep 2025 18:08:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759219735;
	cv=none; b=DbgMuKYwaNFf4+VM8aq15ATYS16u9xAUMUHDqZw1r4lluVPEZ2KBZsWXzTk4fnRlQkeqlDwwW6NX7uMNUXoNBOyxNNeqRnTkEs2lMQZOYNmD2mSuufSizmnkwqVkCE2fGWEkVywsoARRf/xmCEjH11DOKjQtmBgdKWvZp7LYY8whIFcZ8T58aQuLZ/Gd0ETmt6GgVIp7LIuF29kZkYUnJ6MbTUQdkTvbi8K/LHoVe0HDJi54pYA2Kus+CDPOQdVsRVroPs3G0tUd0EB/L36/iipqoEHPZAJraldu79dvuzQQBBNCRmzjMOm0w8lPQyLpBBcq923Z1TfHgHc3gIhucA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759219735; c=relaxed/relaxed;
	bh=/kf02ivhm9tBNzn5QhCf9g3nqzxImM90j1XUnc4U46M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ejZ/aHJJQvcbCxfXwx3wtUJa2xcL5F498ymyNYJsVcNIYKo91PNE3OVV3yEKfwmPPBRLd2UZy63FaQAwuAqZi9eOtHsjhk+75INtQWIdQZwH2+EEazrAkUYuMjTpZyMetBKvq29KfJtrwjRx7B0LnZ8hTTdHiCbGadu4G1sQErQOpFxFacKhBlBJ+2tdMfVEl3DtykLxYFauewTJK7n8Qx8msZnqt31jJsh5RrQ7EfnKbAVqXzTEF9LOLO33L4/PPK2ExMg/Z8/NNJjxyCcYlIjmr4t7bEQElRhb28gcpmouuVDzsCWXsPHY8t/vH7lHfeZJbouC0rdgpw6P82Pqiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Gtq8HNHf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Gtq8HNHf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbW0j50Blz3cZH
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 18:08:52 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759219728; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=/kf02ivhm9tBNzn5QhCf9g3nqzxImM90j1XUnc4U46M=;
	b=Gtq8HNHfjz50PWjNOaQGkeoKnPtub5D92xaRqJ3eEd7fIa+GXSRdkYC+AUtNaHnETf1cYakD4GOuB2m2jdZF6Fgo7cY48xiRI/UKVxiIKl1Xd0i8TH84NcT+1L4HWiHw8F4OaGfAJ0PXC8K9gco4Xqyqvkq7zPfHpDvZh5tL5FQ=
Received: from 30.221.129.112(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpAgxII_1759219727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 16:08:48 +0800
Message-ID: <c9647287-0ddc-4530-bd1f-068b88e4a362@linux.alibaba.com>
Date: Tue, 30 Sep 2025 16:08:47 +0800
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
Subject: Re: [PATCH] erofs-utils: tar: support archives without end-of-archive
 entry
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Ivan Mikheykin <ivan.mikheykin@flant.com>, linux-erofs@lists.ozlabs.org
References: <20250929133222.38815-1-ivan.mikheykin@flant.com>
 <aNqcvDiftM3ST7Mn@debian> <c5318494-be05-452e-8f1c-626de696c0ec@flant.com>
 <00f93f33-b42e-48e0-9e22-81e50faca479@linux.alibaba.com>
In-Reply-To: <00f93f33-b42e-48e0-9e22-81e50faca479@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/30 16:01, Gao Xiang wrote:
> 
> 
> On 2025/9/30 15:42, Ivan Mikheykin wrote:
>> Hello!
>>
>> On 9/29/25 5:50 PM, Gao Xiang wrote:
>>
>>> Could you confirm how docker/containerd or podman parses such image?
>>
>> I confirm that images with such layers work well at least in containerd with overlayfs. We encounter problems during experiments with containerd and erofs. Also, GNU tar and BSD tar are good without end-of-archive zeros.
>>
>>>
>>> Because the POSIX standard says:
>>> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html
>>> "At the end of the archive file there shall be two 512-byte blocks filled
>>> with binary zeros, interpreted as an end-of-archive indicator."
>>>
>>> So such tar layers will be non-standard, I wonder we need at least
>>> a erofs_warn() message for such tars at least.
>>>
>>
>> Good point. I think I can add erofs_warn() message to the patch.
> 
> Yes, please.
> 
>>
>>
>> P.S. I've noticed an interesting detail after submitting the patch. Produced erofs image reports an enormous file size after conversion error:
>>
>> $ mkfs.erofs --tar=f --aufs --quiet -Enoinline_data test.erofs test-no-end.tar
>> -rw-r--r--    1 user  admin  2199023255552 Sep 29 13:43 test.erofs
> 
> Yes, that is expected according to the current codebase
> since it uses a sparse file to keep temproary data and
> truncate when successful.
> 
> I guess we should remove the image entirely if mkfs
> fails instead.

BTW, also I suggest you use `--sort=none` to get rid of
this extra copy, see:
https://github.com/containerd/containerd/blob/main/docs/snapshotters/erofs.md

> 
> Thanks,
> Gao Xiang
> 
>> $ du -sh test.erofs
>> 4,0K    test.erofs
>>
> 


