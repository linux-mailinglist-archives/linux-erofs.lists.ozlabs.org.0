Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178A5B460D
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Sep 2022 13:32:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MPrM26398z3bc8
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Sep 2022 21:32:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ZH5YuCof;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.dk (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=axboe@kernel.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ZH5YuCof;
	dkim-atps=neutral
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MPrLt1h6Bz2ywS
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Sep 2022 21:32:35 +1000 (AEST)
Received: by mail-ed1-x52b.google.com with SMTP id b35so6213620edf.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 10 Sep 2022 04:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oO2f6puxNv2WM0203jHJ9dATLxOnB/EAhNK0gKh1Fco=;
        b=ZH5YuCofNtiX91aOQ8okF8wGG31vLQnBuGTbsJIxq6skqZDH7RvK+S6Wg/jL8kGMG0
         wxALhNndMloVN1pmlZYgbSnkA4WugVPm6xPyUnDyPXtNQrabmBlb3doY3JHFHpEwdDOn
         UCMlcq27n8LGY/fiI8rrezsaIzsFdm7yeal6QiEIrx2i6u5RSvNr3NejNRbuoylCf6VT
         1NmPWSzvA4lzXHfElWpQVZrWn1GOb5l1rdycwSX1lGO4Q9iha+7RREdHfUFuABmzTqNy
         MS6wyNdM+htzk0aYqzebY8yDNHwmUT2SYl/24SW+F1b30ss1/TkgEA7qVOS7cSXPX2Wb
         gdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oO2f6puxNv2WM0203jHJ9dATLxOnB/EAhNK0gKh1Fco=;
        b=UH2IfyXusyX27AyFqvv96OMoEEQuCaeNOqQBU03FTAAOeEtK71tyzd5Mt1Brb7atAT
         l8wHuK81SNlkSIx9Nyhstmwz3PfaTX7ksD2FBFiAmaVR6qsg7etOIC7eyoflO6x6Kcfp
         ceR/S/KCIm7tLhppFatwddLnORoFU7TyMNiFH3UmSyDRqR0v1VA98ZDnRg/CpXtqGIZz
         W/Wqp9Pm9uwJ4urs4BeWeVsqP056yPQyxxCGimPtCBicDUVCr/PvX2EyRRX97NtutwX5
         5tPnZfwWNqKc28WDUpkXjA8v9iw/qy9jSWRZLlpiR8gZthc6o7ARA85xlp+QtwNwRVa+
         ULRQ==
X-Gm-Message-State: ACgBeo1xaQIsqjMkPtUtxvndR/H8dmckj8tDwQYCZ+rSprB6NeVoAoUS
	J+BwU5kUizNZMTUxarwWjWlsQg==
X-Google-Smtp-Source: AA6agR7ABzhvw0hLX7UM5YEGmj7ooKpj1BWh9U8hMic6ls9gEZTIgOqBBSoD7neml/f66zDsZ4trLA==
X-Received: by 2002:a05:6402:280f:b0:44e:ee5c:da6b with SMTP id h15-20020a056402280f00b0044eee5cda6bmr15219418ede.256.1662809547250;
        Sat, 10 Sep 2022 04:32:27 -0700 (PDT)
Received: from [10.41.110.194] ([77.241.232.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b00731582babcasm1625186eja.71.2022.09.10.04.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 04:32:26 -0700 (PDT)
Message-ID: <c76b45ad-c4ef-5166-fec3-a05e2febcce3@kernel.dk>
Date: Sat, 10 Sep 2022 05:32:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: improve pagecache PSI annotations
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan
 <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20220910065058.3303831-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220910065058.3303831-1-hch@lst.de>
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
Cc: linux-mm@kvack.org, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 9/10/22 12:50 AM, Christoph Hellwig wrote:
> Hi all,
> 
> currently the VM tries to abuse the block layer submission path for
> the page cache PSI annotations.  This series instead annotates the
> ->read_folio and ->readahead calls in the core VM code, and then
> only deals with the odd direct add_to_page_cache_lru calls manually.
> 
> Diffstat:
>  block/bio.c               |    8 --------
>  block/blk-core.c          |   17 -----------------
>  fs/btrfs/compression.c    |   14 ++++++++++++--
>  fs/direct-io.c            |    2 --
>  fs/erofs/zdata.c          |   13 ++++++++++++-
>  include/linux/blk_types.h |    1 -
>  include/linux/pagemap.h   |    2 ++
>  kernel/sched/psi.c        |    2 ++
>  mm/filemap.c              |    7 +++++++
>  mm/readahead.c            |   22 ++++++++++++++++++----
>  10 files changed, 53 insertions(+), 35 deletions(-)

Nice! It's always bothered me that we have this weird layering
here.

-- 
Jens Axboe


