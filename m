Return-Path: <linux-erofs+bounces-3578-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8OnxCuKwK2qTBwQAu9opvQ
	(envelope-from <linux-erofs+bounces-3578-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 09:10:26 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485796771DE
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 09:10:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=SfmYAIrp;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3578-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3578-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc9dV5kpqz2yhY;
	Fri, 12 Jun 2026 17:10:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781248222;
	cv=none; b=bCm1sNEvDRKK2ZFeeprq0plvxUm14hv7atDM0BTFq9L4OqSqCDV1vTTbrJ2RC9s6tQ8zx4VgWTpE8Rj998tQKCHsJX762ecXJdJsVMfNeNTcH94vuUzs/WrMOFN9b1IPJzh6tSHSTGKaU7E3L/wxLIjaW7lfXpxNfmEcDv76nJ0ktboOzLLInDw+rzx4q0/sso5W2DcdPxxvz+VoVXIopU4lqLFVWeza2i99PBbAPD8YRYIkMCOzgSC2gsWIDx1a8Ik7cpBRAf09LLLfQ0jZfqdorr4DOD/NsyeCwyn5660NigMoi5niualSCEHD9tWLypEa+HcLDs1XYvd20H/xkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781248222; c=relaxed/relaxed;
	bh=XE7l43niiLaN14nrCHPCXNTwQNW0zvc1XGeK+ca3pYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoEtVXHybdpYYdfbq6Sb9z7IwkJOMlxQhY5qMrDTqjmmWdi4vVUsTlt5eedAdek+MogczWgVutGkjzZc5ENpS3lNfGgQuyTOs19WRJ44SDFCD08mPTozt/hdBVWucf7gHBKI9zB0BxdqFkFri6CXA842xCqmrU77/EsVe/FQlYvaIwOW2uIYcDrmQ5jaioWt60ccBItVpb+MvoiSZ+IoozRATQ8pynO49jcntxoH/6JtM5kiyiovMOoRl+E7tk+Ecb0pn4/VNFXlTQzTWH06C0h4fz8A5r/7IehkhYX9LUmD/BVlgFrESGPKjzTLF7qD5G3mdol+SFVC/v8pdCNCiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SfmYAIrp; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+b893ed6302a0b05caa02+8328+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc9dT4CKRz2yd7
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 17:10:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XE7l43niiLaN14nrCHPCXNTwQNW0zvc1XGeK+ca3pYI=; b=SfmYAIrpzZaWgoAUgEKeN4JBmW
	DQ5Cwrho677W4xT9wnSXwLnsdQkLi9i3qUBIwas2hUzwCL0e9ScUIfr2FsiZph8iDtb0zVrg9jB3H
	I4pEP2I25mPgjTzMnlebEQam/6MRUmpzOxUVGx7BrcjGjJfSoBczr+alHVtBp6v71+Av3W/mt5TqH
	gDPnH53rOZ4C2mi/hez/WYQgMAd/Geobc7nl2TxWYazaDeFIGxNGLjv21G/tjQter2ROhuewUnVHn
	fKvTen2kvguqn31TaxdQFdhe7yik7/TqopD07sL3KoUBT65Skh8FUY4788wUi9mOb/AZDeaEOizGY
	3EhZYb9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXw1p-0000000ASQo-169T;
	Fri, 12 Jun 2026 07:10:09 +0000
Date: Fri, 12 Jun 2026 00:10:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, yekelu1@huawei.com,
	jingrui@huawei.com, zhukeqian1@huawei.com,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: don't merge bios over iomap boundaries, was: Re: [PATCH] erofs:
 prevent buffered read bio merges across device chunks
Message-ID: <aiuw0QvFIhEWUPG-@infradead.org>
References: <20260612033244.993507-1-zhaoyifan28@huawei.com>
 <58bef9af-0926-4948-b917-e38c3793f596@linux.alibaba.com>
 <aiumQL8LEWQX_Nag@infradead.org>
 <62f6e9bc-cfb3-441c-a3b7-301b8649f0ae@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f6e9bc-cfb3-441c-a3b7-301b8649f0ae@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3578-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:hch@infradead.org,m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:yekelu1@huawei.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:ritesh.list@gmail.com,m:djwong@kernel.org,m:linux-xfs@vger.kernel.org,m:joannelkoong@gmail.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[infradead.org,huawei.com,lists.ozlabs.org,vger.kernel.org,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 485796771DE

On Fri, Jun 12, 2026 at 02:54:47PM +0800, Gao Xiang wrote:
> hmm, currently erofs could return block-sized iomap (if the chunk
> size is 4k) even it can be merged with the following chunks.
> 
> Previously it was fairly good since consecutive chunks will be
> added to the current bio if possible, but after this patch,
> there will be a lot of 4k bios.
> 
> But if iomap goes into this way, I could make iomap_begin maps
> more chunks in one shot, but that needs more changes in erofs,
> it's fine anyway.
> 
> ... I was thinking the following diff (space-damaged):

That should work too for your case.  But we definitively have various
cases where merging over iomaps is a bad idea.  You'll also end up with
other efficiency gains by merging consecutive entries, especially for
direct I/O and when using large folios.


