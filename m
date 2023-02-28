Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224356A52D9
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 07:12:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PQn8L6sjpz3c46
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 17:12:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PQn8G2kMJz303P
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Feb 2023 17:12:13 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vchu..g_1677564727;
Received: from 30.221.130.157(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vchu..g_1677564727)
          by smtp.aliyun-inc.com;
          Tue, 28 Feb 2023 14:12:08 +0800
Message-ID: <27a19638-5d53-beb6-b7f3-4d88035538f7@linux.alibaba.com>
Date: Tue, 28 Feb 2023 14:12:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] Image-based read-only filesystem: further use
 cases & directions
Content-Language: en-US
To: lsf-pc@lists.linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
References: <Y7vTpeNRaw3Nlm9B@debian>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <Y7vTpeNRaw3Nlm9B@debian>
Content-Type: text/plain; charset=UTF-8
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



On 1/9/23 4:43 PM, Gao Xiang wrote:
> Hi folks,
> 
> * Background *
> 
> We've been continuously working on forming a useful read-only
> (immutable) image solution since the end of 2017 (as a part of our
> work) until now as everyone may know:  EROFS.
> 
> Currently it has already successfully landed to (about) billions of
> Android-related devices, other types of embedded devices and containers
> with many vendors involved, and we've always been seeking more use
> cases such as incremental immutable rootfs, app sandboxes or packages
> (Android apk? with many duplicated libraries), dataset packages, etc.
> 
> The reasons why we always do believe immutable images can benefit
> various use cases are:
> 
>  - much easier for all vendors to ship/distribute/keep original signing
>    (golden) images to each instance;
> 
>  - (combined with the writable layer such as overlayfs) easy to roll
>    back to the original shipped state or do incremental updates;
> 
>  - easy to check data corruption or do data recovery (no matter
>    whether physical device or network errors);
> 
>  - easy for real storage devices to do hardware write-protection for
>    immutable images;
> 
>  - can do various offline algorithms (such as reduced metadata,
>    content-defined rolling hash deduplication, compression) to minimize
>    image sizes;
> 
>  - initrd with FSDAX to avoid double caching with advantages above;
> 
>  - and more.
> 
> In 2019, a LSF/MM/BPF topic was put forward to show EROFS initial use
> cases [1] as the read-only Android rootfs of a single instance on
> resource-limited devices so that effective compression became quite
> important at that time.
> 
> 
> * Problem *
> 
> In addition to enhance data compression for single-instance deployment,
> as a self-contained approach (so that all use cases can share the only
> _one_ signed image), we've also focusing on multiple instances (such as
> containers or apps, each image represents a complete filesystem tree)
> all together on one device with similar data recently years so that
> effective data deduplication, on-demand lazy pulling, page cache
> sharing among such different golden images became vital as well.
> 
> 
> * Current progresses *
> 
> In order to resolve the challenges above, we've worked out:
> 
>  - (v5.15) chunk-based inodes (to form inode extents) to do data
>    deduplication among a single image;
> 
>  - (v5.16) multiple shared blobs (to keep content-defined data) in
>    addition to the primary blob (to keep filesystem metadata) for wider
>    deduplication across different images:
> 
>  - (v5.19) file-based distribution by introducing in-kernel local
>    caching fscache and on-demand lazy pulling feature [2];
> 
>  - (v6.1) shared domain to share such multiple shared blobs in
>    fscache mode [3];
> 
>  - [RFC] preliminary page cache sharing between diffenent images [4].
> 
> 
> * Potential topics to discuss *
> 
>  - data verification of different images with thousands (or more)
>    shared blobs [5];
> 
>  - encryption with per-extent keys for confidential containers [5][6];
> 
>  - current page cache sharing limitation due to mm reserve mapping and
>    finer (folio or page-based) page cache sharing among images/blobs
>    [4][7];
> 
>  - more effective in-kernel local caching features for fscache such as
>    failover and daemonless;
> 
>  - (wild preliminary ideas, maybe) overlayfs partial copy-up with
>    fscache as the upper layer in order to form a unique caching
>    subsystem for better space saving?
> 
>  - FSDAX enhancements for initial ramdisk or other use cases;
> 
>  - other issues when landing.
> 
> 
> Finally, if our efforts (or plans) also make sense to you, we do hope
> more people could join us, Thanks!
> 
> [1]
> https://lore.kernel.org/r/f44b1696-2f73-3637-9964-d73e3d5832b7@huawei.com
> [2] https://lore.kernel.org/r/Yoj1AcHoBPqir++H@debian
> [3] https://lore.kernel.org/r/20220918043456.147-1-zhujia.zj@bytedance.com
> [4]
> https://lore.kernel.org/r/20230106125330.55529-1-jefflexu@linux.alibaba.com
> [5] https://lore.kernel.org/r/Y6KqpGscDV6u5AfQ@B-P7TQMD6M-0146.local
> [6] https://lwn.net/SubscriberLink/918893/4d389217f9b8d679
> [7] https://lwn.net/Articles/895907
> 

The past year we have a lot promising features enhanced for erofs, such
as file-based distribution and lazy pulling with fscache, share domain
feature to reduce the disk usage of cache files of fscache.

But there are still many features to be done to make it a productive and
stable system for image distribution, such as page cache sharing,
failover and daemonless for fscache, etc.

It would be great if I could join the discussion on these topics :)


-- 
Thanks,
Jingbo
