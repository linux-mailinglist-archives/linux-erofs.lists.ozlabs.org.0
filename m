Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B33905D73
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 23:10:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DIXhgPtR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vzyr91LHmz3cCt
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jun 2024 07:10:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DIXhgPtR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vzyr440RDz3bqB
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jun 2024 07:10:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF75461763;
	Wed, 12 Jun 2024 21:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2F4C116B1;
	Wed, 12 Jun 2024 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718226641;
	bh=dqLO371b1vPErmMYi4CgWyvSUCQn8of4qGwTdEMzEhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIXhgPtR71kSyV6/epJDyqhWKsEQEX5yhhZda5PPHpZ+0ARYCCiAtnRSNR1FnlC7P
	 nPXkJq/SepET7ym8thpR7yujnnQ7ZHn3iRsMoIfGobXMy1OJxAIzKKtD9ftmAGl8KN
	 kUltI84OFlF1WwDhedAy43xrdUjP8vTB+P26BCEb3a2HConB/TZUMHytqEARmpH8ln
	 QCY5BssR28eFz1T409YzepxwR+K2C6Zp7Uo+S9MDDNObxIJC8bTjFUTi06cTVT7OeC
	 lTnaI5hdCh11uuYSK3xj94QxhxrNjmNwqI7uE46+z3EGyJoGClyLogjejeb9r2ihDk
	 QMYN4T27nFHOw==
Date: Wed, 12 Jun 2024 14:10:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 01/22] fs: Add generic_atomic_write_valid_size()
Message-ID: <20240612211040.GJ2764752@frogsfrogsfrogs>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607143919.2622319-2-john.g.garry@oracle.com>
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
Cc: ritesh.list@gmail.com, gfs2@lists.linux.dev, mikulas@artax.karlin.mff.cuni.cz, hch@lst.de, agruenba@redhat.com, miklos@szeredi.hu, linux-ext4@vger.kernel.org, catherine.hoang@oracle.com, linux-block@vger.kernel.org, viro@zeniv.linux.org.uk, dchinner@redhat.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, mcgrof@kernel.org, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, chandan.babu@oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jun 07, 2024 at 02:38:58PM +0000, John Garry wrote:
> Add a generic helper for FSes to validate that an atomic write is
> appropriately sized (along with the other checks).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  include/linux/fs.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 069cbab62700..e13d34f8c24e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3645,4 +3645,16 @@ bool generic_atomic_write_valid(loff_t pos, struct iov_iter *iter)
>  	return true;
>  }
>  
> +static inline
> +bool generic_atomic_write_valid_size(loff_t pos, struct iov_iter *iter,
> +				unsigned int unit_min, unsigned int unit_max)
> +{
> +	size_t len = iov_iter_count(iter);
> +
> +	if (len < unit_min || len > unit_max)
> +		return false;
> +
> +	return generic_atomic_write_valid(pos, iter);
> +}

Now that I look back at "fs: Initial atomic write support" I wonder why
not pass the iocb and the iov_iter instead of pos and the iov_iter?
And can these be collapsed into a single generic_atomic_write_checks()
function?

--D

> +
>  #endif /* _LINUX_FS_H */
> -- 
> 2.31.1
> 
> 
