Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9914277B2
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Oct 2021 08:12:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HRF8J5bnWz2yws
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Oct 2021 17:12:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BDan8AMW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BDan8AMW; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HRF8G0V6Sz2yS3
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Oct 2021 17:12:13 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ACC360F6B;
 Sat,  9 Oct 2021 06:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633759931;
 bh=qLSBBQ632nMCyxb242DdPSgRnLk6kzPo4o6DPvL6XS0=;
 h=Date:From:To:Cc:Subject:From;
 b=BDan8AMWRkWYmREExxCThNh7NYAer663r7L2Q2y9m+q8Up6CtIlKZdAK3YNLVg2UH
 YdrtnWoYhC0o+aYYvW0dMY0WfSzCUZuLr7VtFw67KJA/L081oKCo90sI2wlAY+qakJ
 jMbaGITm6BVEo3tFzltAjjXsx+b4wG4km+ZIQNAlBVX8SeK3TvcfMIs1X0it/c8kh+
 IBF+tUPl7IOW5C2zqEhrbE7cJVAbRP0QIiflB8NAbg5Fa1+em9ZLZYStPFJGH3v4QU
 AiwcCzIYQXHblP0FmZ4X/7e1Yd6Tlz/AYuVXqgGr9DPnagfd4VvxvrvpA03tpoX2US
 5S56vOeATN0TQ==
Date: Sat, 9 Oct 2021 14:11:51 +0800
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: EROFS roadmap update
Message-ID: <20211009061150.GA7479@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Lasse Collin <lasse.collin@tukaani.org>, Yue Hu <huyue2@yulong.com>,
 Yan Song <imeoer@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Miao Xie <miaoxie@huawei.com>,
 Guo Xuenan <guoxuenan@huawei.com>, Qi Wang <mpiglet@outlook.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, kernel-team@android.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: kernel-team@android.com, Lasse Collin <lasse.collin@tukaani.org>,
 Yan Song <imeoer@linux.alibaba.com>, Greg KH <gregkh@linuxfoundation.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 Qi Wang <mpiglet@outlook.com>, Changwei Ge <chge@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Liu Jiang <gerry@linux.alibaba.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

As you may noticed, I'm working on several different stuffs for the
upcoming 5.16 Linux kernel, which including multiple device support
for multi-layer container images for runc and kata-likewise containers
and LZMA algorithm support (I'll send out the formal patchset this
week.)

Here is the EROFS roadmap in the near/mid term as far as I know:

Container use cases:
 - Multiple device/blob support (v5.16, me);

 - Other stuffs working in progress (our whole team, mainly working
   in the form of new RAFS v6 format which is an EROFS-compatible
   format for nydus [1] container image service later.)

Embedded device use cases:
 - LZMA compression support, specifically MicroLZMA (v5.16, me with
   Lasse kind help/support) with complete in-place I/O and overlapped
   decompression (for embedded boards or a secondary auxiliary
   algorithm in a file as a complement for specific access patterns):
   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git -b erofs/lzma

 - Tail-packing inline for compression files (AFAIK, Yue Hu is
   currently working on this new feature);

 - LZ4 range dictionary support (v5.xx?), which works in a way to
   seperate a file into several sub-file segments and add a
   external dictionary for each segment (4KiB dictionary for 2MiB
   segment for example), I can see the benefits for specific datasets
   and have some DEMO compressor code for this, for example:
     enwik9			1000000000
     enwik9_4k.erofs.img	 558346240
     enwik9_4k.dict.erofs.img	 449683456 (2MiB segs with 8KiB dicts);
     enwik9_4k.dict.erofs.img	 400093184 (1MiB segs with 32KiB dicts);
     ...

   https://github.com/hsiangkao/erofs-utils.git -b experimental-dictdemo

   I'd like to try to seek some potential volunteer who could also be
   interested in this kind of stuffs to optimize compression ratios
   for specific data patterns (Note that it's not a free lunch since you
   need to keep the whole dictionaries in memory before decompressing
   any data in the specific range, and again it doesn't work for all
   datasets [compared with LZMA] as far as I observed and the dictionary
   build time is relative slow);

 - Multi-threaded compression for mkfs, including file level paralleled
   compression and sub-file level paralleled compression. File level
   paralleled compression is trivial to think and sub-file level
   paralleled compression approach is quite similar to range
   dictionaries, separate the files into several segments (e.g. 16MiB)
   and compress each individually in parallel;

Others:
 - dump.erofs (AFAIK, Wang Qi / Guo Xuenan is working on this?)
   https://lore.kernel.org/r/OSZP286MB07097AE45E9D391B0049F661B2A89@OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
 - partial page up-to-date support and corresponding read interface;
 - code cleanup / simplification;
 - etc..

[1] https://github.com/dragonflyoss/image-service

Thanks,
Gao Xiang
