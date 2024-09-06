Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9367C96E793
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 04:10:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0KSp3Hj2z303B
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 12:10:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725588631;
	cv=none; b=bwxAV7zmiRPEwxJCknYSBBpgx9NETUpydjlvcP6qhgmBd5ymeoE0/bKROfblBb8V5Smuu6PTjsfYgfQXGMNPZcAknebSnhQt8klhzCRNtVek/cUzc6vodMBVoVncx3rOALGNu0j0SRlAYXnlBmISPemPr/9uyYTaie58xB4y2Wnr5+ELOAcuwDUXvLnCPYV2tPmw0r6UeIbBKYJDxKwsaRmYCINN7fYqdhUDirq02uIGuhZA/LM1d08sHIzl39cGmA7uIUvmQcaVmHYvzTn6KRKn4NnyE2mzTq8ZGLSYumghxOocu6NjuxIX88g0qg1ysAfrUp1wrnMluj9sez81MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725588631; c=relaxed/relaxed;
	bh=kdtEqYuU5Yw/a34PBzqfQtjqZWcbwweygod3M7eoLqM=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To:Content-Type; b=ZrArkFkjM8FIyA0DozvXYZbBJh/l1osVRs/qnhEOEvlHNjrr1RcLbkDKob0hKVdt/vyGMYIZxQLenev9GjDNfIKgiECszWP+kb0zu8Oh674nVOcoD7ZyI3PTYADXDnECagK+dSsFklCelW11QwfxS4QFZwAaOnLzvEOHm0l79XNzR4vLl2Mr8dAzwvup6hIATC3R2OBijMs7JUxWQbZkJMnftoz5fC7ucAJ8m8eP0e1j5HJ0yqo0aIfFNcGmrgyTeVYItpK+gd9Z5GpxXfO+RCq9VgAwIHAC8pLzZjJCUYtBZPNhGZIEu24dwgZ2fergxEGaThtNANcaQGYaq538Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LBgsphHG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LBgsphHG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0KSk5xtJz2y3b
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 12:10:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725588627; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kdtEqYuU5Yw/a34PBzqfQtjqZWcbwweygod3M7eoLqM=;
	b=LBgsphHGRqrReH3aKhZnEgINvNFt9FzGu9McyGlW6HiCquXGKhns0BpUZu+1udF+p4iG2AjPfNqavKM/aClOLACJiuSNUF1fPNd0al3WQXw82SLBbCOUPzH3jxzVf/92Nos2YL0T+eHDJnwEkMKXP6Mggr2yrnaVknS8SRkhvRw=
Received: from 30.221.130.77(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WENda2R_1725588625)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 10:10:25 +0800
Message-ID: <2b8da4cf-7235-4dc8-b469-5a94780f5ae8@linux.alibaba.com>
Date: Fri, 6 Sep 2024 10:10:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External Mail][PATCH v4] erofs-utils: fsck: introduce exporting
 xattrs
To: Hongzhen Luo <hongzhen@linux.alibaba.com>,
 Huang Jianan <huangjianan@xiaomi.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <20240905113723.1937634-1-hongzhen@linux.alibaba.com>
 <b1932b1a-e30a-4665-a268-32b4b74d648c@xiaomi.com>
 <1d763972-93f4-426a-9a8c-846d02813773@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1d763972-93f4-426a-9a8c-846d02813773@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/6 10:06, Hongzhen Luo wrote:
> 
> On 2024/9/5 20:02, Huang Jianan wrote:
>> On 2024/9/5 19:37, Hongzhen Luo wrote:
>>> The current `fsck --extract` does not support exporting the extended
>>> attributes of files. This patch adds `--xattrs` option to dump the
>>> extended attributes, as well as the `--no-xattrs` option to not dump
>>> the extended attributes.
>>>
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>> ---
>>> v4: Optimize the error messages and code.
>>> v3: https://lore.kernel.org/all/20240903113729.3539578-1-hongzhen@linux.alibaba.com/
>>> v2: https://lore.kernel.org/all/20240903085643.3393012-1-hongzhen@linux.alibaba.com/
>>> v1: https://lore.kernel.org/all/20240903073517.3311407-1-hongzhen@linux.alibaba.com/
>>> ---
>>>    fsck/main.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>>>    1 file changed, 79 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fsck/main.c b/fsck/main.c
>>> index 28f1e7e..183665c 100644
>>> --- a/fsck/main.c
>>> +++ b/fsck/main.c
>>> @@ -9,6 +9,7 @@
>>>    #include <utime.h>
>>>    #include <unistd.h>
>>>    #include <sys/stat.h>
>>> +#include <sys/xattr.h>
>>>    #include "erofs/print.h"
>>>    #include "erofs/compress.h"
>>>    #include "erofs/decompress.h"
>>> @@ -31,6 +32,7 @@ struct erofsfsck_cfg {
>>>           bool overwrite;
>>>           bool preserve_owner;
>>>           bool preserve_perms;
>>> +       bool dump_xattrs;
>>>    };
>>>    static struct erofsfsck_cfg fsckcfg;
>>>
>>> @@ -48,6 +50,8 @@ static struct option long_options[] = {
>>>           {"no-preserve-owner", no_argument, 0, 10},
>>>           {"no-preserve-perms", no_argument, 0, 11},
>>>           {"offset", required_argument, 0, 12},
>>> +       {"xattrs", no_argument, 0, 13},
>>> +       {"no-xattrs", no_argument, 0, 14},
>>>           {0, 0, 0, 0},
>>>    };
>>>
>>> @@ -98,6 +102,8 @@ static void usage(int argc, char **argv)
>>>                   " --extract[=X]          check if all files are well encoded, optionally\n"
>>>                   "                        extract to X\n"
>>>                   " --offset=#             skip # bytes at the beginning of IMAGE\n"
>>> +               " --xattrs               dump extended attributes (default)\n"
>>> +               " --no-xattrs            do not dump extended attributes\n"
>> How about:
>>
>> " --[no-]xattrs  whether to dump extended attributes (default on)\n"
>>
>> To keep the same style as the other switch options.
>>
>> Thanks,
>> Jianan
> 
> Yes, that would be more concise. I'll send a new version soon.

Yes, that is a good idea, please help send a version
so I could merge this work.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> Hongzhen
