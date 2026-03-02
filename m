Return-Path: <linux-erofs+bounces-2458-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEp8Ht2epWmuCAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2458-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 15:29:49 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFF81DACD2
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 15:29:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPhCX5K60z3bW7;
	Tue, 03 Mar 2026 01:29:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772461784;
	cv=none; b=LwnOFDPSww6aak4LqFXpcGBRnEpjpJLwSkkAS743mzly3oumh4GMgr0/XXqowpbSS1Ml7ybf/XrFXkcjVTzQd9PkudUiZBjh66k1buOR2rQbrIONfPIJqnYJcFqPS4afB3STwhJZi8cvzsqxbY416JC5xzHgDXQsviJvG1GB2HS/968BzzUcoDtuYpbYQkqcMllO4CGlT9IXbD/F/hWO9TVGwohAs6mrM1mALpkAFfyn6EDH+dZZ9T7hlhvmprFG9t3deGJiLC3Fqdb4awyu3tzsurkUOj4e/gNH9eVD4CNe2A6AKHXaY5Zukuy73maBbuC2aDabUKWObGktR64DYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772461784; c=relaxed/relaxed;
	bh=sFdR4sdgk264z4O4HPICrALzQhQb7goQVAr6GJ5BlOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obNKrn5Dq9wjgIV8XFt4gM0wbzLiP/Gu5m8MauDd5nd7hAmPKWz2xDLGBT+3j2+exhnCkEFpuERPhD1a9JHZoqq7pp2a/WglTWqGijpj37jPJhhAIYTSq6SIxUZxJFO8wV1G3WVh9ZacGyodxMJ6u17bzKK0ksIbsMj21Cg4RtdmSUBeCvladGt7mSCGul2H8P99ipJYCK27RGBAGyJ5qnSGlA4Mf9lmGQgoyveJQCnPC6sDXNcSrQc0yfCNth/81b+PoaDOrVQvFZh1Z87rMuKMowAF1qVHH2dx7hEzT5C89ZshJFlcZWi3x07OTgTpBgv7fRe13zRdXZkf3Nnh0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qMxpX3Va; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+ce5019daea4c3780914a+8226+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qMxpX3Va;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+ce5019daea4c3780914a+8226+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPhCW7520z2xGF
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 01:29:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sFdR4sdgk264z4O4HPICrALzQhQb7goQVAr6GJ5BlOc=; b=qMxpX3VaorqWRddb5pftIav8yq
	9grcS2zdOqZ2V4B5Z1lTbe5TFN/iG7d+IWwxVSBeU8lTg+B3pQp39RM34zpF41/q63KjTkE7ipFrM
	T3pJxio4mCFgyd4splGECCVBrAkc95RR2mYMrxf8mKRWY13GqGp5H5Cx1O1UYRHUS8uM7y7sxEBbD
	5CRHEbCB/ODYXarRUElW/jlaxj3e2AXy5IzbwujgT+mIHp17CeG88mXPMksMwIFzkqF6gKTb135fm
	Lz8/QgWFXX43eGA8Em56UHiRO+7nx0QPG/NiaYUdD6IT+93yN7LWaoVHcHGygLFXsBxwGac4RMhKz
	4K0gsRRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx4HE-0000000DEjm-1paI;
	Mon, 02 Mar 2026 14:29:40 +0000
Date: Mon, 2 Mar 2026 06:29:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, jiucheng.xu@amlogic.com,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
	tuan.zhang@amlogic.com, Gao Xiang <xiang@kernel.org>,
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
Message-ID: <aaWe1PsmzYatc_zR@infradead.org>
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
 <aaWVwH_Xna22DTAq@infradead.org>
 <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
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
In-Reply-To: <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 7AFF81DACD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2458-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:hch@infradead.org,m:jiucheng.xu@amlogic.com,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianxin.pan@amlogic.com,m:tuan.zhang@amlogic.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 10:23:04PM +0800, Gao Xiang wrote:
> > > I've trimmed down the call stack, as follows:
> > > 
> > > f2fs_submit_read_io
> > >    submit_bio
> > >      mmc_blk_mq_recovery
> > >        z_erofs_endio
> > >          vm_map_ram
> > 
> > ->bi_end_io code really should not be having random in_atomic()
> > checks that make it completely different, but even if they have
> 
> Thanks for the head-up.
> 
> For this part, I'm pretty sure we need this particular one
> otherwise the scheduling performance (latency sensitive)
> is unacceptable for all Android phone users.

Where do you regularly get user context calls to ->bi_end_io?


