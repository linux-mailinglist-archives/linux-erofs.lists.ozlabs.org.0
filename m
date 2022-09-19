Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB495BD15E
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Sep 2022 17:45:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MWTXy3ncBz3bk0
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Sep 2022 01:45:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MWTXq041wz305p
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Sep 2022 01:45:44 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id DDEA568BEB; Mon, 19 Sep 2022 17:45:33 +0200 (CEST)
Date: Mon, 19 Sep 2022 17:45:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Sterba <dsterba@suse.cz>
Subject: Re: improve pagecache PSI annotations v2
Message-ID: <20220919154533.GA710@lst.de>
References: <20220915094200.139713-1-hch@lst.de> <20220915130138.GO32411@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915130138.GO32411@suse.cz>
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Sep 15, 2022 at 03:01:38PM +0200, David Sterba wrote:
> On Thu, Sep 15, 2022 at 10:41:55AM +0100, Christoph Hellwig wrote:
> > 
> >  - spell a comment in the weird way preferred by btrfs maintainers
> 
> What? A comment is a standalone sentence or a full paragraph, so it's
> formatted as such. I hope it's not weird to expect literacy either in
> the language of comments or the programming language. The same style can
> be found in many other kernel parts so please stop the nags at btrfs.

That is not what most of the kernel seems to think.  The usual style is
to have multi-line comments start with a capitalized word and end with a
dot and thus form one or more complete sentences, but single line
comments most of the time do not form complete sentences and thus
do not start with a capitalized word and do not end with a dot.
