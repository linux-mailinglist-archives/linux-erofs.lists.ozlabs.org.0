Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3517B0693
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Sep 2023 16:20:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=CkBM6OEM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rwdzh6ncBz3cDS
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Sep 2023 00:20:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=CkBM6OEM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.dk (client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com; envelope-from=axboe@kernel.dk; receiver=lists.ozlabs.org)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rwdzb2s0pz3c5K
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Sep 2023 00:19:52 +1000 (AEST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bfe9447645so40486271fa.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 27 Sep 2023 07:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695824379; x=1696429179; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wwk46okUDVQfnnelgDDAXJI2PyNHcNwKe3ka13udWbU=;
        b=CkBM6OEM89n3CYlSHhVanmjGiOrBG27oS5C6fPozaQW7oul5sRkbp4ohj+dOjFDcsb
         VOAc/dNdREBEKT+XEyLU3lDw1j0J3H5sFbEGrSsAUy9St4goV8gmRiACuEVw+Vtwn/Wh
         tgLSp7DE65Vp7e8pxLmyeLyht8XhPf85vH545peqw/5TYpn7JbuF3ocYwJIW1jt2uCVV
         L/7XfiHKaW0+7Or9L27TzCEs/XQQ/BRN/r8QasENa+zg3r1+pNBaQmuqlVXR4WfhuXS8
         oQftpaPfx/2x89GH2FcYLuDv5GT9dSvZKVOm49fUKupsiUkWB539AtxldvEyyvXb7qsZ
         d+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824379; x=1696429179;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwk46okUDVQfnnelgDDAXJI2PyNHcNwKe3ka13udWbU=;
        b=oZxPUh2HShqkr19G9iukBg0qgq7r5ZN4bbTf4USVNslLjwWSlRE2MuHRzSlhJAzDHm
         Adl7oXfGvK21uUSL6IuH9423EoeQ8ypwVt7XPt7CP18AUoNn/JWj3Vl4o5cwdtOysXeg
         EiJ9aaR2jx8POu+IB/R9uZ5jyKRWROUAcbMXRQT+xnnCSbx7GugBUlI0pLatFMdhYq2s
         et9TenyvHGC35LMcK2UvoWLLkcsyyYgBwTSGTWhcM2P7Eo4nLh/fq+Aj6/x3qknpGedu
         KiTI2tox9ZHcAeig/OKb2LDH2H6P0jDyH2afRQUkmd9RKzhMAL7iE9iqVarozGrihqyV
         Vr6A==
X-Gm-Message-State: AOJu0YxPn3PVqZHanfnM+FmTIfB0lNcNN7yjQolGycQcGVKSLJv0cUEz
	hcApW62Cm8u+VyCAPj3hB8YAVA==
X-Google-Smtp-Source: AGHT+IExVCqrFIxKzo43T8FMa/9T5rz6/xdccYRyI4cqxFk27k3RqgKqbk6x0v1Y5TMyg8NtKFdEkg==
X-Received: by 2002:a05:651c:3cf:b0:2b6:cd7f:5ea8 with SMTP id f15-20020a05651c03cf00b002b6cd7f5ea8mr1801740ljp.1.1695824378667;
        Wed, 27 Sep 2023 07:19:38 -0700 (PDT)
Received: from [172.20.13.88] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b00992b2c55c67sm9370253ejb.156.2023.09.27.07.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 07:19:37 -0700 (PDT)
Message-ID: <9cc59d88-4b77-4e56-ae54-737baca1d435@kernel.dk>
Date: Wed, 27 Sep 2023 08:19:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/29] block: Make blkdev_get_by_*() return handle
To: Jan Kara <jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
Content-Language: en-US
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
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
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, linux-nvme@lists.infradead.org, Joseph Qi <joseph.qi@linux.alibaba.com>, dm-devel@redhat.com, target-devel@vger.kernel.org, linux-mtd@lists.infradead.org, Jack Wang <jinpu.wang@ionos.com>, Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xenproject.org, Christian Borntraeger <borntraeger@linux.ibm.com>, Kent Overstreet <kent.overstreet@gmail.com>, Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, Joern Engel <joern@lazybastard.org>, linux-nfs@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@k
 ernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, linux-raid@vger.kernel.org, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, linux-mm@kvack.org, Song Liu <song@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com, Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 27, 2023 at 3:34?AM Jan Kara <jack@suse.cz> wrote:
>
> Hello,
>
> this is a v3 of the patch series which implements the idea of blkdev_get_by_*()

v4?

> calls returning bdev_handle which is then passed to blkdev_put() [1]. This
> makes the get and put calls for bdevs more obviously matching and allows us to
> propagate context from get to put without having to modify all the users
> (again!). In particular I need to propagate used open flags to blkdev_put() to
> be able count writeable opens and add support for blocking writes to mounted
> block devices. I'll send that series separately.
>
> The series is based on Btrfs tree's for-next branch [2] as of today as the
> series depends on Christoph's changes to btrfs device handling.  Patches have
> passed some reasonable testing - I've tested block changes, md, dm, bcache,
> xfs, btrfs, ext4, swap. More testing or review is always welcome. Thanks! I've
> pushed out the full branch to:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdev_handle
>
> to ease review / testing. Christian, can you pull the patches to your tree
> to get some exposure in linux-next as well? Thanks!

For the block bits:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

