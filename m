Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA85967038
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 09:54:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WwnNW1H7nz2ypx
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 17:54:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725090870;
	cv=none; b=ZEugtD1glQnEW23CHmaO/v0f3NrbEwf1CitrLWP7JJGUCIqQGfN+ID03Rs+gYATXCFRGGjaPjkO1ShbxyP8T3LxxYCO25FULe604qP/8/56hBrvhAvD9t3Fn1yH+tKCWf8KZoxs7Zzwj6rutmFx7zeGYnvPjnmsAk/I8beE4kWD5Z+1v2V2fPxgSfTLhc6A3DHTaM6DzNSv1WVriC3AH4AZpJa8MbT19Ns3Y5Mnj1XThGcSnHzXTWygUKdlsLjYUDpnhrSqGe3Blq+NgjRtBaJNYu/59NvK4Tb5LuyD6VXj1VeUDM4ZvtmmOd0RB94L7N57WeOdB1SxbCKLyjl2DaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725090870; c=relaxed/relaxed;
	bh=IVHD1JoOPLTNC1z7HLWfx5FZbwBkOQQXHvKOSp/vnz0=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=jwqPFLcocd2SBQEbRh7WJ3DOJrTAzVCHJFdiFSip9XVGotPqV6gG9zgSjiUE5yiUatUcNEPEJbkYoFAKAOrrHWYmUz9ENxdkQT1GzfMCAWP3jGQvWXGhR6vWa9hXLTAoahGdl1dGaF2uomIcPl0c66trWBNz48ThPxZ+tfkwkRiJ6rgvvDse3SBz8hXxt+9EBSIqvghgls/iUovKTYqTpAQBw+7MQSYeHi7emrBZWBqSAB9SOy+DPsh1dTAHGpirC0Rm+dZm5SqZ3ZGW9s03XPL1qZmPrh25U1IKaHHMi8BPYyC3QHdh4CzvaiD2S9JsHWDzQXWt+eUh1MwdOtgTWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CfnBPjFK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CfnBPjFK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WwnNP0ClHz2y33
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2024 17:54:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725090861; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IVHD1JoOPLTNC1z7HLWfx5FZbwBkOQQXHvKOSp/vnz0=;
	b=CfnBPjFKp6M4qbRUNaiQ1rsiCVVXDoeljeuijTJFWXlo9M4Bgs53QVpqekL4C5Xiri4YPsf1IVfuGfZhmDaWRZZtDFQde/DCH1DH0tOOp67wMZ8o/55xhQUwvXdgOkyHP+xQqmgAynh4fcTMsNYfk7IXkQQA0mRX8pz10tvz7RU=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDyp2-a_1725090859)
          by smtp.aliyun-inc.com;
          Sat, 31 Aug 2024 15:54:20 +0800
Message-ID: <063f290b-be98-4dbc-8e44-1de5b0722f42@linux.alibaba.com>
Date: Sat, 31 Aug 2024 15:54:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
To: Sandeep Dhavale <dhavale@google.com>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
 <CAB=BE-SeOSTyScFMztwT-25u5ZEU_kMjbCBYhQES2NN4nAwb4Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-SeOSTyScFMztwT-25u5ZEU_kMjbCBYhQES2NN4nAwb4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/31 12:25, Sandeep Dhavale wrote:
> On Thu, Aug 29, 2024 at 8:29 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Since EROFS only needs to handle read requests in simple contexts,
>> Just directly use vfs_iocb_iter_read() for data I/Os.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v2:
>>   - fix redundant refcount which cause hanging on chunked inodes.
>>
>>   fs/erofs/Makefile   |   1 +
>>   fs/erofs/data.c     |  50 +++++++++++-
>>   fs/erofs/fileio.c   | 181 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/erofs/inode.c    |  17 +++--
>>   fs/erofs/internal.h |   7 +-
>>   fs/erofs/zdata.c    |  46 ++---------
>>   6 files changed, 251 insertions(+), 51 deletions(-)
>>   create mode 100644 fs/erofs/fileio.c
>>
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index 097d672e6b14..4331d53c7109 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -7,4 +7,5 @@ erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>> +erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 0fb31c588ae0..b4c07ce7a294 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -132,7 +132,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>>          if (map->m_la >= inode->i_size) {
>>                  /* leave out-of-bound access unmapped */
>>                  map->m_flags = 0;
>> -               map->m_plen = 0;
>> +               map->m_plen = map->m_llen;
> Hi Gao,
> Is this change intentional? At out label, we set this again as err is 0.

Yes, that is intentional, we will return the post-EOF extent as
m_plen == map->m_llen == passed in m_llen and an unmapped extent

so that the logic can be simplified and it's still compatible.

Thanks,
Gao Xiang
