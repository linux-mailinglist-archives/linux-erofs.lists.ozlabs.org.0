Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975085B888E
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 14:47:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSKqk2vPfz3c6l
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 22:47:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSKqK6MXXz3bl4
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 22:47:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VPogkmb_1663159636;
Received: from B-P7TQMD6M-0146.lan(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VPogkmb_1663159636)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 20:47:18 +0800
Date: Wed, 14 Sep 2022 20:47:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] erofs: add manual PSI accounting for the compressed
 address space
Message-ID: <YyHNVG5tHFt7E5ZY@B-P7TQMD6M-0146.lan>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-btrfs@vger.kernel.org
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, linux-btrfs@vger.kernel.org
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

Thanks, Looks good to me (Although I don't have chance to seek more time
digging into PSI internal...)

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang,
