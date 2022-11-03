Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FC7617CFD
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Nov 2022 13:47:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N33SS0r4Vz3cKj
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Nov 2022 23:47:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN>)
X-Greylist: delayed 384 seconds by postgrey-1.36 at boromir; Thu, 03 Nov 2022 23:47:03 AEDT
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N33Rq2dzjz3cKr
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Nov 2022 23:47:03 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id F40E868AA6; Thu,  3 Nov 2022 13:40:30 +0100 (CET)
Date: Thu, 3 Nov 2022 13:40:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [REGESSION] systemd-oomd overreacting due to PSI changes for
 Btrfs (was: Re: [PATCH 3/5] btrfs: add manual PSI accounting for
 compressed reads)
Message-ID: <20221103124030.GA29839@lst.de>
References: <20220915094200.139713-1-hch@lst.de> <20220915094200.139713-4-hch@lst.de> <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Jens Axboe <axboe@kernel.dk>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Nov 03, 2022 at 11:46:52AM +0100, Thorsten Leemhuis wrote:
> It seems this patch makes systemd-oomd overreact on my day-to-day
> machine and aggressively kill applications. I'm not the only one that
> noticed such a behavior with 6.1 pre-releases:
> https://bugzilla.redhat.com/show_bug.cgi?id=2133829
> https://bugzilla.redhat.com/show_bug.cgi?id=2134971
> 
> I think I have a pretty reliable way to trigger the issue that involves
> starting the apps that I normally use and a VM that I occasionally use,
> which up to now never resulted in such a behaviour.
> 
> On master as of today (8e5423e991e8) I can trigger the problem within a
> minute or two. But I fail to trigger it with v6.0.6 or when I revert
> 4088a47e78f9 ("btrfs: add manual PSI accounting for compressed reads").
> And yes, I use btrfs with compression for / and /home/.

So, I did in fact not want to include this patch because it is a little
iffy and includes PSI accounting for reads where btrfs just does
aggresive readaround for compression, but Johannes asked for it to be
added.  I'd be perfectly fine with just reverting it.
