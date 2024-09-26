Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6A986EBB
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 10:25:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDmr80ZkNz2yps
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 18:25:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727339125;
	cv=none; b=o1TLgZ4UIuDXLQb92mj+GZeTeiA+AMOWCfxiMpXFuv3S8+QiucZhUQ9ERy0WptqrsG64Hxk8GibC1NvmwJgi4G5GKyS6tVRWdYXESEiMUK/MpAAhuEyx7C0GnVQZ87mZVT9pJwYwecubE+ZWanbiYs9yfohoqWCREAxpVaPmz0/lLF2en5ZRqRazHnwQpBYdt7MQrWeBmCxh2xSRxTI4p/N/owbozEb2xXsleI0IQFCYwJl5k1bln8QvxHZEX2xoW6+ZF8J+PoKtZ1BxbFLylnNiFLMZYNwmsjSOoxDI5vHzEKk8ywMXEDbkX+pSdDZf67koRPRcmaKXhtFt/6GcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727339125; c=relaxed/relaxed;
	bh=PKsWARor3DVvs3wWB30YmVXctqsq0fmGOIDstG8XMAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfuzcphEPj38vxjrd21DbR29ftytXinn3gN9eEGmzrvhtuZHihPXC2TmjqLQfr6y1sByXUV2cw2VCXDce5zKVwJKQ8XPiE33C9Pxv8L8OFrWW0oMJneIC9hJzK3OA1/kCBm2/OnQgFnWVs2hB2yZtULU/pFtQiH6lqkZxjVppxZBQ018ytSQIyIZVg4sicXbym8/RflwadSWi9xBl7LFlK32itti9yXujpWN3IEvyb/L/V7qKEBSaBIvcV2RAznPtGKjos6uYQ2qhyNInbGvQt4jO4gP1G8z6fQ5J67Ou5ZKOUdSQ3rsafhr1B0cH0WHD0+vvsmlqEBzzfII58z80g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OvOXfJmN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OvOXfJmN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDmr10l6tz2y8R
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 18:25:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727339112; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PKsWARor3DVvs3wWB30YmVXctqsq0fmGOIDstG8XMAg=;
	b=OvOXfJmN/VnMRs4jQg8hQNSo3+pu42KutTZiDv+hsU6hSV+DNE4Xgl4fA+zhwVJYriOmdyA46U/vH7wJ2lkrlVV1AMDT2pE4bgQ9enntxFWvYBINP6VgTpsWnR6MlZ949AbENuWyp24Gsy7ChhKc1YQmnQEF23VHEA61lq6DRL8=
Received: from 30.221.129.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFmjSo-_1727339109)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 16:25:10 +0800
Message-ID: <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
Date: Thu, 26 Sep 2024 16:25:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
References: <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
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
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/26 16:10, Ariel Miculas wrote:
> On 24/09/26 09:04, Gao Xiang wrote:
>>


...

> 
> And here [4] you can see the space savings achieved by PuzzleFS. In
> short, if you take 10 versions of Ubuntu Jammy from dockerhub, they take
> up 282 MB. Convert them to PuzzleFS and they only take up 130 MB (this
> is before applying any compression, the space savings are only due to
> the chunking algorithm). If we enable compression (PuzzleFS uses Zstd
> seekable compression), which is a fairer comparison (considering that
> the OCI image uses gzip compression), then we get down to 53 MB for
> storing all 10 Ubuntu Jammy versions using PuzzleFS.
> 
> Here's a summary:
> # Steps
> 
> * I’ve downloaded 10 versions of Jammy from hub.docker.com
> * These images only have one layer which is in tar.gz format
> * I’ve built 10 equivalent puzzlefs images
> * Compute the tarball_total_size by summing the sizes of every Jammy
>    tarball (uncompressed) => 766 MB (use this as baseline)
> * Sum the sizes of every oci/puzzlefs image => total_size
> * Compute the total size as if all the versions were stored in a single
>    oci/puzzlefs repository => total_unified_size
> * Saved space = tarball_total_size - total_unified_size
> 
> # Results
> (See [5] if you prefer the video format)
> 
> | Type | Total size (MB) | Average layer size (MB) | Unified size (MB) | Saved (MB) / 766 MB |
> | --- | --- | --- | --- | --- |
> | Oci (uncompressed) | 766 | 77 | 766 | 0 (0%) |
> | PuzzleFS uncompressed | 748 | 74 | 130 | 635 (83%) |
> | Oci (compressed) | 282 | 28 | 282 | 484 (63%) |
> | PuzzleFS (compressed) | 298 | 30 | 53 | 713 (93%) |
> 
> Here's the script I used to download the Ubuntu Jammy versions and
> generate the PuzzleFS images [6] to get an idea about how I got to these
> results.
> 
> Can we achieve these results with the current erofs features?  I'm
> referring specifically to this comment: "EROFS already supports
> variable-sized chunks + CDC" [7].

Please see
https://erofs.docs.kernel.org/en/latest/comparsion/dedupe.html

	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
Compressed OCI (tar.gz)	282.5	28.3	63%
Uncompressed OCI (tar)	766.1	76.6	0%
Uncomprssed EROFS	109.5	11.0	86%
EROFS (DEFLATE,9,32k)	46.4	4.6	94%
EROFS (LZ4HC,12,64k)	54.2	5.4	93%

I don't know which compression algorithm are you using (maybe Zstd?),
but from the result is
   EROFS (LZ4HC,12,64k)  54.2
   PuzzleFS compressed   53?
   EROFS (DEFLATE,9,32k) 46.4

I could reran with EROFS + Zstd, but it should be smaller. This feature
has been supported since Linux 6.1, thanks.

Thanks,
Gao Xiang
