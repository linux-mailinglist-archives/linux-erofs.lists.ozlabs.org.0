Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B22B8AC899
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 11:13:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a2BsXPHf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNKKP4hj1z3cXZ
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 19:12:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a2BsXPHf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNKKF3y4xz2yPq
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 19:12:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713777162; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=q+Ip1dKz/e3PG5DUBg0LOhBB+GnQBRBoqIqlBKK1Y5I=;
	b=a2BsXPHfGxfSir6g0rcEwFEGgBvSIgwUtDh/5NeMSf50nFZjbkWb3hNM6mkN90OMqfiyTDOtm0wp8IoE6swDeQFjlztrP8xwTXzhf75v2UjvtiGIl5XsxN5UEmNzFGcFBxeyaCOuj1IWHunBXWlCeNIHTbGiGxCJMBkxIsMfy/Y=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W514bA0_1713777159;
Received: from 30.97.48.197(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W514bA0_1713777159)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 17:12:40 +0800
Message-ID: <e81eda7a-5bc8-49dd-ab68-029f7ecab0b5@linux.alibaba.com>
Date: Mon, 22 Apr 2024 17:12:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trying to work with the tests
To: Ian Kent <raven@themaw.net>, linux-erofs@lists.ozlabs.org,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20d564ff-bc61-42ef-ada2-2c2433f362fa@themaw.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20d564ff-bc61-42ef-ada2-2c2433f362fa@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Ian,

(+Cc Jingbo here).

On 2024/4/22 16:31, Ian Kent wrote:
> I'm new to the list so Hi to all,
> 
> 
> I'm working with a heavily patched 5.14 kernel and I've gathered together patches to bring erofs
> 
> up to 5.19 and I'm trying to run the erofs and fscache tests from a checkout of the 1.7.1 repo.
> 
> (branch experimental-tests-fscache) and I have a couple of fails I can't quite work out so I'm
> 
> hoping for a little halp.

Thanks for your interest and provide the detailed infos.

I guess a modified 5.14 kernel may be originated from RHEL 9?

I have a plan to backport the latest EROFS to CentOS stream 9, but
currently I'm busy in internal stuffs, so it's still a bit delayed...

> 
> 
> For those familiar with erofs development and history it may look like some patches are missing
> 
> but they may have already been present in the source tree I'm working with ... so just ask if
> 
> you spot anything ...
> 
> 
> Current set of patches I have is (the patch name corresponds to commit title, more or less):
> 
> + erofs-clear-compacted_2b-if-compacted_4b_initial-gt-totalidx.patch
> + erofs-add-support-for-the-full-decompressed-length.patch
> + erofs-add-fiemap-support-with-iomap.patch
> + erofs-remove-the-mapping-parameter-from-erofs_try_to_free_cached_page.patch
> + erofs-directly-use-wrapper-erofs_page_is_managed-when-shrinking.patch
> + erofs-dax-support-for-non-tailpacking-regular-file.patch
> + erofs-fix-deadlock-when-shrink-erofs-slab.patch
> + erofs-remove-useless-cache-strategy-of-DELAYEDALLOC.patch
> + erofs-fix-unsafe-pagevec-reuse-of-hooked-pclusters.patch
> + erofs-remove-the-fast-path-of-per-CPU-buffer-decompression.patch
> + erofs-decouple-basic-mount-options-from-fs_context.patch
> + erofs-add-multiple-device-support.patch
> + erofs-get-compression-algorithms-directly-on-mapping.patch
> + erofs-introduce-the-secondary-compression-head.patch
> + erofs-introduce-readmore-decompression-strategy.patch
> + erofs-rename-some-generic-methods-in-decompressor.patch
> + libxz-Avoid-overlapping-memcpy-with-invalid-input-with-in-place-decompression.patch
> + libxz-Add-MicroLZMA-decoder.patch
> + erofs-lzma-compression-support.patch
> + erofs-get-rid-of-lru-usage.patch
> + erofs-dont-trigger-WARN-when-decompression-fails.patch
> + erofs-rename-lz4_0pading-to-zero_padding.patch
> + erofs-add-sysfs-interface.patch
> + erofs-add-sysfs-node-to-control-sync-decompression-strategy.patch
> + erofs-Replace-zero-length-array-with-flexible-array-member.patch
> + erofs-clean-up-erofs_map_blocks-tracepoints.patch
> + erofs-tidy-up-z_erofs_lz4_decompress.patch
> + erofs-introduce-z_erofs_fixup_insize.patch
> + erofs-support-unaligned-data-decompression.patch
> + erofs-support-inline-data-decompression.patch
> + erofs-add-on-disk-compressed-tail-packing-inline-support.patch
> + erofs-introduce-meta-buffer-operations.patch
> + erofs-use-meta-buffers-for-inode-operations.patch
> + erofs-use-meta-buffers-for-super-operations.patch
> + erofs-use-meta-buffers-for-xattr-operations.patch
> + erofs-use-meta-buffers-for-zmap-operations.patch
> + erofs-fix-fsdax-partition-offset-handling.patch
> + erofs-avoid-unnecessary-z_erofs-decompressqueue_work-declaration.patch
> + erofs-fix-small-compressed-files-inlining.patch
> + erofs-fix-ztailpacking-on-gt-4GiB-filesystems.patch
> + erofs-use-meta-buffers-for-erofs_read_superblock.patch
> + erofs-get-rid-of-struct-z_erofs_collector.patch
> + erofs-clean-up-preload_compressed_pages.patch
> + erofs-silence-warnings-related-to-impossible-m_plen.patch
> + erofs-clean-up-z_erofs_extent_lookback.patch
> + erofs-refine-managed-inode-stuffs.patch
> + erofs-add-sanity-check-0for-kobject-in-erofs_unregister_sysfs.patch
> + erofs-use-meta-buffers-for-reading-directories.patch
> + erofs-use-meta-buffers-for-inode-lookup.patch
> + erofs-rename-ctime-to-mtime.patch
> + erofs-Convert-from-invalidatepage-to-invalidate_folio.patch
> + erofs-fix-use-after-free-of-on-stack-io.patch
> + erofs-Convert-erofs-zdata-to-read_folio.patch
> + erofs-Convert-to-release_folio.patch
> + erofs-do-not-prompt-for-risk-any-more-when-using-big-pcluster.patch
> + erofs-remove-obsoleted-comments.patch
> + erofs-refine-on-disk-definition-comments.patch
> + erofs-fix-buffer-copy-overflow-of-ztailpacking-feature.patch
> + erofs-make-filesystem-exportable.patch
> + erofs-support-idmapped-mounts.patch
> + cachefiles-document-on-demand-read-mode.patch
> + erofs-make-erofs_map_blocks-generally-available.patch
> + erofs-add-fscache-mode-check-helper.patch
> + erofs-register-fscache-volume.patch
> + erofs-add-fscache-context-helper-functions.patch
> + erofs-add-anonymous-inode-caching-metadata-for-data-blobs.patch
> + erofs-add-erofs_fscache_read_folios-helper.patch
> + erofs-register-fscache-context-for-primary-data-blob.patch
> + erofs-register-fscache-context-for-extra-data-blobs.patch
> + erofs-implement-fscache-based-metadata-read.patch
> + erofs-implement-fscache-based-data-read-for-non-inline-layout.patch
> + erofs-implement-fscache-based-data-read-for-inline-layout.patch
> + erofs-implement-fscache-based-data-readahead.patch
> + erofs-add-fsid-mount-option.patch
> + erofs-change-to-use-asynchronous-io-for-fscache-readpage_readahead.patch
> + erofs-scan-devices-from-device-table.patch
> + erofs-leave-compressed-inodes-unsupported-in-fscache-mode-for-now.patch
> + erofs-fix-crash-when-enable-tracepoint-cachefiles_prep_read.patch
> + erofs-get-rid-of-struct-z_erofs_collection.patch
> + erofs-get-rid-of-label-restart_now.patch
> + erofs-simplify-z_erofs_pcluster_readmore.patch
> + erofs-fix-backmost-member-of-z_erofs_decompress_frontend.patch
> + erofs-missing-hunks.patch
> 
> 
> The last patch consists of what looks like a few hunks added by Linus to complete a folio pull
> 
> request that came in at the same time as the 5.19 erofs merge request. I know the list of
> 
> patches isn't very useful but it should give some idea of what I have and maybe someone can
> 
> spot a missing patch or so.
> 
> 
> Anyway, my failing tests are erofs/021, erofs/022, erofs/024 and fscache/005.

I guess the following failure fails as expected:
erofs/021  -- uncompressed sub-page block sizes (esp. 512-byte block sizes, since v6.4)
erofs/022  -- long xattr prefix (since v6.4)
erofs/024  -- deflate algorithm support (since v6.6)

So these failures can be skipped on your side, I think I need to modify
these tests for gracefully skipping ... That is also why all testcases
are marked as "experimental" :-)

I'm not quite sure why "fscache/005" fails, hopefully Jingbo could
help you on this.

Thanks!
Gao Xiang

> 
> erofs/018 does not run due to "lzma compression is disabled, skipped." message which I think
> 
> is too old a version of xz.
> 
> 
> Any insight into cases that could cause these tests to fail would be much appreciated.
> 
> 
> Ian
> 
> 
