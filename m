Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C444547BFB
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Jun 2022 22:32:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LLmZn2PX4z3c85
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jun 2022 06:32:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a/z2IWkp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a/z2IWkp;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LLmZf2TwLz3bpy
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jun 2022 06:31:54 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 5D15DB80CA0;
	Sun, 12 Jun 2022 20:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661B0C34115;
	Sun, 12 Jun 2022 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655065908;
	bh=AyOwRz/gKBKScbBHHI/YAvxa737PnezhWjLreCbZODo=;
	h=Date:From:To:Cc:Subject:From;
	b=a/z2IWkpd5qV4cXB2TknZUAP2iLaBhTIFTWqXbmHzugQvgU47X/gYznY5rgduL8uV
	 oqD5fyuvOCgbhCGLTMInBvip7PDzEopF+ENjU9x/mmwOKMKXHqLoXOQ0r0tT/pHn5g
	 dmCHhtFKopgQF3fYxhX+fa0I3MRPiwRECIoaV5YiRLgxVWPqr1jdgNxZnxgmq2iW8T
	 U47Ygdpr1XdHEhOZ7ZXBvXiqSu2CSytsTJptHm2hgYHVnFifR8ApohCOh8IRhDAUX0
	 HAMyepx9uPLj6SDKcJMewaVduj9JjzT/W/v1w2BORmO2vHURz/iK0oWEKjkm2TjCgM
	 7MSvhrJyZ1f2A==
Date: Mon, 13 Jun 2022 04:31:34 +0800
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [ANNOUNCE] erofs-utils: release 1.5
Message-ID: <YqZNJpgQ+xLSHBqK@debian>
Mail-Followup-To: linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-team@android.com, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

A new version erofs-utils 1.5 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.5

It mainly includes the following changes:
   - (fsck.erofs) support filesystem extraction (Igor Ostapenko);
   - support ztailpacking inline feature for compressed files (Yue Hu);
   - (dump.erofs) support listing directories;
   - more liberofs APIs (including iterate APIs) (me, Kelvin Zhang);
   - use mtime to allow more control over the timestamps (David Anderson);
   - switch to GPL-2.0+ OR Apache-2.0 dual license for liberofs;
   - various bugfixes and cleanups;


A little bit delay this time for more than half a year.  This release
mainly includes ztailpacking feature by Yue Hu which can inline the
tail pcluster with its inode metadata thus save space and a tail I/O,
it's highly recommended to be enabled if possible.

Apart from that, fsck.erofs now supports extracting filesystem, thanks
to Igor Ostapenko.  There are other changes listed above.


In the end, I'd like to update the roadmap of EROFS since the last
update for the coming year:

https://lore.kernel.org/r/20211009061150.GA7479@hsiangkao-HP-ZHAN-66-Pro-G1

Thankfully many of them are finished during the past year.


1. Common stuffs:

 - Switch to folios and enable large folios if possible in the next
   cycles;

 - Get rid of PG_error flag in Linux 5.20 (pending review);

 - Explore byte-addressed rolling hash compression + deduplication since
   on-disk format already supports such way but needs runtime tuning;

 - LZ4 range dictionary support.  We don't have enough manpower on this
   yet, but hopefully it can have some progress in the coming year;

 - Further code cleanups.


2. Container image use cases:

 - Recently, we posted a article to introduce erofs over fscache
   feature working with CNCF Dragonfly Nydus image service and give
   some performance numbers.

     https://d7y.io/blog/2022/06/06/evolution-of-nydus/

   Our Alibaba kernel team are still working on several stuffs about
   Nydus image service and fscache, including:

    - Better flexible cache management, including repacking and blob
      GC in order to make better use to the local cache database;

    - Convert and run (e)stargz and others on the fly with fscache
      feature.  In the future, different formats are also able to be
      merged in one fs tree:
      https://github.com/dragonflyoss/image-service/pull/486

    - Runtime decompression support over fscache;

    - Blob cache sharing within the same trusted domain;

    - Page cache sharing between different files with the same chunk;

    - Enhanced convergent encryption to share chunk data in a trusted
      domain and runtime verification;

    - And other fscache/cachefiles common improvements like fallback
      format, multiple daemons/dirs, FSDAX, etc.

 - Apart from Nydus, it's planned to introduce a native fscache daemon
   integrated in erofs-utils to mount EROFS, (e)stargz images from
   network as well as provide fscache interfaces as liberofs APIs.


3. Embedded devices

 - Yue Hu is currently working on a fragment-likewise feature, which
   can merged tails or the whole files into a special inode in order to
   minimize the space;

 - Multi-threaded mkfs, fsck.erofs.  I know someone is working on this
   but I'm not sure the current progress.  It's a bit delay but needs
   to be resolved anyway.


Thanks,
Gao Xiang
