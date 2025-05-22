Return-Path: <linux-erofs+bounces-363-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0DBAC0D6A
	for <lists+linux-erofs@lfdr.de>; Thu, 22 May 2025 15:58:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b38y13ccRz3c3D;
	Thu, 22 May 2025 23:58:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747922281;
	cv=none; b=AcKqe5Ei/Jh1GTSQz3kjr+jgTsbuWD6u2VaqTW45FpsykF16sVs9PlzjbTrr8MugvMONnotNAkiFO4pCH7vnPc4smvTOMEeNhskOmlDZOKEmjQM8yD4fUTAfbsc0sJkJJBUUJaNB5S1bswD30QaflYZoW8onfrTSnIIPy3AJSe7gk4/VPccB+/RVsCzkC/aanIMMk0zS072NQIUHLYb1qsSZqidyx/FvsichYhBkxfn00NeZZ5ZX59Z/NnvYlUBwrRkicKKyCcX1d9qd0RqBuhz7seD3q6H7cI+FMR/U4Y+uFoBzKADsLAj+tApT6N3e+CuIQdzBwxp07z0i6mPnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747922281; c=relaxed/relaxed;
	bh=3xZ8jwGsi/eL13/Xb/CQQiFqBGVRNebRbqt4x6Yg5RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI+2nEf/vXsK1oYKYG55No+6hh/xhRMEkywVCyfTcKPs2QUrHVaedYNMtkTrX64ZHOsgjLu5Dsb1lqQGhwfODgJ3u0/BMhwKqnFZ6lSOhz3CkgjC334AqODlrvX2tb/60kSB1tFe2F/MB/CxyMCtJ0Yq6mzQyGwafhgOUNNM/PMm9f3CZHnfXV8c0WWots6fvhBkrRsX4a/gNtXstQ9ygZapXLtiwsWLzPt91ZJnUS6b6CyjZ/PYPGwx3hcYC5cq9Oh0ZIbphLNxxhX73ZYhSOI6wfcJ1GUbwx0SySqcEw84dITIzUUydJqijEZ0UgvEQFushAJ+pxXcX+iE7wClew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rIqE4FsP; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rIqE4FsP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b38y04yMRz2yx8
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 May 2025 23:58:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 186625C5861;
	Thu, 22 May 2025 13:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CB5C4CEF1;
	Thu, 22 May 2025 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747922277;
	bh=HooZtgA0GXfLrsEzQyuwTezmlNya06buDn/rvsVgz/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rIqE4FsPeocARzXZvFtzi55Zdxf89qXdNvy4cal5n/cYTfbQ8YiKb81N+XL45Se90
	 XTfSB58d2Qd3G3HJv/U+/N/g3iuRju+f25QwEyUA+aFgK4a1mn0qQ1QBrLQKa7xBan
	 uCKnhhUG1Ak3Q6gBrmO/HFD6xxi7UtNaZSOp+qJmd4TSpnQG0DCICtYs8kmTflfk0P
	 wF6IZwuzjJO2yWizHBArT35qhGjzC2t10iXQTm1QrpiKwKhn64/7bmtsVvW6U+FjQ2
	 kt7PpuQ+WsfD76VYvy7aLPss2s+fqcapJpcXdSWXPtBKQCu30UQiHyDaVIutCTwYu3
	 WPjjIaxlb/+6g==
Date: Thu, 22 May 2025 21:57:51 +0800
From: Gao Xiang <xiang@kernel.org>
To: Bo Liu <liubo03@inspur.com>
Cc: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] erofs: support deflate decompress by using Intel QAT
Message-ID: <aC8tX4u/EFe8XsVP@debian>
Mail-Followup-To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20250522094931.28956-1-liubo03@inspur.com>
 <2f0e05c0-fe6b-4e84-9ef5-c33ecc43d81c@linux.alibaba.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f0e05c0-fe6b-4e84-9ef5-c33ecc43d81c@linux.alibaba.com>
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, May 22, 2025 at 05:52:32PM +0800, Gao Xiang wrote:
> 
> 
> On 2025/5/22 17:49, Bo Liu wrote:
> > This patch introdueces the use of the Intel QAT to decompress compressed
> > data in the EROFS filesystem, aiming to improve the decompression speed
> > of compressed datea.
> > 
> > We created a 285MiB compressed file and then used the following command to
> > create EROFS images with different cluster size.
> >       # mkfs.erofs -zdeflate,level=9 -C16384
> > 
> > fio command was used to test random read and small random read(~5%) and
> > sequential read performance.
> >       # fio -filename=testfile  -bs=4k -rw=read -name=job1
> >       # fio -filename=testfile  -bs=4k -rw=randread -name=job1
> >       # fio -filename=testfile  -bs=4k -rw=randread --io_size=14m -name=job1
> > 
> > Here are some performance numbers for reference:
> > 
> > Processors: Intel(R) Xeon(R) 6766E(144 core)
> > Memory:     521 GiB
> > 
> > |-----------------------------------------------------------------------------|
> > |           | Cluster size | sequential read | randread  | small randread(5%) |
> > |-----------|--------------|-----------------|-----------|--------------------|
> > | Intel QAT |    4096      |    538  MiB/s   | 112 MiB/s |     20.76 MiB/s    |
> > | Intel QAT |    16384     |    699  MiB/s   | 158 MiB/s |     21.02 MiB/s    |
> > | Intel QAT |    65536     |    917  MiB/s   | 278 MiB/s |     20.90 MiB/s    |
> > | Intel QAT |    131072    |    1056 MiB/s   | 351 MiB/s |     23.36 MiB/s    |
> > | Intel QAT |    262144    |    1145 MiB/s   | 431 MiB/s |     26.66 MiB/s    |
> > | deflate   |    4096      |    499  MiB/s   | 108 MiB/s |     21.50 MiB/s    |
> > | deflate   |    16384     |    422  MiB/s   | 125 MiB/s |     18.94 MiB/s    |
> > | deflate   |    65536     |    452  MiB/s   | 159 MiB/s |     13.02 MiB/s    |
> > | deflate   |    131072    |    452  MiB/s   | 177 MiB/s |     11.44 MiB/s    |
> > | deflate   |    262144    |    466  MiB/s   | 194 MiB/s |     10.60 MiB/s    |
> > 
> > Signed-off-by: Bo Liu <liubo03@inspur.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 

BTW, the commit message has been updated to v4 version to
fix some typos:

https://lore.kernel.org/r/20250521100326.2867828-1-hsiangkao@linux.alibaba.com

Thanks,
Gao Xiang

