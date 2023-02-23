Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC856A066A
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Feb 2023 11:38:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PMqHz4bM1z3cMm
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Feb 2023 21:38:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lU8FgkKv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=yinxin.x@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lU8FgkKv;
	dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PMqHr55wMz3cCy
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Feb 2023 21:38:30 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id z2so12412730plf.12
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 Feb 2023 02:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVSa2HEsQUgf21db/3wCzFJNJMjWdnCpTJDc8PUFVUg=;
        b=lU8FgkKvew6zeeC7G69X4TxFJBb6QWZlDuZ9v7A0KzpCZLQyd29EW+Na2IinIktbsa
         3MjN3Fuwg3McSkkeOZ4E7Yohs6gz03s/dGdfUhKDTrC2pdJMfPjsX+FB6rMSohUykLiN
         VtwNNUPznaDrmtLGDMEoU1kFhT7MHvN/OFEFn/WlKJigKPpkArcaOEDC9y5m9ZxwQxon
         9UYmUk2BCOnm6xBdo7L9U7MM/56n8lPPC1lWhvv9r0iexkhYJwAF65D56uvpPtqAeIQA
         v9Y5zP8xzKuVVMgFP9mFRcciYNwRzeGbOCsEWYA5kt0z9xL1N8uI7Ga+Te/Jq1Tpa6Eb
         oGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVSa2HEsQUgf21db/3wCzFJNJMjWdnCpTJDc8PUFVUg=;
        b=kIZ6CnG8xrCZ6ZKP+2OH5sZ47oDRU2VMQg43ca0X0X/xKR9VBaP+MWmXAVjsUuSS5M
         Yzb7/c8OV64ZgTE7y8urqzPR5fNZ8r+/nQ8id/b1mL1f5u4ztRdeJ3xLzum9WiqEHJ4G
         +UC6GDEncxUyzHt7ouSILA8ndgZTWh9fX0m0gtQ9VCCHycE6WyCTsFo/RffaI0UukRxf
         FGrgkmIOS3FJigGV5x30SiF7T9aGuHoWUfdqKZ49z/4IpLJwOLZ8VDpRW2rER8ZPsCer
         kF6nkfsv3u4ZzteqrGRur6ml3tpOcIhUdMY/kngtxWyMdsWFs2zT236jJzn0RHGR1SIC
         VfKQ==
X-Gm-Message-State: AO0yUKUGHVPlTwnn4/ohE45anwWVKSycMos+yrW+Q67UnXVbiTZ9wtht
	aOlNrbhe7HIPRA4dT3yhCbpauw==
X-Google-Smtp-Source: AK7set+0jn8Cq1tdeYA8ETTeDoEUzWWKCbB49zI0EQps1JzP1Nkvgo7c6CHnCE4d8nV1/gVLsQdesw==
X-Received: by 2002:a17:902:d2ca:b0:19a:e762:a1af with SMTP id n10-20020a170902d2ca00b0019ae762a1afmr12972180plc.33.1677148705621;
        Thu, 23 Feb 2023 02:38:25 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b0019896d29197sm5639913plo.46.2023.02.23.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:38:25 -0800 (PST)
From: Xin Yin <yinxin.x@bytedance.com>
To: xiang@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Image-based read-only filesystem: further use cases & directions
Date: Thu, 23 Feb 2023 18:38:16 +0800
Message-Id: <20230223103816.2623-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y7vTpeNRaw3Nlm9B@debian>
References: <Y7vTpeNRaw3Nlm9B@debian>
MIME-Version: 1.0
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
Cc: lsf-pc@lists.linuxfoundation.org, kernel-team@android.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/1/9 16:43, Gao Xiang wrote:
> Hi folks,
> 
> * Background *
> 
> We've been continuously working on forming a useful read-only
> (immutable) image solution since the end of 2017 (as a part of our
> work) until now as everyone may know:  EROFS.
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
>   - much easier for all vendors to ship/distribute/keep original signing
>     (golden) images to each instance;
> 
>   - (combined with the writable layer such as overlayfs) easy to roll
>     back to the original shipped state or do incremental updates;
> 
>   - easy to check data corruption or do data recovery (no matter
>     whether physical device or network errors);
> 
>   - easy for real storage devices to do hardware write-protection for
>     immutable images;
> 
>   - can do various offline algorithms (such as reduced metadata,
>     content-defined rolling hash deduplication, compression) to minimize
>     image sizes;
> 
>   - initrd with FSDAX to avoid double caching with advantages above;
> 
>   - and more.
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
>   - (v5.15) chunk-based inodes (to form inode extents) to do data
>     deduplication among a single image;
> 
>   - (v5.16) multiple shared blobs (to keep content-defined data) in
>     addition to the primary blob (to keep filesystem metadata) for wider
>     deduplication across different images:
> 
>   - (v5.19) file-based distribution by introducing in-kernel local
>     caching fscache and on-demand lazy pulling feature [2];
> 
>   - (v6.1) shared domain to share such multiple shared blobs in
>     fscache mode [3];
> 
>   - [RFC] preliminary page cache sharing between diffenent images [4].
> 
> 
> * Potential topics to discuss *
> 
>   - data verification of different images with thousands (or more)
>     shared blobs [5];
> 
>   - encryption with per-extent keys for confidential containers [5][6];
> 
>   - current page cache sharing limitation due to mm reserve mapping and
>     finer (folio or page-based) page cache sharing among images/blobs
>     [4][7];
> 
>   - more effective in-kernel local caching features for fscache such as
>     failover and daemonless;
> 
>   - (wild preliminary ideas, maybe) overlayfs partial copy-up with
>     fscache as the upper layer in order to form a unique caching
>     subsystem for better space saving?
>

We also interested in these topic, page cache sharing is an exciting feature, and may can save 
a lot of memory in high-density deployment scenarios, cause we already can share blobs.

Hope to have further discussion on the failover, mutiple daemons/dirs and daemonless feature of fscache & cachefiles.
So we can have a better form for our production.

And Looking forward to the opportunity to discuss online, if I can't attend offline.

Thanks,
Xin Yin

>   - FSDAX enhancements for initial ramdisk or other use cases;
> 
>   - other issues when landing.
> 
> 
> Finally, if our efforts (or plans) also make sense to you, we do hope
> more people could join us, Thanks!
> 
> [1] https://lore.kernel.org/r/f44b1696-2f73-3637-9964-d73e3d5832b7@huawei.com
> [2] https://lore.kernel.org/r/Yoj1AcHoBPqir++H@debian
> [3] https://lore.kernel.org/r/20220918043456.147-1-zhujia.zj@bytedance.com
> [4] https://lore.kernel.org/r/20230106125330.55529-1-jefflexu@linux.alibaba.com
> [5] https://lore.kernel.org/r/Y6KqpGscDV6u5AfQ@B-P7TQMD6M-0146.local
> [6] https://lwn.net/SubscriberLink/918893/4d389217f9b8d679
> [7] https://lwn.net/Articles/895907
> 
> Thanks,
> Gao Xiang

-- 
2.25.1

