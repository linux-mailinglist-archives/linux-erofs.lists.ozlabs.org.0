Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE985BE8CA
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Sep 2022 16:25:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MX3jP5VKfz3bYM
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Sep 2022 00:25:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vcwZfyi/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.dk (client-ip=2607:f8b0:4864:20::d32; helo=mail-io1-xd32.google.com; envelope-from=axboe@kernel.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vcwZfyi/;
	dkim-atps=neutral
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MX3jG4DqCz2xJ8
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Sep 2022 00:25:03 +1000 (AEST)
Received: by mail-io1-xd32.google.com with SMTP id d8so2350060iof.11
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Sep 2022 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=kNuOgpAqQ8sV4nxp51XLJgFTZcmbM6JC8PggK3tENzY=;
        b=vcwZfyi/GVEQh9PLiaZBaCfb3axRxqFoa5qooqIdBsrKT1H9uQ9yA9+FfFOl1fAXhn
         8vdYVWMazdyklD78k5EduRtORpnWn9dTaTpSB0M/bQlFPY+AdF4mSGlyz2Gl6AwxoUb0
         x5/nWtidvAfz9hRmJu6rSpODekRwAFi0LydR69xJNy1Dgd7lygGYTLPTtGyf7KKfYBL2
         EwoVb1n4BjLqmtGW/hi9uPhf9JOM3Gvs1zawSH4FWnfXt59kxshtETQ3XSTNM7nf9Gjw
         yVTI6+Cy6KcAUJGUHNyL9H+vpG2//dFzrd4RRFrywUxz7wRIoMx1e5Z1UFCCg3HFI/AI
         yO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kNuOgpAqQ8sV4nxp51XLJgFTZcmbM6JC8PggK3tENzY=;
        b=dPblLC2kiizynQsQCZ0CjQXw2G9nQ6qAxcb1Li+DcvLRAg5ld31jO11eOU7GHhwbUt
         m7h9LFrpXgxx0xwXYm6FiOjIMsQl084vrn/90vKY7EBwyLSCIwAq0U1ZIZlrEcmo7epD
         jCGre+t7oZfkU1Q82rXsTdJx3rtNffUAaa0y8j46nc5Gby35ckcb652allj49N90wcy3
         pGNAiHNR9UrswHCHpQQyiNQ3/aJJAKSygi0/5H3CiZbydf7j89OMXMo9PrrbKXXyLfvL
         IBZ9fxqt3quf1QYeODxDtWFiCT7HUTOzvxTcqci5EXI5Py0JMgvlaw+03YlBIyp+pTsT
         slXA==
X-Gm-Message-State: ACrzQf3KwAg3EtAo8b4bk/fTssckUkryic5Oxkp15dy+FAlaOh/fK3GV
	G9f9UvmoVM5/HlDhhKUcH+Qr6A==
X-Google-Smtp-Source: AMsMyM6lLDHt5Deb231d56RrjImrVmLjcuUz4TFjco6WFvGiW1CQm6r2S1RJMyCkDqcGuD09M9QKYQ==
X-Received: by 2002:a02:c6d4:0:b0:35a:4ea3:4890 with SMTP id r20-20020a02c6d4000000b0035a4ea34890mr10491170jan.215.1663683899210;
        Tue, 20 Sep 2022 07:24:59 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f13-20020a02a10d000000b0035a9b0050easm5317jag.18.2022.09.20.07.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:24:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Suren Baghdasaryan <surenb@google.com>, Christoph Hellwig <hch@lst.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20220915094200.139713-1-hch@lst.de>
References: <20220915094200.139713-1-hch@lst.de>
Subject: Re: improve pagecache PSI annotations v2
Message-Id: <166368389821.10447.12312122039024559092.b4-ty@kernel.dk>
Date: Tue, 20 Sep 2022 08:24:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
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
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-mm@kvack.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 15 Sep 2022 10:41:55 +0100, Christoph Hellwig wrote:
> currently the VM tries to abuse the block layer submission path for
> the page cache PSI annotations.  This series instead annotates the
> ->read_folio and ->readahead calls in the core VM code, and then
> only deals with the odd direct add_to_page_cache_lru calls manually.
> 
> Changes since v1:
>  - fix a logic error in ra_alloc_folio
>  - drop a unlikely()
>  - spell a comment in the weird way preferred by btrfs maintainers
> 
> [...]

Applied, thanks!

[1/5] mm: add PSI accounting around ->read_folio and ->readahead calls
      commit: 176042404ee6a96ba7e9054e1bda6220360a26ad
[2/5] sched/psi: export psi_memstall_{enter,leave}
      commit: 527eb453bbfe65e5a55a90edfb1f30b477e36b8c
[3/5] btrfs: add manual PSI accounting for compressed reads
      commit: 4088a47e78f95a5fea683cf67e0be006b13831fd
[4/5] erofs: add manual PSI accounting for the compressed address space
      commit: 99486c511f686c799bb4e60b79d79808bb9440f4
[5/5] block: remove PSI accounting from the bio layer
      commit: 118f3663fbc658e9ad6165e129076981c7b685c5

Best regards,
-- 
Jens Axboe


