Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EF75B875D
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 13:42:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSJMn6bPyz3bbj
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 21:41:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=q/oyayVc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmpxchg.org (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=q/oyayVc;
	dkim-atps=neutral
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSJMh2hSZz2y6N
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 21:41:49 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id ay36so1794544wmb.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UQ6ki4yX5kQtVY1QftaIadGFPpTJFOi0It8Nz6sT1sA=;
        b=q/oyayVc8gtEqunNB1xJ3/FfxrAeboEzVVJSS32eCQHH7YkWiqGgc4DvqOkB0BmKB4
         EGBb59YfleXrHU3uhnARoWo1nkO+5gVkRg434+fP58rkbQ+KyzSzFEdZMFr+gIQUNJxq
         vNaGHKI6gzmX6l03osdo1ByMaXvFnCpGisqVbAa62a/tMQq7SKC2J88arzMPMDjYF36K
         5xDreZXRw+mz8OAlu6KXnu1yjwXtnaapCWAG0NQxDQmrAHbEmFBM9EVDoD7eLf/StPtW
         PVPtrMfMkfxUHkfJjD5j7HiSoRmkXQ3yJjff0qqwea5vgyNr/Dz+Fg3Y5dDOdpUikG5Q
         wIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UQ6ki4yX5kQtVY1QftaIadGFPpTJFOi0It8Nz6sT1sA=;
        b=UKBD+JsTaI0kZapK7OeXRyu7s/xRmtcY44u54g5syA84Ka8355r/3szFCebvQDoO/N
         pk1OjBgl8YlxUETsLY9qF1k0ThD3cmynVoeqTiYh7JihigNmw2xxxfc2Bq3gFnRMvRpV
         sz1UXwuR5BgXImD5+EWCQHnOWZozxyDsLsHHp1iNTAeNEwBAmqrkHKg40tuTTpSKhR3L
         6k038h85+GeInEIImxogiiloaY3r4WYs/Gr6RxCgWguOO2N6ZQWeOsq89wVX+F/ypmZB
         2RW3oAXYAOSuIY+A0rqB4gM0wRj4WBQ1qHhHM0WPL2S9Pu4QMn3N8n1pKFTZL3jEnRFR
         5m5A==
X-Gm-Message-State: ACgBeo1zSUWfC4pYhjyp1gJOFmYnqNqYc3B4hSsxL80LacgqZW2DLoI2
	oAw//cxAWRbAbxzrmC0KgkXoHg==
X-Google-Smtp-Source: AA6agR5iucBxgT+lWuCgOcqjgv1Qz0MJiMgw6JKNQ8nsLCUf51/5QiLnwph6LP3BZLcxpH7lhwgthg==
X-Received: by 2002:a7b:c457:0:b0:3b4:689d:b408 with SMTP id l23-20020a7bc457000000b003b4689db408mr2835029wmi.22.1663155702145;
        Wed, 14 Sep 2022 04:41:42 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5951000000b00228dc37ce2asm13229870wri.57.2022.09.14.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:41:41 -0700 (PDT)
Date: Wed, 14 Sep 2022 12:41:40 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/5] mm: add PSI accounting around ->read_folio and
 ->readahead calls
Message-ID: <YyG99D196Hj0/GgZ@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-2-hch@lst.de>
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Sep 10, 2022 at 08:50:54AM +0200, Christoph Hellwig wrote:
> PSI tries to account for the cost of bringing back in pages discarded by
> the MM LRU management.  Currently the prime place for that is hooked into
> the bio submission path, which is a rather bad place:
> 
>  - it does not actually account I/O for non-block file systems, of which
>    we have many
>  - it adds overhead and a layering violation to the block layer
> 
> Add the accounting into the two places in the core MM code that read
> pages into an address space by calling into ->read_folio and ->readahead
> so that the entire file system operations are covered, to broaden
> the coverage and allow removing the accounting in the block layer going
> forward.
> 
> As psi_memstall_enter can deal with nested calls this will not lead to
> double accounting even while the bio annotations are still present.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is much cleaner. With the fixlet Willy pointed out:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
