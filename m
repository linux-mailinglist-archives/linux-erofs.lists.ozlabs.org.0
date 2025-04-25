Return-Path: <linux-erofs+bounces-235-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B940CA9C919
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Apr 2025 14:42:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZkXXj3t0Dz2yb9;
	Fri, 25 Apr 2025 22:41:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745584917;
	cv=none; b=CPza7dymidwmG0eLWAOnhN4B/qo8wTrjNla4goPYe+ITSrbGGiuybGqo8syC7CHfDihubTRIYu8Kv3zVFHoPhWgHQK7O+seHNt3Baavg/7Os/H00c4eYi2B65ZlsrfrhsKQqfBnCHYvmGJUkAAm4rOLGFSjSHF/bGj7QaU9SzGjUBeUI52PpeYtX6/rJ3NNcwnyFMFBL6O60m0/6LYTbCF+wEzTRKRduQPlIbNHxIKAF1U8wMthsK/OVPinxXhHmk7rNLvxFnV2MVJus6XEamjQYCISACFvgrfjT8M8gaNoK15o68J09Xrdxtk9GUBQ/DrlMqUWuYUob9UuknYI9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745584917; c=relaxed/relaxed;
	bh=DbAwNrVCBte3e5JldV+8djJ1vMQ4VI6LHiy3a03MLlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3lofGa3g08z714Pq2YrlTSSnDyg2bMjcvHYJ61OwPoY6Ha3rL7CgDsTFgtHTh8sGL4CKZUIqPRSiHmgNfHlk5TLczzXmFHrzyxa5a2N4bNkY5zqaGg92OycNJHDR6xtGG6qhi+hdBtds7ygiOC+eK0JGALTIlJIN3JBriMFTkecplPnb+dBv62cjezUn0bn6n6KYLI3b7avGKETbjTjmdIG0GOvpteybQEFryk4sM6Do43gDVuNeL8bguTbAk6TXZMsrPD8o8pKdSRVYbTb6TfzvC2oAA+Ng/hkfIBDhxP6uf7Q7TxF46UjNVQehC6//IH72zgL+PW7AQax2ZaEYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FW1k9Xo0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FW1k9Xo0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZkXXg2Q8Fz2xsM
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Apr 2025 22:41:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745584909; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DbAwNrVCBte3e5JldV+8djJ1vMQ4VI6LHiy3a03MLlw=;
	b=FW1k9Xo0QEHIlEsOnLHaz346z5JcRfnxxtfSGf5CClb6YUbsyhqpXhKbz77wmkenPnYgTtBVNK1j8S8r347c30399PeJI40Y816hmsYuA4CO7SXKHnmMnzgGPJNNESEASdT4xke9H+iY/FqyCHjQvvwzAsYgQTRMk9Ei+yttNMw=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WY1kjq0_1745584906 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Apr 2025 20:41:46 +0800
Message-ID: <d1b5c553-70c7-4752-90cd-9bce504c1e1f@linux.alibaba.com>
Date: Fri, 25 Apr 2025 20:41:44 +0800
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
Subject: Re: [question] Status of dictionary preload compression?
To: Simon Hosie <sh1efs@xn--tkuka-m3a3v.nz>
Cc: Linux Erofs <linux-erofs@lists.ozlabs.org>
References: <OOZ5vdV--F-9@xn--tkuka-m3a3v.nz>
 <8beeddff-816d-40ad-ae8b-a7c40748a59c@linux.alibaba.com>
 <OOaCwCu--F-9@xn--tkuka-m3a3v.nz>
 <001afbdc-27a7-4adf-abd7-21d1053ee399@linux.alibaba.com>
 <OOfA9vE--F-9@xn--tkuka-m3a3v.nz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <OOfA9vE--F-9@xn--tkuka-m3a3v.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/25 12:20, Simon Hosie wrote:
> 
> 24 Apr 2025, 05:02 by hsiangkao@linux.alibaba.com:

...

>>
> I'm not sure if I can find the time to do the research myself, but I think it's at least important to note all my assumptions and open questions anyway.  That might make it easier to formalise into a set of research tasks for an interested volunteer.
> 
> But I might find time to experiment with it.  But I should focus on my day job.  But just in case, is there a test corpus for benchmarking filesystem compression that I should run tests on?

There is no golden test corpus, but dictionary compression should
have real users if implemented, e.g. Android system image cases:

Currently most real vendors uses 4k lz4hc compression for Android,
I think dictionary compression should help reduce the image sizes.

So you could benchmark with an Android system data.

> * How big do the dictionaries need to be?  Do they have to all be the same size?  I think they certainly have to be multiples of the MMU page size so they can be page-aligned on disk.

I think it'd be much better to aligned with fs block size
(typically 4k), but multiple of 4k can be also accepted.

> 
> * If a small dictionary suffices, is it ok to pack two unrelated dictionaries together in the same slot so that two different file types can use different parts of the same dictionary?

I think it's ok and can be implemented.

> 
> * Is it true that the needs of all realistic filesystems can be met with fewer than 256 dictionaries for the whole system?  How many is a reasonable goal or a reasonable upper limit?

I'm not sure.

> 
> * Are there cases where multiple dictionaries per file have enough impact to justify the complexity?

But currently files consists of EROFS pclusters, if
compressed deduplication is on, some file could use
a pcluster from another files.

So we have to implement multiple dictionaries per
file, otherwise the on-disk format is flaw.

> 
> Of course, it might actually be easier to implement if the dictionary number is specified separately on every cluster?  In which case, it's definitely better to allow that flexibility.   Even if the default behaviour is to just use the same dictionary for the whole file, it's a tiny overhead which could be used better in future revisions of mkfs.

I think so, but we still have to know how many
bits are enough to represent the dictionary ID.

Also how to train those dictionaries efficiently.

> 
> I think for the tail merging cases, the natural thing to do is to only merge tails of files of the same type.

Currently there is no such strategy, also because
EROFS supports compressed deduplication, the
duplicated tails will be deduplicated too
regardless of the order.

But I understand you're saying the dictionary
efficiency.

> Or only files using the same compression dictionary.  Even without a dictionary involved it should always be preferable to merge tails of files of the same type because they're much more likely to share strings which can compress together.  It's not optimal to merge the tail of an HTML file with the tail of a PNG file and try to share the same compression, for example.  Merge all the HTML tails together first.

Yeah, agreed here.

Thanks,
Gao Xiang


