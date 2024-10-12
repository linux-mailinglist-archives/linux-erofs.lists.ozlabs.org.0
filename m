Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F134C99B0D6
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2024 06:35:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XQVz551YRz3c47
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2024 15:35:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728707712;
	cv=none; b=f2BECed+agIA9m2QaOWOzRQ9cW8qJwYAKPYjE64s0innqG6yIw4v93Gy7jLJSDWXE867qX1/gHnY2EIMzz0CweNG0sXGe6KmEcKjC4omX8i7mp16026Zu/L4opp0I77Bm0wJr3RdGUouM+u7uwCTNUHlaFnkud4lipJ53bp67af1TThkNm4SZQf0KSyWMuNFmdhuh8yRGkrSS/3SIMLTzRpp1gBkDsioj5t06Vw3DVeFzTgsU3CzcIAw+nqedmgX9YOQEyzeJjPf/rWTE4IYItYl3G5qqGF3WZnMRrJZmy7nrFNXq0iacgnSFdzNT7gDGjTagpvotzbL417WfSdbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728707712; c=relaxed/relaxed;
	bh=zxtFacNsmx6ZvQ6FvdGD94ls0sIbsA4H68ekCoXn5D8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=SB3R0teJGkob/JZ7VGMHHCkkyYM5O1rcNd/VM8SQXYwhKkd/5nrKXFf8lbFsf/MnWnPkJZZoCwqgfD9uTO7thtWueNwDqGy4uSW4q49NL7VzQRQsIWAe/xrVOXdmmxK5/q6oLbU1664A5At5LJ1xhczSoakjqZXNjbimK9zMAfkKDlxLXmfrge/sxKL+VTeQQ5Iken9n3AGQ+3YxW6HapzHiy/iWpqCqQvR/69yoZ6TVT7+i+13rwIOfVzncH3MTZKuhqv2TMAoOY2m0aHbrhfCOkUM/v+c5k8pAvJalHRP64fE6X7EuS0fpKDtlXO4lDf1+6JWLxY/Y1X55BNx8Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yNlFlHlY; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yNlFlHlY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XQVyz0cW2z2yNj
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2024 15:35:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728707698; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=zxtFacNsmx6ZvQ6FvdGD94ls0sIbsA4H68ekCoXn5D8=;
	b=yNlFlHlYut9mVtcP2bwyqI/uz9c3tbYcCgm8l5SznvDkSkjgPwyzQqrSfCxKk7RKAH/4r0in7k5bHjjWEtph28W6IVs6AC5ZC850PZcluDv20X3i783UQcJYmXVyH/YuRqf7MuywYKR8NlGGfa32bqJ0pMOnPusV2t+z4dIGjDw=
Received: from 30.27.69.130(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGuMwrB_1728707696 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 12:34:57 +0800
Message-ID: <6076d690-9b69-4821-a0c8-4172a4f47c9b@linux.alibaba.com>
Date: Sat, 12 Oct 2024 12:34:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] erofs-utils: Compression with -Eall-fragments
 segfaults on 1.8.2
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Michael <fedora.dm0@gmail.com>, linux-erofs@lists.ozlabs.org
References: <CAEvUa7njGB_7Xs4A+DhGBR0LZL--tAZNmU=3bFS+uVm0G8uULg@mail.gmail.com>
 <df3200b8-4fc4-4db3-a112-2f963a263b36@linux.alibaba.com>
In-Reply-To: <df3200b8-4fc4-4db3-a112-2f963a263b36@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/12 10:05, Gao Xiang wrote:
> Hi David,
> 
> On 2024/10/12 04:22, David Michael wrote:
>> Hi,
>>
>> Version 1.8.2 has a reproducible segfault with "-E all-fragments"
>> (testing on Fedora 40).  When compressing the install image, it
>> consistently hangs on a firmware file:
>>
>>> sudo dnf -y install erofs-utils
>>> wget https://dl.fedoraproject.org/pub/fedora/linux/releases/40/Everything/x86_64/os/images/install.img
>>> sudo mount install.img /mnt
>>> sudo mkfs.erofs -z zstd -E all-fragments erofs.img /mnt
>>
>> If you isolate just that firmware directory instead of the whole
>> image, it will segfault:
>>
>>> mkfs.erofs -z zstd -E all-fragments erofs.img /mnt/usr/lib/firmware/nvidia/ga102/gsp
>>
>> It happens with all compressors I've tried, but adding "dedupe" works
>> around it.  Is there any change I should test?  Let me know if you
>> need additional information.
> 
> Thanks for the report, I will look into that.

I've submited a fix for this,
https://lore.kernel.org/r/20241012035213.3729725-1-hsiangkao@linux.alibaba.com

The original one is a SquashFS xz image:
Compression xz
         Dictionary size 131072
         Filters selected: x86
Block size 131072
Inodes are compressed
Data is compressed
Fragments are compressed
..

so the results are:
618008576 install.img
621953024 install.erofs (mkfs.erofs -zlzma -C131072 -Eall-fragments,ztailpacking -T0)

Since EROFS doesn't support metadata compression for now,
the difference is just out of compressed metadata.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks.
>>
>> David
>>
>> Originally reported in: https://bugzilla.redhat.com/2318138
> 

