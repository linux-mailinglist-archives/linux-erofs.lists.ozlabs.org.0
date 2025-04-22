Return-Path: <linux-erofs+bounces-212-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80763A96F09
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Apr 2025 16:37:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZhlFN2C3Jz3bvd;
	Wed, 23 Apr 2025 00:37:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745332648;
	cv=none; b=C/fEEyib98eP3u5akrykTRnlbPLqT1SrSPeimWEDMlV7ecaWNnftJLpgDVTpCOh/UPrAMOoL4H9lY2J2TGea7BjjLAuSZGPJgJxER4K5RM1HIH7pk8C+OBdArfsYsUxgo1ebazJ+COzw6CYeA0DtLGjYufSUjVRgfrAZB99ej4dP3XbLLtaMgIXQFdx3TxvxAxO0sbRNmGccrs+9FRV4HJsxjZJlUZNrOcAxlYnER5KVeV+gAZRE3ILvEk49vdUrvwcb1Ixn2QPwTnnnAqEtLzF+XBd0WWEdrzdxceGOVPMufYVk2dM5H96U7aEkFaB1VVPMhFNestnrozLT40YhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745332648; c=relaxed/relaxed;
	bh=fmvG9ebSUK9bffhM+Katl28zOtT+EK5G9a3x1WzFRt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZpnKMuFJ77RFxRj1ay6u5mb4ONrD7iTheUuivtuKdtMlDgTT6to1ZeY4uUD0IiFoSd6PYekY4DOpH69F90fSW03zGr2/0mCAZwHmOsItP3ipBFXUVAmLNCPkYN79Fo/UTRxS+ONNcZvRQNWLLCvENxsdO+AGzzhwFJmw7jGuvNi6JNC64v/RuKaWFwSdRdGfGSs+A76acUh64ALIw1cl1ETRFGMOjoTOr8SZ2JHJzv22mzf8t6Bw1L9QpEz7DtDg92FJaJjiMVJUwspM2bXcwD6LOJNB3jQxUcr5SC1G68RyseNP15880Qw3yKzup06A+k83eS/oyR43SRlLRMNmQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZhlFM1ZnQz3bps
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Apr 2025 00:37:25 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZhlCg2V79znfb2;
	Tue, 22 Apr 2025 22:35:59 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 84BD518046A;
	Tue, 22 Apr 2025 22:37:20 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Apr 2025 22:37:19 +0800
Message-ID: <406b4b4e-1a1e-4618-87b8-7b104838770f@huawei.com>
Date: Tue, 22 Apr 2025 22:37:19 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] erofs-utils: Add --meta_fix and --meta_only
 format options
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20250422123612.261764-1-lihongbo22@huawei.com>
 <2408568f-a9e6-4e32-83b2-e79aee83a55a@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <2408568f-a9e6-4e32-83b2-e79aee83a55a@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-3.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/22 21:50, Gao Xiang wrote:
> Hi Hongbo,
> 
> On 2025/4/22 20:36, Hongbo Li wrote:
>> In this patchset, we have added two formatting options --meta_fix and
>> --meta_only to extend the ability of EROFS. In the case of using OBS,
>> we can convert the directory tree structure from OBS into the erofs
>> image and implement on-demand loading logic based on this. Since OBS
>> objects are often large, we need to separate the metadata area from
>> the data area, which is the reason we introduce the --meta_fix option.
>> To accelerate the formatting process, we can skip the formatting of
>> the raw data by adding --meta_only option.
> 
> Thanks for the patches!
> 
> I wonder if it's possible to reuse blobchunk.c codebase for
> such usage in the short term.
> 
Our initial plan was to reuse the blobchunk.c logic, but we found that 
the chunk-based layout has some minor issues when handling contiguous 
blocks—it would result in multiple elements in the chunk index array 
(whereas blobraw expects only oversized chunks).

Thanks,
Hongbo

> Also I hope there could be some better option knobs for these
> new features.
> 
>>
>> A simple usage example is as follows:
>>    1. Build one xattr with OBS key in s3fs.
>>    2. mkfs.erofs --meta_fix --meta_only data.img /mnt/s3fs to format
>>    3. Implement the loading logic in kernel or userspace.
>>
>> Based on the above logic, we can easily expose the directory tree
>> from OBS to users in the form of the EROFS file system and implement
>> on-demand data loading for large OBS objects.
> 
> BTW, It's possible to upstream OBS implementation to erofs-utils
> if any chance?
> 
> Thanks,
> Gao Xiang

