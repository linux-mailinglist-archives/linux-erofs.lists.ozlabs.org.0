Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 53951A135BB
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 09:45:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYbzj5pptz3c6n
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 19:45:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737017137;
	cv=none; b=B33MaGsFi8Hlbf+NYqQHOvZI7q7280/JGNE3+D/w2no52wjOk2QQJAIe9DxcxNHYarpWu+sLi78M4tR1P5/9bvnumKvTuFh04fiqlQHp7SWVa2Y+/ubcNfLq0K1G7uot6M32d+QAn9bwHX3208HNUHzeuE1kBQOoF740v7k0t6iE7tm4ghhAZKErPw5o3sVJTO6Hq41sPfJNLx9UK+cmZLCD01uBMvPZY6D6pz3jpDEmWhZIWctgpf5JvkMmuGowTLq7K8HBZTENM3Zq+eb1T4b9aYxbVXUTMr2isdYyRcki1tOaDhlpx4P4kC+3J83NprOaMbwcgI4CoGfvVecC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737017137; c=relaxed/relaxed;
	bh=txoQMmxDklJHnn+SIH4XcL8PyI5x6vLX56gDkuBtPIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNoCDCVE+EvfmL6GuIYzjLyB0TMDygyd6i8LlND0ZFkGiUdbfMeMKj5ZelHwKnw/ldNP6ILsc7GVOVA2lPbWgROr7pWTMyr8AYRyYnP8x5cmWi3kbkW/vPj7EeUCFV9j4DgKqSwvSHVNlHi+iJ+ZBCLGrzI8uW6VOP9NlH/beOaBJs8zeAxqFEqPOP430C5HHT4XoaJOnj8H0cnn9RgKlN3lbYBUCmgLV2vi45lKjTEeH8gMN9ZLu9GFLRT5qE+njFGEXa8R7P08vHLO0cMZ3f8rWxAkPIRf85hASNGNtVb6jVWwTwYYq+YdpFoM4ZHlg7vJaw8IWzoe0E0AifjN7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g72KqJC7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g72KqJC7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYbzf6Qsbz2yJ5
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 19:45:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737017127; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=txoQMmxDklJHnn+SIH4XcL8PyI5x6vLX56gDkuBtPIw=;
	b=g72KqJC7ZSmYGXKqS2mtKwpQGohD9t2UP/v61GcvLGsfniEHQpIHBSU9UnGQIF91zc2eTTBVp0N4E3ozDS3xCncKOo56tmWBmSyWdWeAZ0pdbx9t6NGBasFtqPvi92ysag2sRlXLj07t9XyRO7icmLrWgeGRpa+HNI0Hz+tTwPM=
Received: from 30.221.130.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNl2-1y_1737017125 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 16:45:26 +0800
Message-ID: <d1e4c851-b399-4d6b-9e0b-4124ef7bbf64@linux.alibaba.com>
Date: Thu, 16 Jan 2025 16:45:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs(shrinker): return SHRINK_EMPTY if no objects to
 free
To: Chen Linxuan <chenlinxuan@uniontech.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
References: <433DB98624BCDF95+20250116072042.189710-1-chenlinxuan@uniontech.com>
 <b33944b1-18fa-4a27-858f-5922ea1e1003@linux.alibaba.com>
 <AC9D4F55C39C7580+c01e5ccb2bf8f14644d02a84ccc834ad49f86fbb.camel@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <AC9D4F55C39C7580+c01e5ccb2bf8f14644d02a84ccc834ad49f86fbb.camel@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/16 16:24, Chen Linxuan wrote:
> On Thu, 2025-01-16 at 15:51 +0800, Gao Xiang wrote:
>> Hi Linxuan,
>>
>> On 2025/1/16 15:20, Chen Linxuan wrote:
>>> Comments in file include/linux/shrinker.h says that
>>> `count_objects` of `struct shrinker` should return SHRINK_EMPTY
>>> when there are no objects to free.
>>>
>>>> If there are no objects to free, it should return SHRINK_EMPTY,
>>>> while 0 is returned in cases of the number of freeable items cannot
>>>> be determined or shrinker should skip this cache for this time
>>>> (e.g., their number is below shrinkable limit).
>>
>> Thanks for the patch!
>>
>> Yeah, it seems that is the case.  Yet it'd better to document
>> what the impact if 0 is returned here if you know more..
> 
> Sorry, I have no idea about that.

I guess it has no difference if the shrinker is not memcg-aware,
see:
https://lore.kernel.org/r/153063070859.1818.11870882950920963480.stgit@localhost.localdomain

But I'm fine to use SHRINK_EMPTY since it's clearly documented.

So could you resend a patch to address my suggestion?

Thanks,
Gao Xiang
