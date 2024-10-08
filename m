Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D7994C91
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 14:56:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNGGw1CWXz30BW
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 23:56:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728392166;
	cv=none; b=SybL3HAnI+48zT74ttygXD6ReLRyx/QclDZ4UqB7sp1eunOMRMuKRJfew858JYs25XshIbKx/L0i8yFnw8LfjTHH2e/mXjmFp/dmUMUzRs3aeJJIGxewYYXN9sc5/F7daytUMgDrichqf26eRJMpQ4fH3JIQq2jGkagQselFawpycfYpPx72sbG86DpeSwG9hx9Yazbbq5Nkt43UwBwB0F04Vu1SL6dVVyKejQch5sHVqfaB9v41km6zL5nqdFygL6BAwb9mdxzDLxgCAmX3Z8mgxAbAYwvfZwsFQ9dPs5vM5muLz3CiMT3GbXJwqHMX/Gs9UVpYNT68JsBW1s3Dag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728392166; c=relaxed/relaxed;
	bh=d4cHsnC3TBo8c4sySnC2hojW9m7YjVLgXXnPhZPoswQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZolsjaTVccr4iVhjllhkWfEeCYl227V+0dKFmwHOG+nqejx0/lSe8lJfFGPVRbUsAvNSt3bb8BaB610Ro+hFwZgjdecwadelvh8Q5I8N351qwEn5xHrg94Ge1o1lTz/0Kfr7KaKK2K9ZjEPgsS1Og9nY2/aCGlWrIJ3lwQcMIxOKK0Hl5zZdu0O4pJTpKKVibyUW/Ut4TV2kxZLCzDVwCifMv7XKvMkNQmskdOMsWa0CJnHPQ/p/dO/5s16mEcuCa+/WsgAQte9pPIbKc6q7j8gN8r2beAhMTmw6ng7hwM952MBHCk7gB4os0yKFcxv07lAMFvINhKuubkHzO15IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mw0dG3RS; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+25c59db37f98b80c3af3+7716+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mw0dG3RS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+25c59db37f98b80c3af3+7716+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNGGp1k6Lz2xJJ
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 23:56:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d4cHsnC3TBo8c4sySnC2hojW9m7YjVLgXXnPhZPoswQ=; b=Mw0dG3RSJahn+N5QDQW5LVfqJu
	WaObqx4JIfFPnfJg3XWZOaL8FE6Mz9lrmlP7hecQiJEui0m3cb1ZqxI+8+6TSidsVrdDswYz2qXNG
	wJPeG/0iIqW8f5DbVN78SLJJtbdEdb7GHhRfthw0pVgCWtWp94y9r0sH66Kg0FZebtEezUJQZACtv
	FNLrDVIRpYt2gTnY/IKl7m0E8tDD3hE51fkG15LvgVyxFZErww5Nqqv6NVHDvElSsAC3f8hESZSrE
	1MlLwn90OR0cgnOKOyzKDuwhq4DPAlXT5I9MSdlb/2D6Mu0SXDM0L8yDb2lzK/F/jshEnbgzgyiYd
	ikf2DR0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy9km-00000005srg-19Pg;
	Tue, 08 Oct 2024 12:55:52 +0000
Date: Tue, 8 Oct 2024 05:55:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
Message-ID: <ZwUr2HthVw9Hc1ke@infradead.org>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
 <ZwUcT0qUp2DKOCS3@infradead.org>
 <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
 <ZwUkJEtwIpUA4qMz@infradead.org>
 <ca887ba4-baa6-4d7d-8433-1467f449e1e1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca887ba4-baa6-4d7d-8433-1467f449e1e1@linux.alibaba.com>
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Oct 08, 2024 at 08:33:27PM +0800, Gao Xiang wrote:
> how about
> int get_tree_bdev_flags(struct fs_context *fc,
> 		int (*fill_super)(struct super_block *,
> 				  struct fs_context *), bool quiet)
> 
> for now? it can be turned into `int flags` if other needs
> are shown later (and I don't need to define an enum.)

I'd pass an unsigned int flags with a clearly spellt out (and
extensible) flags namespae.

