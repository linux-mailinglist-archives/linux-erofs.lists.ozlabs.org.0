Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC2F6D8537
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 19:51:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsBxy5cv5z3cjY
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 03:51:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N5ckeWaO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N5ckeWaO;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsBxq6D4Gz3cFP
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 03:50:55 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4D5D663D5B;
	Wed,  5 Apr 2023 17:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EE0C433D2;
	Wed,  5 Apr 2023 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680717048;
	bh=8RyRFaPwlCx6/LOIIjBet5SjJyIkLiaizKSwCarmDik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5ckeWaOWk8DYRS/vHEJFODUdFDterIWk0v6dwVPSI9Eqo5M3E9e4grJyjnLkrviz
	 dmFQfemBW4Yipr4UCkQqWu/G0jjSFPpIfLv1Je78AwwHLIERp0PH1/vRe80YL6RRYZ
	 JHue6126dFHFUdI0jGeczDDfabiD0M1vLyQEPVfbHZX3zYTjLfOHFds9uxGxs3TRQA
	 4MnoQS7XV3DutZNo5CjWayJ9Vw8uMHLtIdvQkc3cGo0pogH7TUG6lTRLj5yrPGYu4M
	 tKZPz4nQeJIMNPgpgrINAMfcVgJNK3JNCa+gggxvfOkDxw9yi9kDdMaMWz6bTaOSji
	 hhrgnfYs6HsxA==
Date: Wed, 5 Apr 2023 17:50:46 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 05/23] fsverity: make fsverity_verify_folio() accept
 folio's offset and size
Message-ID: <ZC209lS6vrEGqDhx@gmail.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-6-aalbersh@redhat.com>
 <ZCxCnC2lM9N9qtCc@infradead.org>
 <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
 <ZC2X5YlHMxzZQzhx@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC2X5YlHMxzZQzhx@infradead.org>
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
Cc: fsverity@lists.linux.dev, cluster-devel@redhat.com, linux-ext4@vger.kernel.org, agruenba@redhat.com, djwong@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 05, 2023 at 08:46:45AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 05, 2023 at 12:36:42PM +0200, Andrey Albershteyn wrote:
> > Hi Christoph,
> > 
> > On Tue, Apr 04, 2023 at 08:30:36AM -0700, Christoph Hellwig wrote:
> > > On Tue, Apr 04, 2023 at 04:53:01PM +0200, Andrey Albershteyn wrote:
> > > > Not the whole folio always need to be verified by fs-verity (e.g.
> > > > with 1k blocks). Use passed folio's offset and size.
> > > 
> > > Why can't those callers just call fsverity_verify_blocks directly?
> > > 
> > 
> > They can. Calling _verify_folio with explicit offset; size appeared
> > more clear to me. But I'm ok with dropping this patch to have full
> > folio verify function.
> 
> Well, there is no point in a wrapper if it has the exact same signature
> and functionality as the functionality being wrapped.
> 
> That being said, right now fsverity_verify_folio, so it might make sense
> to either rename it, or rename fsverity_verify_blocks to
> fsverity_verify_folio.  But that's really a question for Eric.

I thought it would be confusing for fsverity_verify_folio() to not actually
verify a whole folio.  So, for now we have:

    fsverity_verify_page: verify a whole page
    fsverity_verify_folio: verify a whole folio
    fsverity_verify_blocks: verify a range of blocks in a folio

IMO that makes sense.  Note: fsverity_verify_folio() is currently unused, but
ext4 might use it.

So, just use fsverity_verify_blocks().

- Eric
