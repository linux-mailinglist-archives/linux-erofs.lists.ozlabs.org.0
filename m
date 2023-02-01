Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCF5686747
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Feb 2023 14:43:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P6NR04sC3z3cgt
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Feb 2023 00:43:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lMMF4aTs;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lMMF4aTs;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P6NQv6nVQz3cFd
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Feb 2023 00:43:03 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 09227B82168;
	Wed,  1 Feb 2023 13:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5161DC433EF;
	Wed,  1 Feb 2023 13:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675258979;
	bh=236qP/C90Z1wdMee922mWauOTL0WF+oXGDgnJ96vQFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMMF4aTsthtPu0qSDZz5BvWT3Pmxnz+NILt33rgl1+vXpJfzqEv41DYzKsqYGtoGo
	 RfbSM457WNfz2Hj+9ntpXQApKcCjAJVksXRu34iUU27WSsyzFHxu28zKksBwqEgFjq
	 bEmZWftDL1skahY8fxJIf/X2bYWhUr5/ruKGAoT6wF16to0EWnPfOxShNm4aNuTyFH
	 TllIEyGeIvTdR60qHVy/Feh2ApS62j8QtGi5QRujJzXjmj7KFrOB8C3HaUwsJdZUwf
	 P83wP7ZfiBKmcU8JDkWwvICV8r+9vwyn/20bGSvqbW6MrkafLuuV0989PpLRqSWgss
	 U+lNph1qFbXHw==
Date: Wed, 1 Feb 2023 14:42:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 00/10] acl: drop posix acl handlers from xattr handlers
Message-ID: <20230201134254.fai2vc7gtzj6iikx@wittgenstein>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
 <20230201133020.GA31902@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230201133020.GA31902@lst.de>
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
Cc: linux-unionfs@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, Seth Forshee <sforshee@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 01, 2023 at 02:30:20PM +0100, Christoph Hellwig wrote:
> This version looks good to me, but I'd really prefer if a reiserfs
> insider could look over the reiserfs patches.

I consider this material for v6.4 even with an -rc8 for v6.3. So there's
time but we shouldn't block it on reiserfs. Especially, since it's
marked deprecated.

Fwiw, I've tested reiserfs with xfstests on a kernel with and without
this series applied and there's no regressions. But it's overall pretty
buggy at least according to xfstests. Which is expected, I guess.
