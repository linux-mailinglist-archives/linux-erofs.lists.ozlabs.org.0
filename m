Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4CF8ACE01
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 15:17:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=0DhjKutF;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FxSHcdRu;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNQlh0JxBz3ck9
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 23:17:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=0DhjKutF;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FxSHcdRu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=themaw.net (client-ip=64.147.123.157; helo=wfhigh6-smtp.messagingengine.com; envelope-from=raven@themaw.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 422 seconds by postgrey-1.37 at boromir; Mon, 22 Apr 2024 23:17:23 AEST
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNQlR62Whz3cRB
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 23:17:22 +1000 (AEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id BDBB0180010C;
	Mon, 22 Apr 2024 09:10:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Apr 2024 09:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1713791416;
	 x=1713877816; bh=ywBPeknS4muGxnOz3GGKr9587hsha7l5cTt5LmYesv8=; b=
	0DhjKutF+ugNpnYqvbdWGczgmcm/fvpwkRhQXeXjYmYdTXSGgDL2suZixBE4LdGm
	EXp/dGCD6VDiGe1jHxzIOC6zahiDJajkPwYEkkcM1MFZKfrK4R39zAQrbqzgSXeE
	nQemo44f7zwg9eO7/bwVzN7llq7ZdNoQhwVq940AdSzJEUlp+geuXE0Bfvwrnhjk
	UmUCEDIeOY+wo5kK73NqGKAHFCNKgL/4Dw9KitL1Eeonkryx7Q7yYqWgefHVrP2T
	qSpJF5y2UzN+YB2qSBecrI06py5/XKOQQ/9lIj3F4CRUJn3VPnU++YLNhR/lObfi
	2SMbkA6UWpxnbfzhvMZRPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713791416; x=
	1713877816; bh=ywBPeknS4muGxnOz3GGKr9587hsha7l5cTt5LmYesv8=; b=F
	xSHcdRu8xws0IsXb8yMHm9lHHF0vSgXPP/Wjrr5lCjeqDA27RhU79iB/8SGS89dT
	08fpj9X22caJMhijbROYlUkazedKwJzjfPu4ia1UXOznf6VCbHaOuXF2afTizdXR
	dxPb5KL4YjA7Dk0dlXpxypwVbGCzzr9Q4+DVpmzBi6XY9z4Fm1STkunbOTw1Tq5J
	/0B0ONw6ZVSvS+15qzCyLGWciar3+83sHz/98jaVd3JuZRNlTqehvkBx/QYj6L36
	LXSMw/KAgPUoGPv0uAkUTUUi1oCl76L+pYDu5kM7dE/JIhPfFluKOO8BL4c0CVVg
	N4EWSy5KZ+3HLz3iCViZg==
X-ME-Sender: <xms:t2EmZjxtnN3DK8Jcb9qrxEqAIGSfkNm_XI69MptpYGovbQGIl4z9Ow>
    <xme:t2EmZrSGBOnMrtafuwFnEq2Id5MJLJGx_ZUiVgnPeIGM-Tg1bus9GVjS-gsfZGq02
    ZnHf0vMad6K>
X-ME-Received: <xmr:t2EmZtVqQ4XE42NLjY95CvAGRpzBVUkVBJD606FUIytlRQkSAojPo-o2NdI8QejgQs_nH2MHmSEbG1kqbSELuD2S4cYvDMu53wmyaI7pT22Bj3bCFYvkzgSZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttddvjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eiudeiledvtdfgheeglefgfeetleejfffhgfdvheevtdeigefffeekjeffvdejieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:t2EmZthG78aieEOLHGpF0vlg1W7wi8GGfDhDEfD5FbCPu8mvtLITlw>
    <xmx:t2EmZlD-6oi8aaL4zpJHf3l6wizm-wDhraZ6_mOh-CTRQgkY2QBreQ>
    <xmx:t2EmZmLEML92fVc8Vp-hbIvCXERGqZ2SeG9uYjYey2S7AB7oELGrDQ>
    <xmx:t2EmZkA7KbFd4ECw9pHozxWnkN3_3h4EnT4SYA6gAfgOrMP5XKnX9w>
    <xmx:uGEmZoOFmcgwKo7QXscJOewkwxyBJgHM_N3fOhibjS_l5WG_ATYu9BPZ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 09:10:13 -0400 (EDT)
Message-ID: <4ea8c79f-93c1-410c-9580-8f37e84f8548@themaw.net>
Date: Mon, 22 Apr 2024 21:10:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trying to work with the tests
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20d564ff-bc61-42ef-ada2-2c2433f362fa@themaw.net>
 <e81eda7a-5bc8-49dd-ab68-029f7ecab0b5@linux.alibaba.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <e81eda7a-5bc8-49dd-ab68-029f7ecab0b5@linux.alibaba.com>
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

On 22/4/24 17:12, Gao Xiang wrote:
> Hi Ian,
>
> (+Cc Jingbo here).
>
> On 2024/4/22 16:31, Ian Kent wrote:
>> I'm new to the list so Hi to all,
>>
>>
>> I'm working with a heavily patched 5.14 kernel and I've gathered 
>> together patches to bring erofs
>>
>> up to 5.19 and I'm trying to run the erofs and fscache tests from a 
>> checkout of the 1.7.1 repo.
>>
>> (branch experimental-tests-fscache) and I have a couple of fails I 
>> can't quite work out so I'm
>>
>> hoping for a little halp.
>
> Thanks for your interest and provide the detailed infos.
>
> I guess a modified 5.14 kernel may be originated from RHEL 9?

Yes, that's right.

I am working on improving erofs support in RHEL which of course goes via 
CentOS Stream 9.


>
> I have a plan to backport the latest EROFS to CentOS stream 9, but
> currently I'm busy in internal stuffs, so it's still a bit delayed...

Right, Eric mentioned you were keen to help out.


The full back port is a bit much to do in one step, I'd like to let it 
settle for a minor release before considering

further back port effort. Of course any assistance is also welcome if 
and when you have time.


I must admit posting to the list is as much to introduce myself as it is 
to get a little help and advice.


>
>>
>>
>> For those familiar with erofs development and history it may look 
>> like some patches are missing
>>
>> but they may have already been present in the source tree I'm working 
>> with ... so just ask if
>>
>> you spot anything ...
>>
>>
>> Current set of patches I have is (the patch name corresponds to 
>> commit title, more or less):
>>
>> + erofs-clear-compacted_2b-if-compacted_4b_initial-gt-totalidx.patch
>> + erofs-add-support-for-the-full-decompressed-length.patch
>> + erofs-add-fiemap-support-with-iomap.patch
>> + 
>> erofs-remove-the-mapping-parameter-from-erofs_try_to_free_cached_page.patch
>> + erofs-directly-use-wrapper-erofs_page_is_managed-when-shrinking.patch
>> + erofs-dax-support-for-non-tailpacking-regular-file.patch
>> + erofs-fix-deadlock-when-shrink-erofs-slab.patch
>> + erofs-remove-useless-cache-strategy-of-DELAYEDALLOC.patch
>> + erofs-fix-unsafe-pagevec-reuse-of-hooked-pclusters.patch
>> + erofs-remove-the-fast-path-of-per-CPU-buffer-decompression.patch
>> + erofs-decouple-basic-mount-options-from-fs_context.patch
>> + erofs-add-multiple-device-support.patch
>> + erofs-get-compression-algorithms-directly-on-mapping.patch
>> + erofs-introduce-the-secondary-compression-head.patch
>> + erofs-introduce-readmore-decompression-strategy.patch
>> + erofs-rename-some-generic-methods-in-decompressor.patch
>> + 
>> libxz-Avoid-overlapping-memcpy-with-invalid-input-with-in-place-decompression.patch
>> + libxz-Add-MicroLZMA-decoder.patch
>> + erofs-lzma-compression-support.patch
>> + erofs-get-rid-of-lru-usage.patch
>> + erofs-dont-trigger-WARN-when-decompression-fails.patch
>> + erofs-rename-lz4_0pading-to-zero_padding.patch
>> + erofs-add-sysfs-interface.patch
>> + erofs-add-sysfs-node-to-control-sync-decompression-strategy.patch
>> + erofs-Replace-zero-length-array-with-flexible-array-member.patch
>> + erofs-clean-up-erofs_map_blocks-tracepoints.patch
>> + erofs-tidy-up-z_erofs_lz4_decompress.patch
>> + erofs-introduce-z_erofs_fixup_insize.patch
>> + erofs-support-unaligned-data-decompression.patch
>> + erofs-support-inline-data-decompression.patch
>> + erofs-add-on-disk-compressed-tail-packing-inline-support.patch
>> + erofs-introduce-meta-buffer-operations.patch
>> + erofs-use-meta-buffers-for-inode-operations.patch
>> + erofs-use-meta-buffers-for-super-operations.patch
>> + erofs-use-meta-buffers-for-xattr-operations.patch
>> + erofs-use-meta-buffers-for-zmap-operations.patch
>> + erofs-fix-fsdax-partition-offset-handling.patch
>> + erofs-avoid-unnecessary-z_erofs-decompressqueue_work-declaration.patch
>> + erofs-fix-small-compressed-files-inlining.patch
>> + erofs-fix-ztailpacking-on-gt-4GiB-filesystems.patch
>> + erofs-use-meta-buffers-for-erofs_read_superblock.patch
>> + erofs-get-rid-of-struct-z_erofs_collector.patch
>> + erofs-clean-up-preload_compressed_pages.patch
>> + erofs-silence-warnings-related-to-impossible-m_plen.patch
>> + erofs-clean-up-z_erofs_extent_lookback.patch
>> + erofs-refine-managed-inode-stuffs.patch
>> + erofs-add-sanity-check-0for-kobject-in-erofs_unregister_sysfs.patch
>> + erofs-use-meta-buffers-for-reading-directories.patch
>> + erofs-use-meta-buffers-for-inode-lookup.patch
>> + erofs-rename-ctime-to-mtime.patch
>> + erofs-Convert-from-invalidatepage-to-invalidate_folio.patch
>> + erofs-fix-use-after-free-of-on-stack-io.patch
>> + erofs-Convert-erofs-zdata-to-read_folio.patch
>> + erofs-Convert-to-release_folio.patch
>> + erofs-do-not-prompt-for-risk-any-more-when-using-big-pcluster.patch
>> + erofs-remove-obsoleted-comments.patch
>> + erofs-refine-on-disk-definition-comments.patch
>> + erofs-fix-buffer-copy-overflow-of-ztailpacking-feature.patch
>> + erofs-make-filesystem-exportable.patch
>> + erofs-support-idmapped-mounts.patch
>> + cachefiles-document-on-demand-read-mode.patch
>> + erofs-make-erofs_map_blocks-generally-available.patch
>> + erofs-add-fscache-mode-check-helper.patch
>> + erofs-register-fscache-volume.patch
>> + erofs-add-fscache-context-helper-functions.patch
>> + erofs-add-anonymous-inode-caching-metadata-for-data-blobs.patch
>> + erofs-add-erofs_fscache_read_folios-helper.patch
>> + erofs-register-fscache-context-for-primary-data-blob.patch
>> + erofs-register-fscache-context-for-extra-data-blobs.patch
>> + erofs-implement-fscache-based-metadata-read.patch
>> + erofs-implement-fscache-based-data-read-for-non-inline-layout.patch
>> + erofs-implement-fscache-based-data-read-for-inline-layout.patch
>> + erofs-implement-fscache-based-data-readahead.patch
>> + erofs-add-fsid-mount-option.patch
>> + 
>> erofs-change-to-use-asynchronous-io-for-fscache-readpage_readahead.patch
>> + erofs-scan-devices-from-device-table.patch
>> + 
>> erofs-leave-compressed-inodes-unsupported-in-fscache-mode-for-now.patch
>> + erofs-fix-crash-when-enable-tracepoint-cachefiles_prep_read.patch
>> + erofs-get-rid-of-struct-z_erofs_collection.patch
>> + erofs-get-rid-of-label-restart_now.patch
>> + erofs-simplify-z_erofs_pcluster_readmore.patch
>> + erofs-fix-backmost-member-of-z_erofs_decompress_frontend.patch
>> + erofs-missing-hunks.patch
>>
>>
>> The last patch consists of what looks like a few hunks added by Linus 
>> to complete a folio pull
>>
>> request that came in at the same time as the 5.19 erofs merge 
>> request. I know the list of
>>
>> patches isn't very useful but it should give some idea of what I have 
>> and maybe someone can
>>
>> spot a missing patch or so.
>>
>>
>> Anyway, my failing tests are erofs/021, erofs/022, erofs/024 and 
>> fscache/005.
>
> I guess the following failure fails as expected:
> erofs/021  -- uncompressed sub-page block sizes (esp. 512-byte block 
> sizes, since v6.4)
> erofs/022  -- long xattr prefix (since v6.4)

Yes, I saw this was xattr related.


There have been quite a lot of back ports done in the current RHEL 
kernel and I'm planning on working on

some VFS back ports too. But the VFS is so very spread out over several 
areas I'm probably going to need

to restrict my scope somewhat. I'll see what I can find regarding xattrs 
on my journey.

But you mention 6.4 so that's quite a long way ahead so I might leave 
that to the next release too ...


> erofs/024 -- deflate algorithm support (since v6.6)

Ok, I hadn't spotted that yet.

Thanks, deflate support sounds a bit far off too, at least for now.


>
> So these failures can be skipped on your side, I think I need to modify
> these tests for gracefully skipping ... That is also why all testcases
> are marked as "experimental" :-)

Sure, but having any tests at all is really useful when back porting 
changes.

I really appreciate the fact they are present at all.


Ian

>
> I'm not quite sure why "fscache/005" fails, hopefully Jingbo could
> help you on this.
>
> Thanks!
> Gao Xiang
>
>>
>> erofs/018 does not run due to "lzma compression is disabled, 
>> skipped." message which I think
>>
>> is too old a version of xz.
>>
>>
>> Any insight into cases that could cause these tests to fail would be 
>> much appreciated.
>>
>>
>> Ian
>>
>>
