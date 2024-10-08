Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5025F99495A
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 14:23:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNFXq6tnkz30f5
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 23:23:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728390185;
	cv=none; b=EhzHmW83vlaAFiBMvE7DXz1VgFACo1UFyL9SgvgrpqbHKVQn0/Tkp1k/L5hf1Fj4MKFu8MQsPolZkFUNButiI8DQhbqTS6ojZ+TJ/BABtZufOhxlF6sRJAS131vBDvhXTu5DHR4ZMSJWrH50NEQJ1DctQ4+vDSEL+xRiS1tYXVEPgeOAak7hE9BZBD5cFUPuLfZwfFlOWjSel58xrmxlms1SNgMZrYoqULlmg3AlJqNjXJ9qEqiHkSVolThD8V7b8n5hDNvXU2vcE8vF8qpp5qXAynQSNdzEHGT+aVBf3QB1TfFNa0vwYw4OK1QGyltiKncBS7l7hqXCQUHJA0YTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728390185; c=relaxed/relaxed;
	bh=uOucjaDDLBn6pVXhclYDmS9P5w8KdiUT3z9VmKsnsyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ22iJiVw8DxQ5O6qDYR6RHfiJgrhNCzGTIwLgz//TWfJ9ZXYSZhyfPR5JZbiQS2qSoUjt/UIDKo72XQu0xQJhKeAMeENaxUEUjoqqAVZFsGgWj+fJWbjarnVSLG/dFFlGwEPPP/2Wf5KLMOvboih6wojfbHG6GhrpDVR+Uv4Ej7t1kNK3D5q/F7DqBBXx7NSSeBNvfnPigGm9PA1xY6CUCP07kkSix2BKmjnfsjOmb8oYORXQHz9OjSItQGZR4a3TrlAavEcghmotFQTHqH2v+UcV1z737vEWG/Cw8S4/ywdCfZk7Ov5dAOx3mPvNqR7YXNNegEPA6kLwXeH2SncA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wMKZSAVf; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+25c59db37f98b80c3af3+7716+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wMKZSAVf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+25c59db37f98b80c3af3+7716+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNFXn0LlHz2yS0
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 23:23:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uOucjaDDLBn6pVXhclYDmS9P5w8KdiUT3z9VmKsnsyQ=; b=wMKZSAVfys5mDit4w+XYZVptdZ
	VHuD8UX6YphYoaj4wONU+VkGn/uHro6xXS9tDHvoOb9jxAZGITTnXTkE92vsJSoRenRILUcvJFgNt
	x+LoxUzeaVrgezrIxXja1V+DfKYd+l/n83Y/LbXDPsrlHYF6qBlRBta7zDiM/XjLHQ5nnEnH5JjJn
	lS4s0H1WM7m1PVVZ908mMJa7X12JY7D9jaoUfhcX+erKtdvH+qkrqrvlHaJUHnVUjx231GTwJWlO8
	Z0WZ/r7NAOEgym1ntfuv1v+10mCVRVDwLo5mhSnNmbUOVhx+vD4pyMxDg+8jSOcWI/VxZ88HSWQoM
	/jEEikcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy9Ey-00000005nM4-1f73;
	Tue, 08 Oct 2024 12:23:00 +0000
Date: Tue, 8 Oct 2024 05:23:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
Message-ID: <ZwUkJEtwIpUA4qMz@infradead.org>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
 <ZwUcT0qUp2DKOCS3@infradead.org>
 <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
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

On Tue, Oct 08, 2024 at 08:10:45PM +0800, Gao Xiang wrote:
> But the error message out of get_tree_bdev() is inflexible and
> IMHO it's too coupled to `fc->source`.
> 
> > Otherwise just passing a quiet flag of some form feels like a much
> > saner interface.
> 
> I'm fine with this way, but that will be a treewide change, I
> will send out a version with a flag later.

I'd probably just add a get_tree_bdev_flags and pass 0 flags from
get_tree_bdev.

