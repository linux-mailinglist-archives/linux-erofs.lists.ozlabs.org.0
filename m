Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 28F238CE8FA
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 19:01:41 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qSffPACe;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VmB182JF8z87h4
	for <lists+linux-erofs@lfdr.de>; Sat, 25 May 2024 02:52:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qSffPACe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VmB110qP5z87dh
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 May 2024 02:52:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716569550; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oEGxQAUE0MnIa16lz0T+YQTooC61PSJ4eiZXc9Khk/Q=;
	b=qSffPACe/HSCQzncsv4vfQ537Ka4tcT0q6AXG4C3PJjE7+cjvGnsQIrB/OGvOcFFKDAV+wmWEzn8VvNmrMfMMc6DWy6D3LPUYY8N2M+MHRHmpgaW9I9IlWJMNjD7FG0gAqlWh0sUox4K2ouBvKIpniAb3rFVEUap2CDwxymm3+M=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W77S4p8_1716569546;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W77S4p8_1716569546)
          by smtp.aliyun-inc.com;
          Sat, 25 May 2024 00:52:28 +0800
Message-ID: <a9f890d4-555b-488f-85f8-8b22fdfd257b@linux.alibaba.com>
Date: Sat, 25 May 2024 00:52:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] lib/lz4: update LZ4 decompressor module
To: Jonathan Liu <net147@gmail.com>, Huang Jianan <jnhuang95@gmail.com>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <20220226070551.9833-3-jnhuang95@gmail.com>
 <CANwerB2SBe1+0sW1OXHEfSMA1z-vyAvLfAqVOKdsM-ap=KYbCA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CANwerB2SBe1+0sW1OXHEfSMA1z-vyAvLfAqVOKdsM-ap=KYbCA@mail.gmail.com>
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org, trini@konsulko.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2024/5/24 22:26, Jonathan Liu wrote:
> Hi Jianan,
> 
> On Sat, 26 Feb 2022 at 18:05, Huang Jianan <jnhuang95@gmail.com> wrote:
>>
>> Update the LZ4 compression module based on LZ4 v1.8.3 in order to
>> use the newest LZ4_decompress_safe_partial() which can now decode
>> exactly the nb of bytes requested.
>>
>> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
> 
> I noticed after this commit LZ4 decompression is slower.
> ulz4fn function call takes 1.209670 seconds with this commit.
> After reverting this commit, the ulz4fn function call takes 0.587032 seconds.
> 
> I am decompressing a LZ4 compressed kernel (compressed with lz4 v1.9.4
> using -9 option for maximum compression) on RK3399.
> 
> Any ideas why it is slower with this commit and how the performance
> regression can be fixed?

Just the quick glance, I think the issue may be due to memcpy/memmove
since it seems the main difference between these two codebases
(I'm not sure which LZ4 version the old codebase was based on) and
the new version mainly relies on memcpy/memmove instead of its own
versions.

Would you mind to check the assembly how memcpy/memset is generated
on your platform?

Thanks,
Gao Xiang

> 
> Thanks.
> 
> Regards,
> Jonathan
