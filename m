Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ACA66206F
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 09:43:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nr6sz2S8xz3bh4
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 19:43:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iWxO8EK/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iWxO8EK/;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nr6sv0YdMz2ylk
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Jan 2023 19:43:30 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A18C6B80C8D;
	Mon,  9 Jan 2023 08:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD15AC433F1;
	Mon,  9 Jan 2023 08:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673253805;
	bh=myQoVYVwu0xpFEjib9aRjzoJPSgF2dGhxXTVvYigO18=;
	h=Date:From:To:Cc:Subject:From;
	b=iWxO8EK/yv7zohUYziC5XgjaW0HbP60L2g54Fsp6NPuQhygoH4HkYc+G+slCJCOVi
	 AP+HbwLsP7ARc0f3H7V4G4Ge6gXQd5NGqjL6rAUDk4qC2zsa9eH2G3NmaN+tv8ybmh
	 xq1UQX+6fJYhLVdIsVHPiqAlhkp9X3mQGI8UA5u88PuU/tLQ95NHtStPaP/UIK+v2m
	 SPukr4mIcL6vn3LfxuCRGhtHolPxGNit4n9bJ4B6ChOp3DyxNQ5ODsqP3IjljDaQqj
	 Ao9t1/KCu+VAnpAkE7Hy/XOYLgTTI7ryri9k2pIZqqb27D06GYYZv+EBQPshNZRtHJ
	 mIDkVKpVkG2gA==
Date: Mon, 9 Jan 2023 16:43:17 +0800
From: Gao Xiang <xiang@kernel.org>
To: lsf-pc@lists.linuxfoundation.org
Subject: [LSF/MM/BPF TOPIC] Image-based read-only filesystem: further use
 cases & directions
Message-ID: <Y7vTpeNRaw3Nlm9B@debian>
Mail-Followup-To: lsf-pc@lists.linuxfoundation.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
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
Cc: linux-fsdevel@vger.kernel.org, kernel-team@android.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

* Background *

We've been continuously working on forming a useful read-only
(immutable) image solution since the end of 2017 (as a part of our
work) until now as everyone may know:  EROFS.

Currently it has already successfully landed to (about) billions of
Android-related devices, other types of embedded devices and containers
with many vendors involved, and we've always been seeking more use
cases such as incremental immutable rootfs, app sandboxes or packages
(Android apk? with many duplicated libraries), dataset packages, etc.

The reasons why we always do believe immutable images can benefit
various use cases are:

  - much easier for all vendors to ship/distribute/keep original signing
    (golden) images to each instance;

  - (combined with the writable layer such as overlayfs) easy to roll
    back to the original shipped state or do incremental updates;

  - easy to check data corruption or do data recovery (no matter
    whether physical device or network errors);

  - easy for real storage devices to do hardware write-protection for
    immutable images;

  - can do various offline algorithms (such as reduced metadata,
    content-defined rolling hash deduplication, compression) to minimize
    image sizes;

  - initrd with FSDAX to avoid double caching with advantages above;

  - and more.

In 2019, a LSF/MM/BPF topic was put forward to show EROFS initial use
cases [1] as the read-only Android rootfs of a single instance on
resource-limited devices so that effective compression became quite
important at that time.


* Problem *

In addition to enhance data compression for single-instance deployment,
as a self-contained approach (so that all use cases can share the only
_one_ signed image), we've also focusing on multiple instances (such as
containers or apps, each image represents a complete filesystem tree)
all together on one device with similar data recently years so that
effective data deduplication, on-demand lazy pulling, page cache
sharing among such different golden images became vital as well.


* Current progresses *

In order to resolve the challenges above, we've worked out:

  - (v5.15) chunk-based inodes (to form inode extents) to do data
    deduplication among a single image;

  - (v5.16) multiple shared blobs (to keep content-defined data) in
    addition to the primary blob (to keep filesystem metadata) for wider
    deduplication across different images:

  - (v5.19) file-based distribution by introducing in-kernel local
    caching fscache and on-demand lazy pulling feature [2];

  - (v6.1) shared domain to share such multiple shared blobs in
    fscache mode [3];

  - [RFC] preliminary page cache sharing between diffenent images [4].


* Potential topics to discuss *

  - data verification of different images with thousands (or more)
    shared blobs [5];

  - encryption with per-extent keys for confidential containers [5][6];

  - current page cache sharing limitation due to mm reserve mapping and
    finer (folio or page-based) page cache sharing among images/blobs
    [4][7];

  - more effective in-kernel local caching features for fscache such as
    failover and daemonless;

  - (wild preliminary ideas, maybe) overlayfs partial copy-up with
    fscache as the upper layer in order to form a unique caching
    subsystem for better space saving?

  - FSDAX enhancements for initial ramdisk or other use cases;

  - other issues when landing.


Finally, if our efforts (or plans) also make sense to you, we do hope
more people could join us, Thanks!

[1] https://lore.kernel.org/r/f44b1696-2f73-3637-9964-d73e3d5832b7@huawei.com
[2] https://lore.kernel.org/r/Yoj1AcHoBPqir++H@debian
[3] https://lore.kernel.org/r/20220918043456.147-1-zhujia.zj@bytedance.com
[4] https://lore.kernel.org/r/20230106125330.55529-1-jefflexu@linux.alibaba.com
[5] https://lore.kernel.org/r/Y6KqpGscDV6u5AfQ@B-P7TQMD6M-0146.local
[6] https://lwn.net/SubscriberLink/918893/4d389217f9b8d679
[7] https://lwn.net/Articles/895907

Thanks,
Gao Xiang
