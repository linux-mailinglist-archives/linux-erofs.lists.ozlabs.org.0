Return-Path: <linux-erofs+bounces-761-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A8B1A5F9
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Aug 2025 17:29:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwgTJ0Dybz3bxf;
	Tue,  5 Aug 2025 01:29:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754321364;
	cv=none; b=Bp74x5czEcsPCeoXzLrsk0+R39aNCW8zD7Rgasx2vhVAZOSdx6tLsr4vAgAONvty3uIwn8ddWnFhy8aZHDseX7DMnCTacMjkEd5LyRQQC9v6cuFt0MIdtjxXhBdBApuWsFrFniqsmAXgV2Bf1XnOelAj3hFOOmNWJMRNjgk3kEgtUp48bY8Z+qet2z2VwRleOCtQzkTgdr7wTRy4ugfdeZi8w+4Y08NMTLLBsSjHI1OU4v54pn5jlT0mtLy3ar0CduFtCSN+Zd1UuENSYuUV0HHqs3KIriszMsruNAS3thpLlLCBDUP7QGcJbcqvZEgwv725vaAVkaz4VNWWRgCsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754321364; c=relaxed/relaxed;
	bh=KnQwWTBUVG9yb+koaP/Q35EgEbcRJ5fdlQtnuFfqqRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=K1nV+8gSXqZ9yBVNJBA80AkWAcb9mqIojoWjEE9PJ5UmlP+YaJ4JPBBITYxXYHdzsyRF666TZQvnotyfCizS0SD1iUAQfd9vkVsmnovLqf+ZYbJ8wHFuOa7cvGcItvi2ETHDZI2DGbqdT3/fgsAFaF+g9J05cTTMfCFJa+TJovfWNe0YlePuJlIUq0YmuJ4yrwbjspCEQ+YlWpmiw+DlmFxKToj82T16XqWk0CpAMM0V9AaCVYo8+npgidaUoz1UIKDvNf1XYObgWvC90tEMM9TjjyRc1UTxNk3GN9Kh307+9nnJT5fkaPOnXIOiOBKyfKfd7MqeOdHABYKCQo0dRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwgTH1GvXz3bxR
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Aug 2025 01:29:23 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bwgPX0f77z13MyN;
	Mon,  4 Aug 2025 23:26:08 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id E9040180B60;
	Mon,  4 Aug 2025 23:29:20 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 23:29:20 +0800
Message-ID: <eb29e660-1194-48da-b781-1dbc936a7106@huawei.com>
Date: Mon, 4 Aug 2025 23:29:20 +0800
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
Subject: Re: [PATCH v2 2/4] erofs-utils: introduce build support for libcurl,
 openssl and libxml2 library
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
 <20250801073046.1900016-1-zhaoyifan28@huawei.com>
 <c25002cd-25ea-46f1-9bd1-16d479f418c4@linux.alibaba.com>
CC: <jingrui@huawei.com>, <lihongbo22@huawei.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <c25002cd-25ea-46f1-9bd1-16d479f418c4@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


On 2025/8/1 15:39, Gao Xiang wrote:
>
>
> On 2025/8/1 15:30, Yifan Zhao wrote:
>> From: zhaoyifan <zhaoyifan28@huawei.com>
>>
>> This patch adds additional dependencies on libcurl, openssl and 
>> libxml2 library
>> for the upcoming S3 data source support, with libcurl to interact 
>> with S3 API,
>> openssl to generate S3 auth signature and libxml2 to parse response 
>> body.
>>
>> The newly introduced dependencies are optional, controlled by the 
>> `--enable-s3`
>> configure option.
>
> Use 72-char per line at maximum...
>
Fixed in this and other 3 patches. Thanks for pointing it out!
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>> change since v1:
>> - rebase on the latest `experimental` branch
>> - rename: lib/s3.c => lib/remotes/s3.c
>> - configure.ac: introduce `subdir-objects` option as s3.c in a subdir
>> - move include/erofs/s3.h in the following patch
>>
>>   configure.ac     | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>   lib/Makefile.am  |  4 ++++
>>   lib/remotes/s3.c |  6 ++++++
>>   mkfs/Makefile.am |  3 ++-
>>   4 files changed, 54 insertions(+), 2 deletions(-)
>>   create mode 100644 lib/remotes/s3.c
>>
>> diff --git a/configure.ac b/configure.ac
>> index 2d42b1f..82ff98e 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -24,7 +24,7 @@ esac
>>   # OS-specific treatment
>>   AM_CONDITIONAL([OS_LINUX], [test "$build_linux" = "yes"])
>>   -AM_INIT_AUTOMAKE([foreign -Wall])
>> +AM_INIT_AUTOMAKE([foreign subdir-objects -Wall])
>>     # Checks for programs.
>>   AM_PROG_AR
>> @@ -165,6 +165,10 @@ AC_ARG_WITH(xxhash,
>>      [AS_HELP_STRING([--with-xxhash],
>>         [Enable and build with libxxhash support 
>> @<:@default=auto@:>@])])
>>   +AC_ARG_ENABLE(s3,
>> +   [AS_HELP_STRING([--enable-s3], [enable s3 image generation 
>> support @<:@default=no@:>@])],
>> +   [enable_s3="$enableval"], [enable_s3="no"])
>> +
>>   AC_ARG_ENABLE(fuse,
>>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse 
>> @<:@default=no@:>@])],
>>      [enable_fuse="$enableval"], [enable_fuse="no"])
>> @@ -578,6 +582,32 @@ AS_IF([test "x$with_xxhash" != "xno"], [
>>     ])
>>   ])
>>   +AS_IF([test "x$enable_s3" != "xno"], [
>> +  # Paranoia: don't trust the result reported by pkgconfig before 
>> trying out
>> +  saved_LIBS="$LIBS"
>> +  saved_CPPFLAGS=${CPPFLAGS}
>> +  PKG_CHECK_MODULES([libcurl], [libcurl])
>> +  PKG_CHECK_MODULES([openssl], [openssl])
>> +  PKG_CHECK_MODULES([libxml2],  [libxml-2.0])
>
>
> I wonder if it's possible to introduce
> `--with-libcurl`
> `--with-openssl`
> `--with-libxml`
>
> and `--enable-s3`, and if users disable any library,
> it should fail.
>
> I think why it should behave as this, because libcurl
> openssl and libxml can be used for other use cases
> (e.g. oci registry support), users can always link
> these libs
>
Done. Introduce `--with-{libcurl,openssl,libxml2}` options,

and `--enable-s3` would fail if any of them is not satisfied.


IMHO, we should use --with-libxml2 instead of --with-libxml

here as this is its official name. Please point it out if I'm wrong.


Thanks,

Yifan Zhao

> Thanks,
> Gao Xiang

