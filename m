Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E331A9947A1
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 13:49:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNDpH6gylz30K6
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 22:49:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728388180;
	cv=none; b=ICEWikfP/+PfOmDQ/tSc12/vh9mk905+pIzrw3ngBfDNbYqpHgckLHxsAZITUlSdoBUfltK1Q02zMcdXiV6utwmmO2Bt9ZsAIq2OiQLBnvmyAlIJW6gotRHkdfP7kYshPmlc+YTLuTCPBtfL05RCFcgYT48Z6fHWnbPOX3ZJVWPvRdUBvGmh17+Uyuie/LaIx3tsgQiL9zdArDu5PoI2xI3eoZge1VrEElq6KHqrlN+E3JZX404lYo07VxLmkVaESAi9IQFH4TJUGhBRep3B0ym+Hsy7jdUNGbcEsan64q+hhoL6+fNMCQBgFG4NwW8drqcY9MDTTf9ATtR5S9NTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728388180; c=relaxed/relaxed;
	bh=awNsU8kM1gVB2hmGRFW5nD6DpdqCrn8A9zApWM8go6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2yVKZgS/NjKRaoI6u3N0oF94RS9OcTKrYZdU4ES8tcMTeWy4KJGGxQAAg5vQD9Zfy1kGE/XLkdw00uvsPJF2VzJBiocNb0ENPGazI4tjOfKfG0wxispAoZCTz/eY3IckQ15eA10WBb6SIp3UCe2CsjYxyEK9bdrfeTKhgJrr9sDr8EJQe526TtDKv5wY/P6Ut9gYFaJZRYZh263he6JQta8Hv5Tw8oOKXLjgTEkNzKhen3xGQN0Ke/IyswqG83Acd7e9bk3lwolT5KDceChgQvPnL8NQw6N1sVlik70v/E/hzybTtwhDAcJOS218S0K+HkDFJyJ7/Rn4W/u1lwLDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JteG29r4; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+25c59db37f98b80c3af3+7716+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JteG29r4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+25c59db37f98b80c3af3+7716+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNDpD17L5z2xyB
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 22:49:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=awNsU8kM1gVB2hmGRFW5nD6DpdqCrn8A9zApWM8go6M=; b=JteG29r4u7xWDca3q521WGut1p
	+W3eln9BohXAIUrXhRM6XRBWCUs6mMh15B8wUEdnqCOz56ViTP0Sw/+Wvt+nufSaS/pzC7P0suvka
	3zhloUFhkynsKq7ADkTSLRMM7hmfnqnCB8r+xQZrHT7RbWTd+1FhM2MRpOxtIpowWyNodfiJ1+1WL
	oafDlRbcEokBkwzHyBv+OGAKvfntAeYfKS9NY+Ju0NjSMdL0clrF6Eozpdw30yI+n6ELNEFa8aqR4
	K981aSZJ0O5YhTu9Npmh0LGyxxKz+zqGLsp0HKXfjFqL1zi6l95XMWx9FEJpbVYVq1i9xh3pprrwH
	/3ROin+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8id-00000005h9k-2aVa;
	Tue, 08 Oct 2024 11:49:35 +0000
Date: Tue, 8 Oct 2024 04:49:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
Message-ID: <ZwUcT0qUp2DKOCS3@infradead.org>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Oct 08, 2024 at 05:56:05PM +0800, Gao Xiang wrote:
> As Allison reported [1], currently get_tree_bdev() will store
> "Can't lookup blockdev" error message.  Although it makes sense for
> pure bdev-based fses, this message may mislead users who try to use
> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
> then.
> 
> Add get_tree_bdev_by_dev() to specify a device number explicitly
> instead of the hardcoded fc->source as mentioned in [2], there are
> other benefits like:
>   - Filesystems can have other ways to get a bdev-based sb
>     in addition to the current hard-coded source path;
> 
>   - Pseudo-filesystems can utilize this method to generate a
>     filesystem from given device numbers too.
> 
>   - Like get_tree_nodev(), it doesn't strictly tie to fc->source
>     either.

Do you have concrete plans for any of those?  If so send pointers.
Otherwise just passing a quiet flag of some form feels like a much
saner interface.

