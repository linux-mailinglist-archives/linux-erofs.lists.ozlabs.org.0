Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491C5B8779
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 13:47:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSJVX2D2Nz3bbj
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 21:47:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=gNw8KIHA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmpxchg.org (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=gNw8KIHA;
	dkim-atps=neutral
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSJVS6n2Jz2yMk
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 21:47:44 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so2143702wmb.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jkjInFA4v6207rYNR9PZy7GQsLdw9JOAYyp4dYZPwKo=;
        b=gNw8KIHA1akV3WAIG3mTyAM9FwwfR45IWHpt7v8NJ/D3h8AuPnRAR4Fr9l6bY4Z+l+
         yBth3uvMnFhQguK7OFTCFEvob15XvvYYkQE6d5COR/F3dEL9EtIxWGeLd3Ti+huvh2AS
         UBiZdvfDAe2ffljdOWuaI7kc+tuNrsOiJfuhmKifgcExmxx2CxBo4QEmKguep2CjcgBi
         Mp80NzZ2QTsl+f2ooHri9mIxl/A9EFiJh010AdjbJ9RG0BFdICtooF0X4b+3YpOiUcxo
         PiaQDy5iGBG39jXagGb5CLj0tueVl6vvcptlPqe1xaYjbhuQ/GbIW0ZWRwxqmB33Cc8w
         iz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jkjInFA4v6207rYNR9PZy7GQsLdw9JOAYyp4dYZPwKo=;
        b=PPzTs85UxT4miVxr/7cjrnP2FseX0FQrTaRMw8R+ttD8TofKtKo2Enx/3jWCyYiqr8
         cpenQc1EW+aS8gyGZI1vk9vZwqXn6nkw9NLkpz/34Sy7kszOvJO5A1Cv49aIAZVhEZf9
         1bs5Kh2TmhKgWQr6nh0XyFsa5EN3a1n6XKSRawP+jEq2C4fgDiEq9h/ls9qnNwOC+EBx
         fB5F1MTwrBBalNN9SmH6pWHed4ACB5EzY0N4WFLM/iAz04biPtMVeY4X5qYdf5FNly2d
         tq5ukLc5d5DhbfddhkqSqOVCnRTiU4/YNnrJ0XUeBJjc5E6xhACAkt8KuEU3ky//LXYe
         PkDw==
X-Gm-Message-State: ACgBeo0qp06f6E657Gp2EtX9JivZp/AEG3nda8QxkewGB35rqlVHEPXv
	KDlIq9DqiPL6kkY6Jj7ugvVhgA==
X-Google-Smtp-Source: AA6agR6aSV3jXyKXuS6Lp8ysxs2qtNOBdPRNKt7wbfiui0ec8Ug1sA6v6mmiNfrSa5l3/MzmVoabgw==
X-Received: by 2002:a7b:c84c:0:b0:3b3:3faa:10c3 with SMTP id c12-20020a7bc84c000000b003b33faa10c3mr2800743wml.94.1663156061281;
        Wed, 14 Sep 2022 04:47:41 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d6609000000b0021e51c039c5sm13066031wru.80.2022.09.14.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:47:40 -0700 (PDT)
Date: Wed, 14 Sep 2022 12:47:40 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] erofs: add manual PSI accounting for the compressed
 address space
Message-ID: <YyG/XKXFNxk+HfXf@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-5-hch@lst.de>
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

On Sat, Sep 10, 2022 at 08:50:57AM +0200, Christoph Hellwig wrote:
> erofs uses an additional address space for compressed data read from disk
> in addition to the one directly associated with the inode.  Reading into
> the lower address space is open coded using add_to_page_cache_lru instead
> of using the filemap.c helper for page allocation micro-optimizations,
> which means it is not covered by the MM PSI annotations for ->read_folio
> and ->readahead, so add manual ones instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
